#!c:/perl -w
use DBI;
use CGI;

$obj=new CGI;
$invoice_no=$obj->param('invoice_no');

$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";

$out =$dbh->prepare("select * from client_table where c_invoice = '$invoice_no'");
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
&nbsp;<br><br>
<!--Heading and top links table-------------------->
<table border="2" width="50%" align="center" height="25" cellspacing="0" cellpading="0">
<tr align="center">
<td width="25%"><a href="../newhome.html">MAIN MENU</a></td>
</tr>
</table>

<form name="info"
      action="../cgi/changedebtorstatus.pl"
      method="post">
<input name="C_id" type="hidden" value="$row[0]">
<input name="C_invoice" type="hidden" value="$row[19]">
</center>
<br>
<div align="left">
  <table border="1" cellpadding="0" cellspacing="0"width="175" height="24">
    <tr>
      <td width="175" height="24">
      <p align="center"><b>INVOICE NO: $row[19]</b></td>
    </tr>
  </table>
</div>
<div align="center">
  <center>
  <table border="1" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td width="107" align="center"><b>DATE</b></td>
      <td width="133" align="center"><b>NAME</b></td>
      <td width="150" align="center"><b>AGENT</b></td>
      <td width="176" align="center"><b>FROM</b></td>
      <td width="183" align="center"><b>TO</b></td>
      <td width="136" align="center"><b>TOTAL</b></td>
    </tr>
    <tr>
      <td width="107" align="center">$row[1]</td>
      <td width="133" align="center">$row[2]</td>
      <td width="150" align="center">$row[13]</td>
      <td width="176" align="center">$row[6]</td>
      <td width="183" align="center">$row[7]</td>
      <td width="136" align="center">R$row[18]</td>
    </tr>
    <tr>
      <td width="107" align="center">&nbsp;$row[8]</td>
      <td width="133" align="center">&nbsp;</td>
      <td width="150" align="center">&nbsp;</td>
      <td width="176" align="center">&nbsp;$row[11]</td>
      <td width="183" align="center">&nbsp;$row[12]</td>
      <td width="136" align="center">&nbsp;</td>
    </tr>
</table>
<br>
<table>
<tr>
<td>
<select name="c_status">
<option>STILL DUE</option>
<option>CASH</option>
<option>DIRECT DEPOSIT</option>
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
<input type="submit" value="CHANGE STATUS">
</td>
</tr>
</table>

</center>
</div>

</form>
</body>
</html>

html_doc


exit;
