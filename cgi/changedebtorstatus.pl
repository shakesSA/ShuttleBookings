#!c:/perl -w

use CGI;
use DBI;

$obj=new CGI;

$C_status=$obj->param('c_status');
$C_id=$obj->param('C_id');
$C_invoice=$obj->param('C_invoice');

$C_id =~ s/\'//g; 
$C_invoice =~ s/\'//g; 
$C_status =~ s/\'//g; 

$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";


#TESTING**********************

$out =$dbh->do("update client_table set C_status = '$C_status' where C_id = '$C_id'")

 || die

print <<html_doc;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<head>

<meta name="description" content="????">
<meta name="keywords" content="????">
<title>
PERSONALIZED TOURS AND TRANSFERS - Client Register
</title>
<link rel="stylesheet" type="text/css" href="../js/style.css"> 
</head>

<body>

<!--Heading and top links table-------------------->
<table border="0" width="50%" align="center" height="1" cellspacing="0" cellpading="0">
<img src="../LOGO.jpg" width=950 alt="P T & T">
</table>

<table align="center">
<tr>
<td width="100%"><font color="white">CLIENT REGISTRATION<br>Sorry but that Client was not updated !!!</font></td>
</tr>

</table>


</body>

</html>
html_doc




#actual results page
print <<html_doc;
<html>

<HEAD>

<title>PERSONALIZED TOURS AND TRANSFERS</title>
<link rel="stylesheet" type="text/css" href="../js/style.css"> 
</HEAD>

<body link="black" alink="black" vlink="black">

<center>

<img src="../LOGO.jpg" width=650 alt="P T & T">
<br><br>
<!--Heading and top links table-------------------->
<table border="2" width="50%" align="center" height="25" cellspacing="0" cellpading="0">
<tr align="center">
<td width="25%"><a href="../newhome.html">MAIN MENU</a></td>
</tr>
</table>
<br>
<table border="2" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>CLIENT STATUS WITH INVOICE NUMBER: $C_invoice HAS BEEN UPDATED.</font></td>
</tr>
</table>

</center>

</body>
</html>
html_doc

$rc = $dbh->disconnect;

exit;
