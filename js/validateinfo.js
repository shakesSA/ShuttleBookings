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



function clientinfo(info) {

	if (!checknulls(info.CD_date.value))
		{ alert("Please Enter The Date");
		  info.CD_date.focus();
		  info.CD_date.select();
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

		return true;
}

function reportinfo(info) {

	if (!checknulls(info.r_year.value))
		{ alert("Please Enter A Year");
		  info.r_year.focus();
		  info.r_year.select();
		  return false;
		}
	
	if (!checknulls(info.r_month.value))
		{ alert("Please Enter A Month");
		  info.r_month.focus();
		  info.r_month.select();
		  return false;
		}

	if (!checknulls(info.r_day.value))
		{ alert("Please Enter A Day");
		  info.r_day.focus();
		  info.r_day.select();
		  return false;
		}

	return true;
}