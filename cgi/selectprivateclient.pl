#!c:/perl -w
use DBI;
use CGI;

$obj=new CGI;


$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";
## CHANGE TO SELECT CLIENT WHERE AGENT = PRIVATE!!
$out =$dbh->prepare("select distinct C_name from client_table where A_name = 'private' order by c_name");
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
      action="../cgi/privateclientselected.pl"
      method="post">

<p align="center">

<table border="2" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>ADD A PRIVATE CLIENT</font></td>
</tr>
</table>
<br>

<table border="0" cellpading="0" cellspacing="0" width=50%>

<tr>
<td>
<a href="../addclientprivate.html">ADD NEW PRIVATE CLIENT</a>
</td>
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td>
<img src="../buttons/existingclient.png">
</td>
<td>
<select name="C_nameselected" >
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
<input type="submit" value="SELECT CLIENT">
</td>
</tr>

</table>
</form>

End_of_text

$out =$dbh->prepare("select distinct C_name from client_table where A_name = 'private' order by c_name");
$out->execute;

print <<End_of_text;

<form name="info"
      action="../cgi/privateclientupdated.pl"
      method="post">

<p align="center">

<table border="2" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>UPDATE A PRIVATE CLIENT</font></td>
</tr>
</table>
<br>

<table border="0" cellpading="0" cellspacing="0" width=50%>

<tr>
<td>
<img src="../buttons/existingclient.png">
</td>
<td>
<select name="C_nameselected" >
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
<input type="submit" value="UPDATE CLIENT">
</td>
</tr>

</table>
</form>


</body>

</html>
End_of_text

$out =$dbh->prepare("select C_id, C_name, C_invoice from client_table where A_name = 'private' order by c_name");
$out->execute;

print <<End_of_text;

<form name="info"
      action="../cgi/privateclientdeleted.pl"
      method="post">

<p align="center">

<table border="2" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>DELETE A PRIVATE CLIENT</font></td>
</tr>
</table>
<br>

<table border="0" cellpading="0" cellspacing="0" width=50%>

<tr>
<td>
<img src="../buttons/existingclient.png">
</td>
<td>
<select name="C_nameselected" >
<option selected></option>

End_of_text

while (@row = $out->fetchrow_array)
		{
		print "<option>$row[0]:$row[1]:$row[2]</option>";
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
<input type="submit" value="DELETE CLIENT">
</td>
</tr>

</table>
</form>


</body>

</html>
End_of_text

$rc = $dbh->disconnect;
exit;