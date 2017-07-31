#!c:/perl -w
use DBI;
use CGI;

$obj=new CGI;
$C_nameselected=$obj->param('C_nameselected');

@array = split(/:/,scalar $C_nameselected);


$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";

$out =$dbh->prepare("select * from client_table where c_id = '$array[0]'");
$out->execute;
@row = $out->fetchrow_array;

print <<html_doc;
<html>

<HEAD>
<title>PERSONALIZED TOURS AND TRANSFERS</title>
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
      action="../cgi/deleteworkprivate.pl"
      method="post">

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
$row[2]
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
$row[3]
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
$row[1]
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
$row[4]
</td>

<td>
<img src="/buttons/flightno.png">
</td>
<td>
$row[5]
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
$row[6]
</td>

<td>
<img src="/buttons/addressto.png">
</td>
<td>
$row[7]
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
$row[8]
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
$row[9]
</td>

<td>
<img src="/buttons/flightno.png">
</td>
<td>
$row[10]
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
$row[11]
</td>


<td>
<img src="/buttons/addressto.png">
</td>
<td>
$row[12]
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
$row[17]
</td>
<tr>

</table>

<br>

<table align=left>

<tr>
<td>
<input type="submit" value="DELETE">
</td>
</tr>

</table>

</form>

</center>

</body>
</html>
html_doc


exit;
