#!c:/perl -w
use DBI;
use CGI;

$obj=new CGI;

$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";

$out =$dbh->prepare("select * from client_table order by C_invoice desc");
$out->execute;




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
<td width="100%"><font color="black"><b>REPORT ON ALL WORK</font></td>
</tr>
</table>
<br>


<table border=5 cellpading="0" cellspacing="1" width=100%>

<tr bgcolor=maroon align=center> <td width=10%><img src="/buttons/name.png"></td> <td width=10%><img src="/buttons/telno.png"></td> <td width=10%><img src="/buttons/date.png"></td> <td width=15%><img src="/buttons/addressfrom.png"></td> <td width=15%><img src="/buttons/addressto.png"></td> <td width=10%><img src="/buttons/flightno.png"></td> <td width=10%><img src="/buttons/invno.png"></td>
End_of_text


while (@row = $out->fetchrow_array)
		{

			
			print "<tr bgcolor=aquamarine> <td>$row[2]</td> <td>$row[3]</td> <td>$row[1]</td> <td>$row[6]</td> <td>$row[7]</td> <td>$row[5]</td> <td>$row[15]</td>";
		
		}

print <<End_of_text;

</table>
</p>

</body>

</html>
End_of_text
$rc = $dbh->disconnect;
exit;
