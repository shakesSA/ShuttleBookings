#!c:/perl -w
use DBI;
use CGI;

$obj=new CGI;


$dbh = DBI->connect('DBI:mysql:Pick up') || die "connection error: $!";

$out =$dbh->prepare("select * from agent_table");
$out->execute;




print <<End_of_text;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<head>

<meta name="description" content="????">
<meta name="keywords" content="????">
<title>
PERSONALIZED TOURS AND TRANSFERS - Register a Client
</title>

<!----<link rel="stylesheet" type="text/css" href="../stylesheets/register.css">--->

<script language="javascript" src="../js/regval.js"></script>

</head>

<body>

<!--Heading and top links table-------------------->
<table border="0" width="50%" align="center" height="1" cellspacing="0" cellpading="0">
<img src="../LOGO.jpg" width=950 alt="P T & T">
</table>

<form name="info"
      action="../cgi/addwork.pl"
      method="POST">

<p align="center">

<table border="5" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center" bgcolor="white">
<td width="100%"><font color="black"><b>CLIENT DETAILS</font></td>
</tr>
</table>
<br>
<table border="0" cellpading="0" cellspacing="0" width=100%>

<tr>
<td>
<b>Date (CCYY-MM-DD)          :
</td>
<td>
<input name="C_date" type="date" size="10" maxlength="10">
</td>

</tr>

<tr>
<td>
&nbsp
</td>
</tr>


<tr>
<td>
<b>First Name          :
</td>
<td>
<input name="C_name" type="text" size="30" maxlength="30">
</td>
<td>
<b>Last Name          :
</td>
<td>
<input name="C_surname" type="text" size="30" maxlength="30">
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<b>Company Name          :
</td>
<td>
<input name="C_company_name" type="text" size="30" maxlength="30">
</td>
</tr>


<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<b>Telephone Number      :
</td>
<td>
<input name="C_telno" type="text" size="25" maxlength="25"
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<b>Pick Up Time      :
</td>
<td>
<input name="C_pickup_time" type="text" size="25" maxlength="25"
</td>

<td>
<b>Flight Number      :
</td>
<td>
<input name="C_flight_no" type="text" size="25" maxlength="25"
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<b>Address From      :
</td>
<td>
<textarea name="C_address_from" cols="20" rows="5"></textarea>
</td>


<td>
<b>Address To      :
</td>
<td>
<textarea name="C_address_to" cols="20" rows="5"></textarea>
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<b>Agent        :
</td>
<td>
<select name="C_agent" >
<option selected></option>
End_of_text


while (@row = $out->fetchrow_array)
		{

			
			print "<option>$row[1] $row[2] - $row[5] </option>";
		
		}

print <<End_of_text;
</select>
</td>
<td>
<b>Complete          :
</td>
<td>
<select name="C_status" >
<option selected></option>
<option>Yes</option>
<option>No</option>
</select>
</td>
</tr>

</table>
</p>

<table>

<tr>
<td>
<input type="submit" value="ADD"><input type="reset" value="RESET">
</td>
</tr>

</table>

</form>

</body>

</html>
End_of_text
$rc = $dbh->disconnect;
exit;