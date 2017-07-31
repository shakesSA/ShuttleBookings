function checknulls(fld) {
	if (fld == "")
		{
		return false;
		}
	else return true;
}

function checknum(fld) {
	var fld2 = fld.search("[A-Za-z]");

	if (fld2 == 0)
		{ 
		return false;
		}
	else return true;
}

function checkalpha(fld) {
	var fld2 = fld.search("[0-9]");

	if (fld2 == 0)
		{ 
		return false;
		}
	else return true;
}

function istelno(telno)
{
  var result = false
  $theStr = new String(telno)
  var index1 = index($theStr, "(");

  if (index1 >= 0)
  {
    
	result = true;
  }

  return result;
}

function clientinfo(info) {

	if (!checknulls(info.C_date.value))
		{ alert("Please Enter The Date");
		  info.C_date.focus();
		  info.C_date.select();
		  return false;
		}

	if (!checknulls(info.C_name.value))
		{ alert("Please Enter The Clients Name");
		  info.C_name.focus();
		  info.C_name.select();
		  return false;
		}

	if (!checknulls(info.C_telno.value))
		{ alert("Please Enter The Clients Telephone number");
		  info.C_telno.focus();
		  info.C_telno.select();
		  return false;
		}

	if (!checknulls(info.C_pickuptime.value))
		{ alert("Please Enter The Pick Up Time");
		  info.C_pickuptime.focus();
		  info.C_pickuptime.select();
		  return false;
		}

	if (!checknulls(info.C_flightno.value))
		{ alert("Please Enter The Clients Flight Number");
		  info.C_flightno.focus();
		  info.C_flightno.select();
		  return false;
		}

	if (!checknulls(info.C_addressfrom.value))
		{ alert("Please Enter The Address From");
		  info.C_addressfrom.focus();
		  info.C_addressfrom.select();
		  return false;
		}

	if (!checknulls(info.C_addressto.value))
		{ alert("Please Enter The Address To");
		  info.C_addressto.focus();
		  info.C_addressto.select();
		  return false;
		}

	if (!checknulls(info.A_name.value))
		{ alert("Please Enter The Agents Name");
		  info.A_name.focus();
		  info.A_name.select();
		  return false;
		}

	if (!checknulls(info.A_consultant.value))
		{ alert("Please Enter The Consultants Name");
		  info.A_consultant.focus();
		  info.A_consultant.select();
		  return false;
		}

	if (!checknulls(info.A_telno.value))
		{ alert("Please Enter The Telephone Number");
		  info.A_telno.focus();
		  info.A_telno.select();
		  return false;
		}

	if (!checknulls(info.A_faxno.value))
		{ alert("Please Enter The Fax Number");
		  info.A_faxno.focus();
		  info.A_faxno.select();
		  return false;
		}


	if (!checkalpha(info.A_consultant.value))
		{ alert("Field Should Not Contain Numerics");
		  info.A_consultant.focus();
		  info.A_consultant.select();
		  return false;
		}

	return true;
}

function reportinfo(info) {

	if (!checknulls(info.r_date.value))
		{ alert("Please Enter A Date");
		  info.r_date.focus();
		  info.r_date.select();
		  return false;
		}

	return true;
}
