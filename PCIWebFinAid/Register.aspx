﻿<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="Register.aspx.cs" Inherits="PCIWebFinAid.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<!--#include file="IncludeMain.htm" -->
	<title>FinAid : Register</title>
	<link rel="stylesheet" href="CSS/FinAid.css" type="text/css" />
	<link rel="shortcut icon" href="gfx/favicon.ico" />
	<meta content="width=device-width, initial-scale=1, maximum-scale=1" name="viewport" />
</head>
<body>
<form id="frmRegister" runat="server">

<script type="text/javascript">
var firstPage = 1;
var lastPage  = 5;
var pageNo    = firstPage;

function NextPage(inc)
{
	try
	{
		if ( inc > 0 && ! ValidatePage(0) )
			return;

		if ( inc > 0 && pageNo < lastPage )
			pageNo++;
		else if ( inc < 0 && pageNo > firstPage )
			pageNo--;
		else if ( inc != 0 )
			return;

		ShowElt('divP01'  ,pageNo==1);
		ShowElt('divP02'  ,pageNo==2);
		ShowElt('divP03'  ,pageNo==3);
		ShowElt('divP04'  ,pageNo==4);
		ShowElt('divP05'  ,pageNo==5);
		ShowElt('btnBack' ,pageNo> firstPage);
		ShowElt('btnNext' ,pageNo< lastPage);
		ShowElt('btnAgree',pageNo==lastPage);

		if ( pageNo == lastPage )
		{
			var dt = new Date();
			var dd = dt.getDate();
			var mm = dt.getMonth()+1;
			var yy = dt.getFullYear();
			if ( dd > 9 )
				dd = dd.toString();
			else
				dd = '0'+dd.toString();
			if ( mm > 9 )
				mm = mm.toString();
			else
				mm = '0'+mm.toString();
			yy = yy.toString();
			SetEltValue('spnDate',yy+'/'+mm+'/'+dd);
		}
	}
	catch (x)
	{
		alert(x.message);
	}
}
function ShowTick(err,ctl,seq)
{
	if ( seq == 2 )
		GetElt('img'+ctl).src = 'Images/' + ( err.length > 0 ? 'Cross' : 'Tick' ) + '.png';
}
function ValidatePage(ctl,seq)
{
	var err = "";
	var p;

	try
	{
		if ( ( pageNo == 1 && ctl == 0 ) || ctl == 101 )
		{
			p   = Validate('lstTitle','lblTitleError',3,lblTitleError.title,73,0);
			err = err + p;
			ShowTick(p,'Title',seq);
		}
		if ( ( pageNo == 1 && ctl == 0 ) || ctl == 102 )
		{
			p   = Validate('txtSurname','lblSurnameError',1,lblSurnameError.title,2,2);
			err = err + p;
			ShowTick(p,'Surname',seq);
		}
		if ( ( pageNo == 1 && ctl == 0 ) || ctl == 103 )
		{
			p   = Validate('txtCellNo','lblCellNoError',7,lblCellNoError.title);
			err = err + p;
			ShowTick(p,'CellNo',seq);
		}

		if ( pageNo == 2 )
			err = Validate('txtFirstName','errFirstName',1,errFirstName.title,2,2)
			    + Validate('txtEMail','errEMail',5,errEMail.title)
			    + Validate('txtID','errID',1,errID.title,2,4);
		else if ( pageNo == 3 )
			err = Validate('txtIncome','errIncome',6,errIncome.title,3,100)
			    + Validate('lstStatus','errStatus',3,errStatus.title,73,0)
			    + Validate('lstPayDay','errPayDay',3,errPayDay.title,73,0);
		else if ( pageNo == 4 )
			err = Validate('lstOptions','errOptions',3,errOptions.title,73,0)
			    + Validate('chkTerms','errTerms',8,errTerms.title,2)
			    + Validate('lstPayment','errPayment',3,errPayment.title,73,0);
		else if ( pageNo == 5 )
			err = Validate('txtCCNumber','errCCNumber',6,errCCNumber.title,71)
			    + Validate('txtCCName','errCCName',1,errCCName.title,2,2)
			    + Validate('lstCCMonth','errCCExpiry',3,errCCExpiry.title,73,0)
			    + Validate('lstCCYear','errCCExpiry',3,errCCExpiry.title,73,0)
			    + Validate('txtCCCVV','errCCCVV',6,errCCCVV.title,2,9999);
	}
	catch (x)
	{
		err = "Y";
	}
	return ( err.length == 0 );
}
function Help(onOrOff,ctl,item)
{
	try
	{
		if ( onOrOff > 0 )
		{
			var h = GetEltValue('hdn'+item+'Help');
			ShowPopup('divHelp',h,null,null,ctl);
		}
		else
			ShowElt('divHelp',false);
	}
	catch (x)
	{ }
}

//
function TestSetup()
{
	SetEltValue("hdnTitleHelp"  ,"Please choose a title");
	SetEltValue("hdnSurnameHelp","Please enter your surname");
	SetEltValue("hdnCellNoHelp" ,"Please enter your mobile phone number");

	GetElt("lblTitleError").title   = "Choose a title from the list";
	GetElt("lblSurnameError").title = "Please enter a valid surname";
	GetElt("lblCellNoError").title  = "Please enter a valid mobile phone number";
}
//

</script>

<input type="hidden" id="hdnPageNo" value="1" />

<div id="divP01">
<p class="Header4">
(1) <asp:Literal runat="server" ID="lblSubHead1Label">Welcome</asp:Literal>
</p>
<table>
	<tr>
		<td class="DataLabel">
			<asp:Literal runat="server" ID="lblTitleLabel">Title</asp:Literal></td>
		<td style="white-space:nowrap">
			<asp:DropDownList runat="server" CssClass="DataInput" ID="lstTitle" onfocus="JavaScript:ValidatePage(101,1)" onblur="JavaScript:ValidatePage(101,2)">
				<asp:ListItem Value="0" Text="Select Title"></asp:ListItem>
				<asp:ListItem Value="1" Text="Mr"></asp:ListItem>
				<asp:ListItem Value="2" Text="Mrs"></asp:ListItem>
				<asp:ListItem Value="3" Text="Miss"></asp:ListItem>
				<asp:ListItem Value="4" Text="Dr"></asp:ListItem>
				<asp:ListItem Value="5" Text="Prof"></asp:ListItem>
			</asp:DropDownList>
			<a href="#" onmouseover="JavaScript:Help(1,this,'Title')" onmouseout="JavaScript:Help(0)">?</a></td>
		<td>
			<img id="imgTitle" />
			<asp:HiddenField runat="server" ID="hdnTitleHelp" /></td>
		<td class="Error">
			<asp:Label runat="server" id="lblTitleError"></asp:Label></td></tr>
	<tr>
		<td class="DataLabel">
			<asp:Literal runat="server" ID="lblSurnameLabel">Surname</asp:Literal></td>
		<td style="white-space:nowrap">
			<asp:TextBox runat="server" CssClass="DataInput" ID="txtSurname" onfocus="JavaScript:ValidatePage(102,1)" onblur="JavaScript:ValidatePage(102,2)"></asp:TextBox>
			<a href="#" onmouseover="JavaScript:Help(1,this,'Surname')" onmouseout="JavaScript:Help(0)">?</a></td>
		<td>
			<img id="imgSurname" />
			<asp:HiddenField runat="server" ID="hdnSurnameHelp" /></td>
		<td class="Error">
			<asp:Label runat="server" id="lblSurnameError"></asp:Label></td></tr>
	<tr>
		<td class="DataLabel">
			<asp:Literal runat="server" ID="lblCellNoLabel">Mobile number</asp:Literal></td>
		<td style="white-space:nowrap">
			<asp:TextBox runat="server" CssClass="DataInput" ID="txtCellNo" onfocus="JavaScript:ValidatePage(103,1)" onblur="JavaScript:ValidatePage(103,2)"></asp:TextBox>
			<a href="#" onmouseover="JavaScript:Help(1,this,'CellNo')" onmouseout="JavaScript:Help(0)">?</a></td>
		<td>
			<img id="imgCellNo" />
			<asp:HiddenField runat="server" ID="hdnCellNoHelp" /></td>
		<td class="Error">
			<asp:Label runat="server" id="lblCellNoError"></asp:Label></td></tr>
</table>
</div>

<div id="divHelp" class="PopupBox" style="visibility:hidden"></div>

<div id="divP02">
<p class="Header4">
(2) <asp:Literal runat="server" ID="lblSubHead2Label"></asp:Literal>
</p>
<table>
	<tr>
		<td style="width:209px"><asp:Literal runat="server" ID="lblFirstName"></asp:Literal></td>
		<td><asp:TextBox runat="server" ID="txtFirstName" Width="209px" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()"></asp:TextBox> ?&nbsp;&nbsp;</td>
		<td id="errFirstName" title="Please enter your First Name"></td></tr>
	<tr>
		<td><asp:Literal runat="server" ID="lblEMail"></asp:Literal></td>
		<td><asp:TextBox runat="server" ID="txtEMail" Width="209px" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()"></asp:TextBox> ?</td>
		<td id="errEMail" title="Please enter a valid email address"></td></tr>
	<tr>
		<td><asp:Literal runat="server" ID="lblID"></asp:Literal></td>
		<td><asp:TextBox runat="server" ID="txtID" Width="209px" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()"></asp:TextBox> ?</td>
		<td id="errID" title="Please enter your identity number"></td></tr>
</table>
</div>

<div id="divP03">
<p class="Header4">
(3) <asp:Literal runat="server" ID="lblSubHead3Label"></asp:Literal>
</p>
<table>
	<tr>
		<td style="width:209px"><asp:Literal runat="server" ID="lblIncome"></asp:Literal></td>
		<td><asp:TextBox runat="server" ID="txtIncome" Width="209px" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()"></asp:TextBox> ?</td>
		<td id="errIncome" title="Your total monthly income after statutory deductions"></td></tr>
	<tr>
		<td><asp:Literal runat="server" ID="lblStatus"></asp:Literal></td>
		<td>
			<asp:DropDownList runat="server" ID="lstStatus" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()" Width="209px">
				<asp:ListItem Value="0" Text="Select Employment Status"></asp:ListItem>
				<asp:ListItem Value="1" Text="Fixed Term"></asp:ListItem>
				<asp:ListItem Value="2" Text="Permanent"></asp:ListItem>
				<asp:ListItem Value="3" Text="Project Based"></asp:ListItem>
				<asp:ListItem Value="4" Text="Casual"></asp:ListItem>
				<asp:ListItem Value="5" Text="No Contract"></asp:ListItem>
				<asp:ListItem Value="6" Text="Training Agreement"></asp:ListItem>
			</asp:DropDownList> ?</td>
		<td id="errStatus" title="Please choose an employment status"></td></tr>
	<tr>
		<td><asp:Literal runat="server" ID="lblPayDay"></asp:Literal></td>
		<td>
			<asp:DropDownList runat="server" ID="lstPayDay" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()" Width="209px">
				<asp:ListItem Value="0" Text="Select Pay Day"></asp:ListItem>
				<asp:ListItem Value="1" Text="Monthly on the 1'st"></asp:ListItem>
				<asp:ListItem Value="2" Text="Monthly on the 8'th"></asp:ListItem>
				<asp:ListItem Value="3" Text="Monthly on the 15'th"></asp:ListItem>
				<asp:ListItem Value="4" Text="Monthly on the 21'st"></asp:ListItem>
				<asp:ListItem Value="5" Text="Monthly on the 25'th"></asp:ListItem>
				<asp:ListItem Value="6" Text="Monthly on the last day"></asp:ListItem>
			</asp:DropDownList> ?</td>
		<td id="errPayDay" title="Please choose your pay day"></td></tr>
</table>
</div>

<div id="divP04">
<p class="Header4">
(4) <asp:Literal runat="server" ID="lblSubHead4Label"></asp:Literal> <!-- Congratulations! Your product options are: -->
</p>
Product Options&nbsp;&nbsp;
<asp:DropDownList runat="server" ID="lstOptions" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()">
	<asp:ListItem Value="0" Text="Select Product Option"></asp:ListItem>
	<asp:ListItem Value="1" Text="Bronze"></asp:ListItem>
	<asp:ListItem Value="2" Text="Silver"></asp:ListItem>
	<asp:ListItem Value="3" Text="Gold"></asp:ListItem>
</asp:DropDownList> ?&nbsp;&nbsp;&nbsp;&nbsp;
<span id="errOptions" title="Please choose one of the product options"></span>
<p class="Header4">
I confirm having read and understood each of ...
</p>
<asp:CheckBox runat="server" ID="chkTerms" onclick="JavaScript:ValidatePage()" /> Terms & Conditions ?&nbsp;&nbsp;&nbsp;&nbsp;
<span id="errTerms" title="Please confirm that you have read and understood all the terms and conditions"></span><br /><br />
Payment Method&nbsp;&nbsp;
<asp:DropDownList runat="server" ID="lstPayment" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()">
	<asp:ListItem Value="0" Text="Select Payment Method"></asp:ListItem>
	<asp:ListItem Value="1" Text="Debit my Visa or MasterCard"></asp:ListItem>
</asp:DropDownList> ?&nbsp;&nbsp;&nbsp;&nbsp;
<span id="errPayment" title="Please choose a payment method"></span><br /><br />
PLEASE NOTE: We are accepting your application based on the information you provided.
</div>

<div id="divP05">
<p class="Header4">
(5) Card Information
</p>
<table>
	<tr>
		<td>Card Number</td>
		<td><asp:TextBox runat="server" ID="txtCCNumber" Width="320px" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()"></asp:TextBox> ?&nbsp;&nbsp;</td>
		<td id="errCCNumber" title="Please enter your credit/debit card number"></td></tr>
	<tr>
		<td>Name on Card</td>
		<td><asp:TextBox runat="server" ID="txtCCName" Width="320px" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()"></asp:TextBox> ?</td>
		<td id="errCCName" title="Please enter the name on your credit/debit card"></td></tr>
	<tr>
		<td>Expiry Date</td>
		<td>
			<asp:DropDownList runat="server" ID="lstCCMonth" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()">
				<asp:ListItem Value= "1" Text="01 (January)"></asp:ListItem>
				<asp:ListItem Value= "2" Text="02 (February)"></asp:ListItem>
				<asp:ListItem Value= "3" Text="03 (March)"></asp:ListItem>
				<asp:ListItem Value= "4" Text="04 (April)"></asp:ListItem>
				<asp:ListItem Value= "5" Text="05 (May)"></asp:ListItem>
				<asp:ListItem Value= "6" Text="06 (June)"></asp:ListItem>
				<asp:ListItem Value= "7" Text="07 (July)"></asp:ListItem>
				<asp:ListItem Value= "8" Text="08 (August)"></asp:ListItem>
				<asp:ListItem Value= "9" Text="09 (September)"></asp:ListItem>
				<asp:ListItem Value="10" Text="10 (October)"></asp:ListItem>
				<asp:ListItem Value="11" Text="11 (November)"></asp:ListItem>
				<asp:ListItem Value="12" Text="12 (December)"></asp:ListItem>
			</asp:DropDownList>&nbsp;
			<asp:DropDownList runat="server" ID="lstCCYear" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()">
				<asp:ListItem Value= "2018" Text="2018"></asp:ListItem>
				<asp:ListItem Value= "2019" Text="2019"></asp:ListItem>
				<asp:ListItem Value= "2020" Text="2020"></asp:ListItem>
				<asp:ListItem Value= "2021" Text="2021"></asp:ListItem>
				<asp:ListItem Value= "2022" Text="2022"></asp:ListItem>
				<asp:ListItem Value= "2023" Text="2023"></asp:ListItem>
				<asp:ListItem Value= "2024" Text="2024"></asp:ListItem>
				<asp:ListItem Value= "2025" Text="2025"></asp:ListItem>
				<asp:ListItem Value= "2026" Text="2026"></asp:ListItem>
				<asp:ListItem Value= "2027" Text="2027"></asp:ListItem>
				<asp:ListItem Value= "2028" Text="2028"></asp:ListItem>
				<asp:ListItem Value= "2029" Text="2029"></asp:ListItem>
			</asp:DropDownList> ?</td>
		<td id="errCCExpiry" title="Please select your card's date (month and year)"></td></tr>
	<tr>
		<td>CVV Code</td>
		<td><asp:TextBox runat="server" ID="txtCCCVV" Width="40px" onfocus="JavaScript:ValidatePage()" onblur="JavaScript:ValidatePage()"></asp:TextBox> ?&nbsp;&nbsp;</td>
		<td id="errCCCVV" title="Please enter your card CVV number"></td></tr>
</table>
<div style="background-color:lightgray">
<p style="color:orange;font-weight:bold;font-size:20px">
COLLECTION MANDATE : <span id="spnDate"></span>
</p><p>
You hereby authorise and instruct us to collect all money due by you from your Card listed above or any other card that you may indicate from time to time.
</p><p>
You confirm that you are the account holder or have authority to give us this mandate.
</p><p>
You hereby authorise and instruct us to collect your registration fee immediately or as soon as possible.
</p><p>
You hereby authorise and instruct us to deduct your monthly subscription fees on, or as close as possible to your indicated Pay Day.
</p><p>
You will ensure that sufficient funds are available in your account to cover these deductions and we may track your account and re-present the deductions should the transactions fail.
</p><p>
This collection mandate will stay in force until you cancel it by giving us at least 30 days prior written notice to the client care email address listed in the Contact Us section of this website.
</p>
</div>
</div>

<br />
<input type="button" id="btnBack"  value="<< BACK" onclick="JavaScript:NextPage(-1)" />
<input type="button" id="btnNext"  value="NEXT >>" onclick="JavaScript:NextPage(1)"  />
<input type="button" id="btnAgree" value="I Agree" />
<br /><br />

<asp:Literal runat="server" ID="lblJS"></asp:Literal>

</form>
</body>
</html>
