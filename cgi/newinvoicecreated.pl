#!c:/perl -w
use DBI;
use CGI;

$obj=new CGI;
$invoice_no=$obj->param('invoice_no');
$invoice_no2=$obj->param('invoice_no2');
$commperc=$obj->param('commperc');

if ($invoice_no eq "")
{
	$invno = $invoice_no2;
}
else
{
	$invno = $invoice_no;
}

$dbh = DBI->connect('DBI:mysql:PTT') || die "connection error: $!";

$out =$dbh->prepare("select * from client_table where c_invoice = '$invno'");
$out->execute;
@row = $out->fetchrow_array;

if ($row[13] eq "PRIVATE")
{
    $invname = $row[2];
}
else 
{
    $invname = $row[13];
}

$commperc = $commperc / 100;
$comm = $row[18] * $commperc;
$printcomm = sprintf("%.2f", $comm);

$total = $row[18] - $comm;
$printtotal = sprintf("%.2f", $total);

$filename =  $row[1] . ' ' . $row[13] . '.csv';

open (INVOICE, ">c:/invoices/$filename");
print INVOICE $row[19] . ',' . $row[13] . ',' . $row[1] . ',' . $row[18] . ',' . $printcomm . ',' . $printtotal;
close INVOICE;


if ($row[1] ne "0000-00-00" && $row[8] ne "0000-00-00")

{
print <<html_doc;

<html>

<HEAD>
<title>PERSONALIZED TOURS AND TRANSFERS</title>
<script language="javascript" src="../js/validateinfo.js"></script>
<link rel="stylesheet" type="text/css" href="../js/style.css"> 
</HEAD>

<body bgcolor="white" link="black" alink="black" vlink="black">

<center>
<H1>PERSONALIZED TOURS AND TRANSFERS</H1>

<!--Heading and top links table-------------------->
<table border="2" width="50%" align="center" height="25" cellspacing="0" cellpading="0">
<tr align="center">
<td width="25%"><a href="../newhome.html">MAIN MENU</a></td>
</tr>
<tr align="center">
<td width="25%">
<a href="mailto:$A_email
?subject=PERSONALIZED%20TOURS%20AND%20TRANSFERS%20INVOICE%20DETAILS
&body=CLIENT DETAILS%0D%0A
INVOICE NO: $row[19]%0D%0A
INVOICE DATE: $row[1]%0D%0A
CLIENT NAME: $row[2]%0D%0A
AGENT NAME: $row[13]%0D%0A%0D%0A

DEPARTURE INFO%0D%0A
DATE: $row[1]%0D%0A
ADDRESS FROM: $row[6]%0D%0A
ADDRESS TO: $row[7]%0D%0A%0D%0A

RETURN INFO%0D%0A
DATE: $row[8]%0D%0A
ADDRESS FROM: $row[11]%0D%0A
ADDRESS TO: $row[12]%0D%0A%0D%0A

AMOUNTS%0D%0A
TOTAL: R$row[18]%0D%0A
COMMISSION: R$printcomm%0D%0A
NETT TOTAL: R$printtotal%0D%0A%0D%0A

Please make cheques payable to:%0D%0A
PERSONALIZED TOURS AND TRANSFERS %0D%0A
TERMS: CASH%0D%0A%0D%0A

BANKING DETAILS%0D%0A
Bank : ABSA%0D%0A
Branch : Main Road Claremont%0D%0A
Type of Account : Cheque Account%0D%0A 
Branch Code : 421109%0D%0A 
Account No : 4059457080%0D%0A 
Internet ABSA Online : 4059457080%0D%0A 

">
E-MAIL</a>
</td>
</tr>
</table>

<form name="info">


<table border="1" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>Invoice for </b></font><b>$invname<font color="black"> 
on </font><font size="2">$row[1]</font></b></td>
</tr>
</table>
<br>
<div align="left">
  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="56">
    <tr>
      <td width="17%" height="56"><b>$invname</td>
      <td width="17%" height="56">&nbsp;</td>
      <td width="17%" height="56">&nbsp;</td>
      <td width="17%" height="56">&nbsp;</td>
      <td width="32%" height="56"><b>DATE: $row[1]</b></td>
    </tr>
  </table>
</div>

<table border="0" cellpading="0" cellspacing="0" width=75%>

</table>

</form>

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
  <table border="1" cellpadding="0" cellspacing="0" width="100%" height="218">
    <tr>
      <td width="107" height="28" align="center"><b>DATE</b></td>
      <td width="133" height="28" align="center"><b>NAME</b></td>
      <td width="150" height="28" align="center"><b>AGENT</b></td>
      <td width="176" height="28" align="center"><b>FROM</b></td>
      <td width="183" height="28" align="center"><b>TO</b></td>
      <td width="136" height="28" align="center"><b>TOTAL</b></td>
    </tr>
    <tr>
      <td width="107" height="23" align="center">$row[1]</td>
      <td width="133" height="23" align="center">$row[2]</td>
      <td width="150" height="23" align="center">$row[13]</td>
      <td width="176" height="23" align="center">$row[6]</td>
      <td width="183" height="23" align="center">$row[7]</td>
      <td width="136" height="23" align="center">R$row[18]</td>
    </tr>
    <tr>
      <td width="107" height="23" align="center">&nbsp;$row[8]</td>
      <td width="133" height="23" align="center">&nbsp;</td>
      <td width="150" height="23" align="center">&nbsp;</td>
      <td width="176" height="23" align="center">&nbsp;$row[11]</td>
      <td width="183" height="23" align="center">&nbsp;$row[12]</td>
      <td width="136" height="23" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td width="107" height="23" align="center">&nbsp;</td>
      <td width="133" height="23" align="center">&nbsp;</td>
      <td width="150" height="23" align="center">&nbsp;</td>
      <td width="176" height="23" align="center">&nbsp;</td>
      <td width="183" height="23" align="center">&nbsp;</td>
      <td width="136" height="23" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td width="107" height="22" align="center">&nbsp;</td>
      <td width="133" height="22" align="center">&nbsp;</td>
      <td width="150" height="22" align="center">&nbsp;</td>
      <td width="176" height="22" align="center">&nbsp;</td>
      <td width="183" height="22" align="center">&nbsp;</td>
      <td width="136" height="22" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td width="107" height="22" align="center">&nbsp;</td>
      <td width="133" height="22" align="center">&nbsp;</td>
      <td width="150" height="22" align="center">&nbsp;</td>
      <td width="176" height="22" align="center">&nbsp;</td>
      <td width="183" height="22" align="center">&nbsp;</td>
      <td width="136" height="22" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td width="566" height="46" align="center" colspan="4" rowspan="2">&nbsp;</td>
      <td width="183" height="22" align="center"><b>COMM</b></td>
      <td width="136" height="22" align="center">R$printcomm</td>
    </tr>
    <tr>
      <td width="183" height="24" align="center"><b>TOTAL</b></td>
      <td width="136" height="24" align="center">R$printtotal</td>
    </tr>
  </table>
  </center>
</div>
<br>
<div align="left">
  <table border="0" cellpadding="0" cellspacing="0" width="201" height="19">
    <tr>
      <td width="201" height="19">
      <p align="center"><u><font size="2">Please make cheques payable to:</font></u></td>
    </tr>
  </table>
</div>

<div align="left">
  <table border="0" cellpadding="0" cellspacing="0" width="240" height="21">
    <tr>
      <td width="240" height="21"><b><font size="2">PERSONALIZED TOURS &amp; 
      TRANSFERS</font></b></td>
    </tr>
  </table>
</div>

<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="22">
    <tr>
      <td width="112" height="22">&nbsp;</td>
      <td width="112" height="22">&nbsp;</td>
      <td width="112" height="22">&nbsp;</td>
      <td width="112" height="22">&nbsp;</td>
      <td width="111" height="22">&nbsp;</td>
      <td width="111" height="22">&nbsp;</td>
      <td width="111" height="22">
      <p align="center"><b><font size="2">TERMS: CASH</font></b></td>
      <td width="111" height="22">&nbsp;</td>
    </tr>
  </table>
  </center>
</div>
<br>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="21">
    <tr>
      <td width="888" height="21">
      <p align="center"><b><font size="2">BANKING DETAILS</font></b></td>
    </tr>
  </table>
  </center>
</div>

<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="899" height="35">
    <tr>
      <td width="130" height="3"><b><font size="2">Bank</font></b></td>
      <td width="23" height="3" align="center"><b>:</b></td>
      <td width="742" height="3"><b><font size="2">ABSA</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Branch</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">Main Road Claremont</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Type of Account</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">Cheque Account</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Branch Code</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">421109</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Account No</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">4059457080</font></b></td>
    </tr>
    <tr>
      <td width="130" height="1"><b><font size="2">Internet ABSA Online</font></b></td>
      <td width="23" height="1" align="center"><b>:</b></td>
      <td width="742" height="1"><b><font size="2">4059457080</font></b></td>
    </tr>
  </table>
  </center>
</div>

</body>
</html>

html_doc
}

elsif ($row[1] ne "0000-00-00")

{
print <<html_doc;

<html>

<HEAD>
<title>PERSONALIZED TOURS AND TRANSFERS</title>
<script language="javascript" src="../js/validateinfo.js"></script>
<link rel="stylesheet" type="text/css" href="../js/style.css"> 
</HEAD>

<body bgcolor="white" link="black" alink="black" vlink="black">

<center>
<H1>PERSONALIZED TOURS AND TRANSFERS</H1>
<!--Heading and top links table-------------------->
<table border="2" width="50%" align="center" height="25" cellspacing="0" cellpading="0">
<tr align="center">
<td width="25%"><a href="../newhome.html">MAIN MENU</a></td>
</tr>
<tr align="center">
<td width="25%">
<a href="mailto:$A_email
?subject=PERSONALIZED%20TOURS%20AND%20TRANSFERS%20INVOICE%20DETAILS
&body=CLIENT DETAILS%0D%0A
INVOICE NO: $row[19]%0D%0A
INVOICE DATE: $row[1]%0D%0A
CLIENT NAME: $row[2]%0D%0A
AGENT NAME: $row[13]%0D%0A%0D%0A

DEPARTURE INFO%0D%0A
DATE: $row[1]%0D%0A
ADDRESS FROM: $row[6]%0D%0A
ADDRESS TO: $row[7]%0D%0A%0D%0A

AMOUNTS%0D%0A
TOTAL: R$row[18]%0D%0A
COMMISSION: R$printcomm%0D%0A
NETT TOTAL: R$printtotal%0D%0A%0D%0A

Please make cheques payable to:%0D%0A
PERSONALIZED TOURS AND TRANSFERS %0D%0A
TERMS: CASH%0D%0A%0D%0A

BANKING DETAILS%0D%0A
Bank : ABSA%0D%0A
Branch : Main Road Claremont%0D%0A
Type of Account : Cheque Account%0D%0A 
Branch Code : 421109%0D%0A 
Account No : 4059457080%0D%0A 
Internet ABSA Online : 4059457080%0D%0A 

">
E-MAIL</a>
</td>
</tr>
</table>

<form name="info">


<table border="1" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>Invoice for </b></font><b>$invname<font color="black"> 
on </font><font size="2">$row[1]</font></b></td>
</tr>
</table>
<br>
<div align="left">
  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="56">
    <tr>
      <td width="17%" height="56"><b>$invname</td>
      <td width="17%" height="56">&nbsp;</td>
      <td width="17%" height="56">&nbsp;</td>
      <td width="17%" height="56">&nbsp;</td>
      <td width="32%" height="56"><b>DATE: $row[1]</b></td>
    </tr>
  </table>
</div>

<table border="0" cellpading="0" cellspacing="0" width=75%>

</table>

</form>

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
  <table border="1" cellpadding="0" cellspacing="0" width="100%" height="218">
    <tr>
      <td width="107" height="28" align="center"><b>DATE</b></td>
      <td width="133" height="28" align="center"><b>NAME</b></td>
      <td width="150" height="28" align="center"><b>AGENT</b></td>
      <td width="176" height="28" align="center"><b>FROM</b></td>
      <td width="183" height="28" align="center"><b>TO</b></td>
      <td width="136" height="28" align="center"><b>TOTAL</b></td>
    </tr>
    <tr>
      <td width="107" height="23" align="center">$row[1]</td>
      <td width="133" height="23" align="center">$row[2]</td>
      <td width="150" height="23" align="center">$row[13]</td>
      <td width="176" height="23" align="center">$row[6]</td>
      <td width="183" height="23" align="center">$row[7]</td>
      <td width="136" height="23" align="center">R$row[18]</td>
    </tr>
    <tr>
      <td width="107" height="23" align="center">&nbsp;</td>
      <td width="133" height="23" align="center">&nbsp;</td>
      <td width="150" height="23" align="center">&nbsp;</td>
      <td width="176" height="23" align="center">&nbsp;</td>
      <td width="183" height="23" align="center">&nbsp;</td>
      <td width="136" height="23" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td width="107" height="22" align="center">&nbsp;</td>
      <td width="133" height="22" align="center">&nbsp;</td>
      <td width="150" height="22" align="center">&nbsp;</td>
      <td width="176" height="22" align="center">&nbsp;</td>
      <td width="183" height="22" align="center">&nbsp;</td>
      <td width="136" height="22" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td width="107" height="22" align="center">&nbsp;</td>
      <td width="133" height="22" align="center">&nbsp;</td>
      <td width="150" height="22" align="center">&nbsp;</td>
      <td width="176" height="22" align="center">&nbsp;</td>
      <td width="183" height="22" align="center">&nbsp;</td>
      <td width="136" height="22" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td width="566" height="46" align="center" colspan="4" rowspan="2">&nbsp;</td>
      <td width="183" height="22" align="center"><b>COMM</b></td>
      <td width="136" height="22" align="center">R$printcomm</td>
    </tr>
    <tr>
      <td width="183" height="24" align="center"><b>TOTAL</b></td>
      <td width="136" height="24" align="center">R$printtotal</td>
    </tr>
  </table>
  </center>
</div>
<br>
<div align="left">
  <table border="0" cellpadding="0" cellspacing="0" width="201" height="19">
    <tr>
      <td width="201" height="19">
      <p align="center"><u><font size="2">Please make cheques payable to:</font></u></td>
    </tr>
  </table>
</div>

<div align="left">
  <table border="0" cellpadding="0" cellspacing="0" width="240" height="21">
    <tr>
      <td width="240" height="21"><b><font size="2">PERSONALIZED TOURS &amp; 
      TRANSFERS</font></b></td>
    </tr>
  </table>
</div>

<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="22">
    <tr>
      <td width="112" height="22">&nbsp;</td>
      <td width="112" height="22">&nbsp;</td>
      <td width="112" height="22">&nbsp;</td>
      <td width="112" height="22">&nbsp;</td>
      <td width="111" height="22">&nbsp;</td>
      <td width="111" height="22">&nbsp;</td>
      <td width="111" height="22">
      <p align="center"><b><font size="2">TERMS: CASH</font></b></td>
      <td width="111" height="22">&nbsp;</td>
    </tr>
  </table>
  </center>
</div>
<br>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="21">
    <tr>
      <td width="888" height="21">
      <p align="center"><b><font size="2">BANKING DETAILS</font></b></td>
    </tr>
  </table>
  </center>
</div>

<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="899" height="35">
    <tr>
      <td width="130" height="3"><b><font size="2">Bank</font></b></td>
      <td width="23" height="3" align="center"><b>:</b></td>
      <td width="742" height="3"><b><font size="2">ABSA</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Branch</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">Main Road Claremont</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Type of Account</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">Cheque Account</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Branch Code</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">421109</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Account No</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">4059457080</font></b></td>
    </tr>
    <tr>
      <td width="130" height="1"><b><font size="2">Internet ABSA Online</font></b></td>
      <td width="23" height="1" align="center"><b>:</b></td>
      <td width="742" height="1"><b><font size="2">4059457080</font></b></td>
    </tr>
  </table>
  </center>
</div>

</body>
</html>

html_doc
}

else

{
print <<html_doc;

<html>

<HEAD>
<title>PERSONALIZED TOURS AND TRANSFERS</title>
<script language="javascript" src="../js/validateinfo.js"></script>
<link rel="stylesheet" type="text/css" href="../js/style.css"> 
</HEAD>

<body bgcolor="white" link="black" alink="black" vlink="black">

<center>
<H1>PERSONALIZED TOURS AND TRANSFERS</H1>
<!--Heading and top links table-------------------->
<table border="2" width="50%" align="center" height="25" cellspacing="0" cellpading="0">
<tr align="center">
<td width="25%"><a href="../newhome.html">MAIN MENU</a></td>
</tr>
<tr align="center">
<td width="25%">
<a href="mailto:$A_email
?subject=PERSONALIZED%20TOURS%20AND%20TRANSFERS%20INVOICE%20DETAILS
&body=CLIENT DETAILS%0D%0A
INVOICE NO: $row[19]%0D%0A
INVOICE DATE: $row[8]%0D%0A
CLIENT NAME: $row[2]%0D%0A
AGENT NAME: $row[13]%0D%0A%0D%0A

RETURN INFO%0D%0A
DATE: $row[8]%0D%0A
ADDRESS FROM: $row[11]%0D%0A
ADDRESS TO: $row[12]%0D%0A%0D%0A

AMOUNTS%0D%0A
TOTAL: R$row[18]%0D%0A
COMMISSION: R$printcomm%0D%0A
NETT TOTAL: R$printtotal%0D%0A%0D%0A

Please make cheques payable to:%0D%0A
PERSONALIZED TOURS AND TRANSFERS %0D%0A
TERMS: CASH%0D%0A%0D%0A

BANKING DETAILS%0D%0A
Bank : ABSA%0D%0A
Branch : Main Road Claremont%0D%0A
Type of Account : Cheque Account%0D%0A 
Branch Code : 421109%0D%0A 
Account No : 4059457080%0D%0A 
Internet ABSA Online : 4059457080%0D%0A 

">
E-MAIL</a>
</td>
</tr>
</table>

<form name="info">


<table border="1" width="100%" align="center" height="1" cellspacing="0" cellpading="0">
<tr align="center">
<td width="100%"><font color="black"><b>Invoice for </b></font><b>$invname<font color="black"> 
on </font><font size="2">$row[8]</font></b></td>
</tr>
</table>
<br>
<div align="left">
  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="56">
    <tr>
      <td width="17%" height="56"><b>$invname</td>
      <td width="17%" height="56">&nbsp;</td>
      <td width="17%" height="56">&nbsp;</td>
      <td width="17%" height="56">&nbsp;</td>
      <td width="32%" height="56"><b>DATE: $row[8]</b></td>
    </tr>
  </table>
</div>

<table border="0" cellpading="0" cellspacing="0" width=75%>

</table>

</form>

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
  <table border="1" cellpadding="0" cellspacing="0" width="100%" height="218">
    <tr>
      <td width="107" height="28" align="center"><b>DATE</b></td>
      <td width="133" height="28" align="center"><b>NAME</b></td>
      <td width="150" height="28" align="center"><b>AGENT</b></td>
      <td width="176" height="28" align="center"><b>FROM</b></td>
      <td width="183" height="28" align="center"><b>TO</b></td>
      <td width="136" height="28" align="center"><b>TOTAL</b></td>
    </tr>
    <tr>
      <td width="107" height="23" align="center">&nbsp;$row[8]</td>
      <td width="133" height="23" align="center">$row[2]</td>
      <td width="150" height="23" align="center">$row[13]</td>
      <td width="176" height="23" align="center">$row[11]</td>
      <td width="183" height="23" align="center">$row[12]</td>
      <td width="136" height="23" align="center">R$row[18]</td>
    </tr>
    <tr>
      <td width="107" height="23" align="center">&nbsp;</td>
      <td width="133" height="23" align="center">&nbsp;</td>
      <td width="150" height="23" align="center">&nbsp;</td>
      <td width="176" height="23" align="center">&nbsp;</td>
      <td width="183" height="23" align="center">&nbsp;</td>
      <td width="136" height="23" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td width="107" height="22" align="center">&nbsp;</td>
      <td width="133" height="22" align="center">&nbsp;</td>
      <td width="150" height="22" align="center">&nbsp;</td>
      <td width="176" height="22" align="center">&nbsp;</td>
      <td width="183" height="22" align="center">&nbsp;</td>
      <td width="136" height="22" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td width="107" height="22" align="center">&nbsp;</td>
      <td width="133" height="22" align="center">&nbsp;</td>
      <td width="150" height="22" align="center">&nbsp;</td>
      <td width="176" height="22" align="center">&nbsp;</td>
      <td width="183" height="22" align="center">&nbsp;</td>
      <td width="136" height="22" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td width="566" height="46" align="center" colspan="4" rowspan="2">&nbsp;</td>
      <td width="183" height="22" align="center"><b>COMM</b></td>
      <td width="136" height="22" align="center">R$printcomm</td>
    </tr>
    <tr>
      <td width="183" height="24" align="center"><b>TOTAL</b></td>
      <td width="136" height="24" align="center">R$printtotal</td>
    </tr>
  </table>
  </center>
</div>
<br>
<div align="left">
  <table border="0" cellpadding="0" cellspacing="0" width="201" height="19">
    <tr>
      <td width="201" height="19">
      <p align="center"><u><font size="2">Please make cheques payable to:</font></u></td>
    </tr>
  </table>
</div>

<div align="left">
  <table border="0" cellpadding="0" cellspacing="0" width="240" height="21">
    <tr>
      <td width="240" height="21"><b><font size="2">PERSONALIZED TOURS &amp; 
      TRANSFERS</font></b></td>
    </tr>
  </table>
</div>

<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="22">
    <tr>
      <td width="112" height="22">&nbsp;</td>
      <td width="112" height="22">&nbsp;</td>
      <td width="112" height="22">&nbsp;</td>
      <td width="112" height="22">&nbsp;</td>
      <td width="111" height="22">&nbsp;</td>
      <td width="111" height="22">&nbsp;</td>
      <td width="111" height="22">
      <p align="center"><b><font size="2">TERMS: CASH</font></b></td>
      <td width="111" height="22">&nbsp;</td>
    </tr>
  </table>
  </center>
</div>
<br>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="21">
    <tr>
      <td width="888" height="21">
      <p align="center"><b><font size="2">BANKING DETAILS</font></b></td>
    </tr>
  </table>
  </center>
</div>

<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="899" height="35">
    <tr>
      <td width="130" height="3"><b><font size="2">Bank</font></b></td>
      <td width="23" height="3" align="center"><b>:</b></td>
      <td width="742" height="3"><b><font size="2">ABSA</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Branch</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">Main Road Claremont</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Type of Account</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">Cheque Account</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Branch Code</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">421109</font></b></td>
    </tr>
    <tr>
      <td width="130" height="12"><b><font size="2">Account No</font></b></td>
      <td width="23" height="12" align="center"><b>:</b></td>
      <td width="742" height="12"><b><font size="2">4059457080</font></b></td>
    </tr>
    <tr>
      <td width="130" height="1"><b><font size="2">Internet ABSA Online</font></b></td>
      <td width="23" height="1" align="center"><b>:</b></td>
      <td width="742" height="1"><b><font size="2">4059457080</font></b></td>
    </tr>
  </table>
  </center>
</div>

</body>
</html>

html_doc
}

exit;
