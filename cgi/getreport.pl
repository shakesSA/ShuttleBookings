#!c:/perl -w
use DBI;
use CGI;

$obj=new CGI;

$r_year=$obj->param('r_year');
$r_month=$obj->param('r_month');
$r_day=$obj->param('r_day');
$r_year =~ s/\'//g; 
$r_month =~ s/\'//g; 
$r_day =~ s/\'//g;

$r_date = $r_year . "-" . $r_month . "-" . $r_day;

#print $r_date;
 
$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";
$out =$dbh->prepare("delete from tmp_table");
$out->execute;
$rc = $dbh->disconnect;

$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";
$out2 =$dbh->prepare("INSERT INTO tmp_table
(name, telno, ptime, addressfrom, addressto, flightno, invoiceno)
SELECT c_name, c_telno, cd_pickuptime, cd_addressfrom, cd_addressto, cd_flightno, c_invoice
FROM client_table
where cd_date = '$r_date'");
$out2->execute;
$rc = $dbh->disconnect;

$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";
$out3 =$dbh->prepare("INSERT INTO tmp_table
(name, telno, ptime, addressfrom, addressto, flightno, invoiceno)
SELECT c_name, c_telno, cr_pickuptime, cr_addressfrom, cr_addressto, cr_flightno, c_invoice
FROM client_table
where cr_date = '$r_date'");
$out3->execute;
$rc = $dbh->disconnect;

$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";
$out4 =$dbh->prepare("SELECT * from tmp_table order by ptime");
$out4->execute;
#$rc = $dbh->disconnect;


print <<End_of_text;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<head>

<meta name="description" content="????">
<meta name="keywords" content="????">
<title>
PERSONALIZED TOURS AND TRANSFERS - Daily Report
</title>
<link rel="stylesheet" type="text/css" href="../js/style.css"> 
</head>

<body>


<!--Heading and top links table-------------------->
<table border="0" width="50%" align="center">
<H1>PERSONALIZED TOURS AND TRANSFERS</H1>
</table>

<table border="2" width="50%" align="center" height="25" cellspacing="0" cellpading="0">
<tr align="center">
<td width="25%"><a href="../newhome.html">MAIN MENU</a></td>
</tr>
</table>

<p align="center">

<table border="2" width="100%" align="center">
<tr align="center">
<td width="100%"><font color="black"><b>DAILY REPORT FOR $r_date</font></td>
</tr>
</table>
<br>

<table border=3 cellpading="0" cellspacing="0" width=100%>

<tr width=100% bgcolor=maroon align=center> <td><img src="/buttons/name.png" width=110></td> <td><img src="/buttons/telno.png" width=110></td> <td><img src="/buttons/pickuptime.png" width=105></td> <td><img src="/buttons/addressfrom.png" width=110></td> <td><img src="/buttons/addressto.png" width=110></td> <td><img src="/buttons/flightno.png" width=110></td> <td><img src="/buttons/invno.png" width=110></td> <td><img src="/buttons/driver.png" width=110></td>
End_of_text


while (@row = $out4->fetchrow_array)
		{
			print "<tr width=100% bgcolor=aquamarine> <td>$row[0]</td> <td>$row[1]</td> <td>$row[2]</td> <td>$row[3]</td> <td>$row[4]</td> <td>$row[5]</td> <td>$row[6]</td> <td>$nbsp</td>";
		}

print <<End_of_text;

</table>
</p>

</body>

</html>
End_of_text

exit;
