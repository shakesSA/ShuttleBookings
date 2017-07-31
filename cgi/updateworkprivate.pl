#!c:/perl -w

use CGI;
use DBI;

$obj=new CGI;

$C_invoice=$obj->param('C_invoice');
$C_id=$obj->param('C_id');
$C_name=$obj->param('C_name');
$C_telno=$obj->param('C_telno');

$CD_date=$obj->param('CD_date');
$CD_pickuptime=$obj->param('CD_pickuptime');
$CD_flightno=$obj->param('CD_flightno');
$CD_addressfrom=$obj->param('CD_addressfrom');
$CD_addressto=$obj->param('CD_addressto');

$CR_date=$obj->param('CR_date');
$CR_pickuptime=$obj->param('CR_pickuptime');
$CR_flightno=$obj->param('CR_flightno');
$CR_addressfrom=$obj->param('CR_addressfrom');
$CR_addressto=$obj->param('CR_addressto');

$A_instructions=$obj->param('A_instructions');
$C_payment=$obj->param('C_payment');
$C_returninfo=$obj->param('C_returninfo');
$C_manner=$obj->param('C_manner');


$C_invoice =~ s/\'//g; 
$C_name =~ s/\'//g; 
$C_name =~ s/\&/and/g; 
$C_telno =~ s/\'//g;


$CD_date =~ s/\'//g;  
$CD_pickuptime =~ s/\'//g; 
$CD_flightno =~ s/\'//g; 
$CD_addressfrom =~ s/\'//g; 
$CD_addressfrom =~ s/\&/and/g; 
$CD_addressto =~ s/\'//g; 
$CD_addressto =~ s/\&/and/g; 

$CR_date =~ s/\'//g;  
$CR_pickuptime =~ s/\'//g; 
$CR_flightno =~ s/\'//g; 
$CR_addressfrom =~ s/\'//g; 
$CR_addressfrom =~ s/\&/and/g; 
$CR_addressto =~ s/\'//g; 
$CR_addressto =~ s/\&/and/g; 

$A_name =~ s/\'//g; 
$A_name =~ s/\&/and/g; 
$A_consultant =~ s/\'//g; 
$A_consultant =~ s/\&/and/g; 
$A_telno =~ s/\'//g; 
$A_faxno =~ s/\'//g; 
$A_instructions =~ s/\'//g; 
$A_instructions =~ s/\&/and/g; 
$C_payment =~ s/\'//g; 
$A_email =~ s/\'//g; 
$C_manner =~ s/\'//g; 

$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";


#TESTING**********************

$out =$dbh->do("update client_table set CD_date = '$CD_date', CR_date = '$CR_date', C_name = '$C_name', C_telno = '$C_telno', CD_pickuptime = '$CD_pickuptime', CR_pickuptime = '$CR_pickuptime', CD_flightno = '$CD_flightno', CR_flightno = '$CR_flightno', CD_addressfrom = '$CD_addressfrom', CR_addressfrom = '$CR_addressfrom', CD_addressto = '$CD_addressto', CR_addressto = '$CR_addressto', A_instructions = '$A_instructions', C_payment = '$C_payment' where C_id = '$C_id'")

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
<td width="100%"><font color="white">CLIENT REGISTRATION<br>Sorry but that Client was not processed !!!</font></td>
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

<!---<img src="../LOGO.jpg" width=650 alt="P T & T">--->
<H1>PERSONALIZED TOURS AND TRANSFERS</H1>


<!--Heading and top links table-------------------->
<table border="2" width="50%" align="center" height="25" cellspacing="0" cellpading="0">
<tr align="center">
<td width="25%"><a href="../newhome.html">MAIN MENU</a></td>
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
$CD_date
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
$C_name
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
$C_telno
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<img src="/buttons/invno.png">
</td>
<td>
$C_invoice
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
$CD_pickuptime
</td>

<td>
<img src="/buttons/flightno.png">
</td>
<td>
$CD_flightno
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
$CD_addressfrom
</td>


<td>
<img src="/buttons/addressto.png">
</td>
<td>
$CD_addressto
</td>
</tr>

</table>

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
$CR_date
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
$CR_pickuptime
</td>

<td>
<img src="/buttons/flightno.png">
</td>
<td>
$CR_flightno
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
$CR_addressfrom
</td>


<td>
<img src="/buttons/addressto.png">
</td>
<td>
$CR_addressto
</td>
</tr>

</table>
<br>
<table border="0" cellpading="0" cellspacing="0" width=75%>

<tr>
<td>
<img src="/buttons/specialinstructions.png">
</td>
<td>
$A_instructions
</td>

</table>

<table border="2" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>Completed by Personalized Tours and Transfers</font></td>
</tr>
</table>
<br>
<table border="0" cellpading="0" cellspacing="0" width=75%>

<tr>
<td>
<img src="/buttons/cashdirectdeposit.png">
</td>
<td>
$C_payment
</td>
<td>
$C_manner
<td>
<td>
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<td>
</tr>

</table>



</center>

</body>
</html>
html_doc

$rc = $dbh->disconnect;

exit;
