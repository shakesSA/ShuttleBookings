#!c:/perl -w
use DBI;
use CGI;

$obj=new CGI;
$C_nameselected=$obj->param('C_nameselected');

$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";

$out =$dbh->prepare("select * from client_table where c_name = '$C_nameselected' order by C_id desc");
$out->execute;
@row = $out->fetchrow_array;

print <<html_doc;
<html>

<HEAD>
<title>PERSONALIZED TOURS AND TRANSFERS</title>
<script language="javascript" src="../js/validateinfo.js"></script>
<link rel="stylesheet" type="text/css" href="../js/style.css"> 
</HEAD>

<body bgcolor="white" link="black" alink="black" vlink="black">

<center>

<img src="../LOGO.jpg" width=650 alt="P T & T">
<br><br>
<!--Heading and top links table-------------------->
<table border="2" width="50%" align="center" height="25" cellspacing="0" cellpading="0">
<tr align="center">
<td width="25%"><a href="../newhome.html">MAIN MENU</a></td>
</tr>
</table>

<form name="info"
      action="../cgi/updateworkprivate.pl"
      method="post" onSubmit="return clientinfo(info)">

<table border="2" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>PRIVATE CLIENT DETAILS</font></td>
</tr>
</table>
<br>

<table border="0" cellpading="0" cellspacing="0" width=75%>

<tr>
<td>
<img src="/buttons/invno.png">
</td>
<td>
$row[19]
<input name="C_id" type="hidden" value="$row[0]">
<input name="C_invoice" type="hidden" value="$row[19]">
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>


<tr>
<td>
<img src="/buttons/name.png">
</td>
<td>
<input name="C_name" type="text" size="40" maxlength="40" value="$row[2]">
</td>

</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<img src="/buttons/telno.png">
</td>
<td>
<input name="C_telno" type="text" size="25" maxlength="25" value="$row[3]">
</td>
</tr>

</table>
<br>

<table border="2" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>DEPARTURE INFO</font></td>
</tr>
</table>
<br>
<table border="0" cellpading="0" cellspacing="0" width=75%>

<tr>
<td>
<img src="/buttons/date.png">
</td>
<td>
<input name="CD_date" type="date" size="10" maxlength="10" value="$row[1]"> <b>&nbsp(CCYY-MM-DD)
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<img src="/buttons/pickuptime.png">
</td>
<td>
<input name="CD_pickuptime" type="text" size="25" maxlength="25" value="$row[4]">
</td>

<td>
<img src="/buttons/flightno.png">
</td>
<td>
<input name="CD_flightno" type="text" size="25" maxlength="25" value="$row[5]">
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<img src="/buttons/addressfrom.png">
</td>
<td>
<textarea name="CD_addressfrom" cols="20" rows="5">$row[6]</textarea>
</td>

<td>
<img src="/buttons/addressto.png">
</td>
<td>
<textarea name="CD_addressto" cols="20" rows="5">$row[7]</textarea>
</td>
</tr>

</table>
<br>

<br>
<table border="2" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>RETURN INFO</font></td>
</tr>
</table>
<br>
<table border="0" cellpading="0" cellspacing="0" width=75%>

<tr>
<td>
<img src="/buttons/date.png">
</td>
<td>
<input name="CR_date" type="date" size="10" maxlength="10" value=$row[8]><b>&nbsp(CCYY-MM-DD)
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<img src="/buttons/pickuptime.png">
</td>
<td>
<input name="CR_pickuptime" type="text" size="25" maxlength="25" value=$row[9]>
</td>

<td>
<img src="/buttons/flightno.png">
</td>
<td>
<input name="CR_flightno" type="text" size="25" maxlength="25" value=$row[10]>
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<img src="/buttons/addressfrom.png">
</td>
<td>
<textarea name="CR_addressfrom" cols="20" rows="5">$row[11]</textarea>
</td>


<td>
<img src="/buttons/addressto.png">
</td>
<td>
<textarea name="CR_addressto" cols="20" rows="5">$row[12]</textarea>
</td>
</tr>


<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<img src="/buttons/specialinstructions.png">
</td>
<td>
<textarea name="A_instructions" cols="30" rows="5">$row[17]</textarea>
</td>
<tr>

</table>

<br>

<table border="2" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>To be filled in by Personalized Tours and Transfers</font></td>
</tr>
</table>
<br>
<table border="0" cellpading="0" cellspacing="0" width=75%>

<tr>
<td>
<img src="/buttons/cashdirectdeposit.png">
</td>
<td>
<input name="C_payment" type="text" size="10" maxlength="10" value="$row[18]">
</td>
<td>
<select name="C_manner" >
<option selected>CASH</option>
<option>DIRECT DEPOSIT</option>
</select>
</td>
</tr>

</table>

<br>

<table align=left>

<tr>
<td>
<input type="submit" value="UPDATE"><input type="reset" value="RESET">
</td>
</tr>

</table>

</form>

</center>

</body>
</html>
html_doc


exit;
