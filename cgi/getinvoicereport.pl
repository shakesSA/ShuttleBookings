#!c:/perl -w
use DBI;
use CGI;

$obj=new CGI;

$s_year=$obj->param('s_year');
$s_month=$obj->param('s_month');
$s_day=$obj->param('s_day');
$e_year=$obj->param('e_year');
$e_month=$obj->param('e_month');
$e_day=$obj->param('e_day');
$s_year =~ s/\'//g; 
$s_month =~ s/\'//g; 
$s_day =~ s/\'//g;
$e_year =~ s/\'//g; 
$e_month =~ s/\'//g; 
$e_day =~ s/\'//g;


$s_date = $s_year . "-" . $s_month . "-" . $s_day;
$e_date = $e_year . "-" . $e_month . "-" . $e_day;

#print $r_date;
 
$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";

##$out =$dbh->prepare("select * from client_table where CD_date >= '$s_date' AND CD_date <= '$e_date' AND A_name != 'private'  order by A_name");
$out =$dbh->prepare("select * from client_table where CD_date >= '$s_date' AND CD_date <= '$e_date' order by CD_date, A_name, C_invoice");
$out->execute;


print <<End_of_text;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<head>

<meta name="description" content="????">
<meta name="keywords" content="????">
<title>
PERSONALIZED TOURS AND TRANSFERS - Invoice Report
</title>
<link rel="stylesheet" type="text/css" href="../js/style.css"> 
</head>

<body>


<!--Heading and top links table-------------------->
<table border="0" width="50%" align="center">
<img src="../LOGO.jpg" width=950 alt="P T & T">
</table>
<br><br>
<table border="2" width="50%" align="center" height="25" cellspacing="0" cellpading="0">
<tr align="center">
<td width="25%"><a href="../newhome.html">MAIN MENU</a></td>
</tr>
</table>

<p align="center">

<table border="2" width="100%" align="center">
<tr align="center">
<td width="100%"><font color="black"><b>INVOICE REPORT FOR $s_date TO $e_date</font></td>
</tr>
</table>
<br>


<table border=3 cellpading="0" cellspacing="0" width=100%>

<tr width=100% bgcolor=maroon align=center> <td><img src="/buttons/date.png" width=110></td> <td><img src="/buttons/agentname.png" width=110></td> <td><img src="/buttons/invno.png" width=105></td> <td><img src="/buttons/name.png" width=110></td> <td><img src="/buttons/payment.png" width=110></td><td><img src="/buttons/status.png" width=110></td>
End_of_text


while (@row = $out->fetchrow_array)
		{

			print "<tr width=100% bgcolor=aquamarine> <td>$row[1]</td> <td>$row[13]</td> <td>$row[19]</td> <td>$row[2]</td> <td>$row[18]</td> <td>$row[20]</td>";
		
		}

print <<End_of_text;

</table>
</p>

</body>

</html>
End_of_text
$rc = $dbh->disconnect;
exit;
