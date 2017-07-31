#!c:/perl -w
use DBI;
use CGI;

$obj=new CGI;


$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";

$out =$dbh->prepare("select C_invoice from client_table order by C_invoice");
$out->execute;

print <<End_of_text;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<head>

<meta name="description" content="????">
<meta name="keywords" content="????">
<title>
PERSONALIZED TOURS AND TRANSFERS - Select A Client
</title>
<link rel="stylesheet" type="text/css" href="../js/style.css"> 
</head>

<body>

<!--Heading and top links table-------------------->
<table border="0" width="50%" align="center" height="1" cellspacing="0" cellpading="0">
<img src="../LOGO.jpg" width=950 alt="P T & T">
</table>
<br><br>
<table border="2" width="50%" align="center" height="25" cellspacing="0" cellpading="0">
<tr align="center">
<td width="25%"><a href="../newhome.html">MAIN MENU</a></td>
</tr>
</table>

<form name="info"
      action="../cgi/newinvoicecreated.pl"
      method="post">

<p align="center">

<table border="2" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>INVOICING</font></td>
</tr>
</table>
<br>

<table border="0" cellpading="0" cellspacing="0" width=50%>
<tr>
<td>
<img src="/buttons/invoicenumber.png">
</td>
<td>
<select name="invoice_no" >
<option selected></option>
End_of_text

while (@row = $out->fetchrow_array)
		{
		print "<option>$row[0]</option>";
		}
print <<End_of_text;

</select>
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<img src="/buttons/invoicenumber.png">
</td>
<td>
<input name="invoice_no2" type="text" size="10" maxlength="10">
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<img src="/buttons/commissionpercentage.png">
</td>
<td>
<select name="commperc">
<option>0</option>
<option>5</option>
<option>10</option>
<option>15</option>
<option>20</option>
<option>25</option>
<option>30</option>
<option>35</option>
<option>40</option>
<option>45</option>
<option>50</option>
</select>
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<input type="submit" value="CREATE INVOICE">
</td>
</tr>

</table>
</form>
</body>

</html>
End_of_text
$rc = $dbh->disconnect;
exit;
