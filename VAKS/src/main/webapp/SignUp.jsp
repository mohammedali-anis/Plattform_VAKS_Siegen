<%@page import="VAKS.run.Model.AppWithDB"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up | Register</title>
</head>
<style>
* {
	margin: 0;
	padding: 0;
}

h1 {
	font-size: 2em;
	font-family: "Core Sans N W01 35 Light";
	font-weight: normal;
	margin: .67em 0;
	display: block;
}

#registered {
	margin-top: 50px;
}

#registered img {
	margin-bottom: 0px;
	width: 100px;
	height: 100px;
}

#registered span {
	clear: both;
	display: block;
}

img {
	margin-bottom: 20px;
}

.avatar {
	margin: 10px 0 20px 0;
}

.module {
	position: relative;
	top: 10%;
	height: 65%;
	width: 450px;
	margin-left: auto;
	margin-right: auto;
}

.user {
	color: #66d8fc;
	font-weight: bold;
}

.userlist {
	float: left;
	padding: 30px;
}

.userlist span {
	color: #0590fc;
}

.welcome {
	position: relative;
	top: 30%;
	height: 65%;
	width: 900px;
	margin-left: auto;
	margin-right: auto;
	margin-top: 50px;
}

::-moz-selection {
	background: #19547c;
}

::selection {
	background: #19547c;
}

input::-moz-selection {
	background: #037db6;
}

input::selection {
	background: #037db6;
}

body {
	color: #fff;
	background-color: #f0f0f0;
	font-family: helvetica;
	background: url('http://clevertechie.com/img/bnet-bg.jpg') #0f2439
		no-repeat center top;
}

.body-content {
	position: relative;
	top: 20px;
	height: 700px;
	width: 800px;
	margin-left: auto;
	margin-right: auto;
	background: transparent;
}

select, textarea, input[type="text"], input[type="password"], input[type="email"], input[type="date"]
	{
	height: 30px;
	width: 100%;;
	display: inline-block;
	vertical-align: middle;
	height: 34px;
	padding: 0 10px;
	margin-top: 3px;
	margin-bottom: 10px;
	font-size: 15px;
	line-height: 20px;
	border: 1px solid rgba(255, 255, 255, 0.3);
	background-color: rgba(0, 0, 0, 0.5);
	color: rgba(255, 255, 255, 0.7);
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	border-radius: 2px;
}

select, textarea, input[type="text"], input[type="password"], input[type="email"]
	{
	-webkit-appearance: none;
	-moz-appearance: none;
	-ms-appearance: none;
	appearance: none;
	-webkit-transition: background-position 0.2s, background-color 0.2s,
		border-color 0.2s, box-shadow 0.2s;
	transition: background-position 0.2s, background-color 0.2s,
		border-color 0.2s, box-shadow 0.2s;
}

select:hover, textarea:hover, input[type="text"]:hover, input[type="password"]:hover,
	input[type="email"]:hover, input[type="date"]:hover {
	border-color: rgba(255, 255, 255, 0.5);
	background-color: rgba(0, 0, 0, 0.5);
	color: rgba(255, 255, 255, 0.7);
}

select:focus, textarea:focus, input[type="text"]:focus, input[type="password"]:focus,
	input[type="email"]:focus, input[type="date"]:focus {
	border: 2px solid;
	border-color: #1e5f99;
	background-color: rgba(0, 0, 0, 0.5);
	color: #ffffff;
}
.TextLabel {
	height: 30px;
	width: 70%;;
	display: inline-block;
	height: 34px;
	padding: 0 10px;
	margin-top: 3px;
	margin-bottom: 10px;
	font-size: 15px;
	line-height: 20px;
	
	
	color: rgba(255, 255, 255, 0.7);
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	border-radius: 2px;
	-webkit-appearance: none;
	-moz-appearance: none;
	-ms-appearance: none;
	appearance: none;
	-webkit-transition: background-position 0.2s, background-color 0.2s,
		border-color 0.2s, box-shadow 0.2s;
	transition: background-position 0.2s, background-color 0.2s,
		border-color 0.2s, box-shadow 0.2s;
}

.TextLabel:focus {
	border: 2px solid;
	border-color: #1e5f99;
	background-color: rgba(0, 0, 0, 0.5);
	color: #ffffff;

}



.btn {
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
	margin: 3px 0;
	padding: 6px 20px;
	font-size: 15px;
	line-height: 20px;
	height: 34px;
	background-color: rgba(0, 0, 0, 0.15);
	color: #00aeff;
	border: 1px solid rgba(255, 255, 255, 0.15);
	box-shadow: 0 0 rgba(0, 0, 0, 0);
	border-radius: 2px;
	-webkit-transition: background-color 0.2s, box-shadow 0.2s,
		background-color 0.2s, border-color 0.2s, color 0.2s;
	transition: background-color 0.2s, box-shadow 0.2s, background-color
		0.2s, border-color 0.2s, color 0.2s;
}

.btn.active, .btn:active {
	padding: 7px 19px 5px 21px;
}

.btn.disabled:active, .btn[disabled]:active, .btn.disabled.active, .btn[disabled].active
	{
	padding: 6px 20px !important;
}

.btn:hover, .btn:focus {
	background-color: rgba(0, 0, 0, 0.25);
	color: #ffffff;
	border-color: rgba(255, 255, 255, 0.3);
	box-shadow: 0 0 rgba(0, 0, 0, 0);
}

.btn:active, .btn.active {
	background-color: rgba(0, 0, 0, 0.15);
	color: rgba(255, 255, 255, 0.8);
	border-color: rgba(255, 255, 255, 0.07);
	box-shadow: inset 1.5px 1.5px 3px rgba(0, 0, 0, 0.5);
}

.btn-primary {
	background-color: #098cc8;
	color: #ffffff;
	border: 1px solid transparent;
	box-shadow: 0 0 rgba(0, 0, 0, 0);
	border-radius: 2px;
	-webkit-transition: background-color 0.2s, box-shadow 0.2s,
		background-color 0.2s, border-color 0.2s, color 0.2s;
	transition: background-color 0.2s, box-shadow 0.2s, background-color
		0.2s, border-color 0.2s, color 0.2s;
	background-image: -webkit-linear-gradient(top, #0f9ada, #0076ad);
	background-image: linear-gradient(to bottom, #0f9ada, #0076ad);
	border: 0;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.3), 0 0 0 1px
		rgba(255, 255, 255, 0.15) inset;
}

.btn-primary:hover, .btn-primary:focus {
	background-color: #21b0f1;
	color: #ffffff;
	border-color: transparent;
	box-shadow: 0 0 rgba(0, 0, 0, 0);
}

.btn-primary:active, .btn-primary.active {
	background-color: #006899;
	color: rgba(255, 255, 255, 0.7);
	border-color: transparent;
	box-shadow: inset 1.5px 1.5px 3px rgba(0, 0, 0, 0.5);
}

.btn-primary:hover, .btn-primary:focus {
	background-image: -webkit-linear-gradient(top, #37c0ff, #0097dd);
	background-image: linear-gradient(to bottom, #37c0ff, #0097dd);
}

.btn-primary:active, .btn-primary.active {
	background-image: -webkit-linear-gradient(top, #006ea1, #00608d);
	background-image: linear-gradient(to bottom, #006ea1, #00608d);
	box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.6) inset, 0 0 0 1px
		rgba(255, 255, 255, 0.07) inset;
}

.btn-block {
	display: block;
	width: 50%;
	padding-left: 0;
	padding-right: 0;
}



.btn2 {
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
	margin: 3px 0;
	padding: 6px 20px;
	font-size: 15px;
	line-height: 20px;
	height: 34px;
	background-color: rgba(220,20,60);
	color: #000000;
	border: 1px solid rgba(255, 255, 255, 0.15);
	box-shadow: 0 0 rgba(0, 0, 0, 0);
	border-radius: 2px;
	-webkit-transition: background-color 0.2s, box-shadow 0.2s,
		background-color 0.2s, border-color 0.2s, color 0.2s;
	transition: background-color 0.2s, box-shadow 0.2s, background-color
		0.2s, border-color 0.2s, color 0.2s;
}

.btn2-block {
	display: block;
	width: 50%;
	padding-left: 0;
	padding-right: 0;
}

.btn.active, .btn:active {
	padding: 7px 19px 5px 21px;
}

.btn.disabled:active, .btn[disabled]:active, .btn.disabled.active, .btn[disabled].active
	{
	padding: 6px 20px !important;
}

.btn:hover, .btn:focus {
	background-color: rgba(0, 0, 0, 0.25);
	color: #ffffff;
	border-color: rgba(255, 255, 255, 0.3);
	box-shadow: 0 0 rgba(0, 0, 0, 0);
}

.btn:active, .btn.active {
	background-color: rgba(0, 0, 0, 0.15);
	color: rgba(255, 255, 255, 0.8);
	border-color: rgba(255, 255, 255, 0.07);
	box-shadow: inset 1.5px 1.5px 3px rgba(0, 0, 0, 0.5);
}

.btn-primary {
	background-color: #098cc8;
	color: #ffffff;
	border: 1px solid transparent;
	box-shadow: 0 0 rgba(0, 0, 0, 0);
	border-radius: 2px;
	-webkit-transition: background-color 0.2s, box-shadow 0.2s,
		background-color 0.2s, border-color 0.2s, color 0.2s;
	transition: background-color 0.2s, box-shadow 0.2s, background-color
		0.2s, border-color 0.2s, color 0.2s;
	background-image: -webkit-linear-gradient(top, #0f9ada, #0076ad);
	background-image: linear-gradient(to bottom, #0f9ada, #0076ad);
	border: 0;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.3), 0 0 0 1px
		rgba(255, 255, 255, 0.15) inset;
}

.btn2-primary:hover, .btn2-primary:focus {
	background-color: #8B0000;
	color: #000000;
	border-color: transparent;
	box-shadow: 0 0 rgba(0, 0, 0, 0);
}

.btn2-primary:active, .btn2-primary.active {
	background-color: #006899;
	color: rgba(255, 255, 255, 0.7);
	border-color: transparent;
	box-shadow: inset 1.5px 1.5px 3px rgba(0, 0, 0, 0.5);
}

.btn2-primary:hover, .btn2-primary:focus {
	background-image: -webkit-linear-gradient(top, #8B0000, #8B0000);
	background-image: linear-gradient(to bottom, #8B0000, #8B0000);
}

.btn2-primary:active, .btn2-primary.active {
	background-image: -webkit-linear-gradient(top, #006ea1, #00608d);
	background-image: linear-gradient(to bottom, #006ea1, #00608d);
	box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.6) inset, 0 0 0 1px
		rgba(255, 255, 255, 0.07) inset;
}

.alert {
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	padding: 4px 20px 4px 20px;
	font-size: 13px;
	line-height: 20px;
	margin-bottom: 20px;
	text-shadow: none;
	position: relative;
	background-color: #272e3b;
	color: rgba(255, 255, 255, 0.7);
	border: 1px solid #000;
	box-shadow: 0 0 0 1px #363d49 inset, 0 5px 10px rgba(0, 0, 0, 0.75);
}

.alert-error {
	color: #f00;
	background-color: #360e10;
	box-shadow: 0 0 0 1px #551e21 inset, 0 5px 10px rgba(0, 0, 0, 0.75);
}

.alert:empty {
	display: none;
}

.alert-success {
	color: #21ec0c;
	background-color: #15360e;
	box-shadow: 0 0 0 1px #2a551e inset, 0 5px 10px rgba(0, 0, 0, 0.75);
}
</style>

<body>

	
	<div class="body-content">
		<div class="module">
			<h1>Create an account</h1>
			<form class="form" action="register" method="post">
				<div class="alert alert-error"></div>
				
				<input type="text" placeholder="First Name" name="firstName" required />
				<input type="text" placeholder="Last Name" name="lastName" required />
				<input type="date" placeholder="Birthday" name="birthday" required />
				<br>
				<label class="TextLabel" for="male">Select you gender: </label>
				<input type="radio" id="male" name="gender" value="male" required>
				<label for="male" style="color: rgba(255, 255, 255, 0.7);">Male</label>
				<input type="radio" id="female" name="gender" value="female" required>
				<label for="female" style="color: rgba(255, 255, 255, 0.7);">Female</label>
				<input type="email" placeholder="Email" name="email" required /> 
				<input type="Text" placeholder="Username" name="userName" required /> 
				<input type="password" placeholder="Password" name="password"  required /> 
				<input type="password" placeholder="Confirm Password" name="confirmpassword" required />
				<select id="country" name="country">
   					<option>Select your country &#9660;</option>
   					<option value="Afganistan">Afghanistan</option>
   					<option value="Albania">Albania</option>
   					<option value="Algeria">Algeria</option>
   					<option value="American Samoa">American Samoa</option>
   					<option value="Andorra">Andorra</option>
   					<option value="Angola">Angola</option>
   					<option value="Anguilla">Anguilla</option>
   					<option value="Antigua & Barbuda">Antigua & Barbuda</option>
   					<option value="Argentina">Argentina</option>
   					<option value="Armenia">Armenia</option>
   					<option value="Aruba">Aruba</option>
   					<option value="Australia">Australia</option>
   					<option value="Austria">Austria</option>
   					<option value="Azerbaijan">Azerbaijan</option>
   					<option value="Bahamas">Bahamas</option>
   					<option value="Bahrain">Bahrain</option>
   					<option value="Bangladesh">Bangladesh</option>
   					<option value="Barbados">Barbados</option>
   					<option value="Belarus">Belarus</option>
   					<option value="Belgium">Belgium</option>
   					<option value="Belize">Belize</option>
   					<option value="Benin">Benin</option>
   					<option value="Bermuda">Bermuda</option>
   					<option value="Bhutan">Bhutan</option>
   					<option value="Bolivia">Bolivia</option>
   					<option value="Bonaire">Bonaire</option>
   					<option value="Bosnia & Herzegovina">Bosnia & Herzegovina</option>
   					<option value="Botswana">Botswana</option>
   					<option value="Brazil">Brazil</option>
   					<option value="British Indian Ocean Ter">British Indian Ocean Ter</option>
   					<option value="Brunei">Brunei</option>
   					<option value="Bulgaria">Bulgaria</option>
   					<option value="Burkina Faso">Burkina Faso</option>
   					<option value="Burundi">Burundi</option>
   					<option value="Cambodia">Cambodia</option>
   					<option value="Cameroon">Cameroon</option>
   					<option value="Canada">Canada</option>
   					<option value="Canary Islands">Canary Islands</option>
   					<option value="Cape Verde">Cape Verde</option>
   					<option value="Cayman Islands">Cayman Islands</option>
   					<option value="Central African Republic">Central African Republic</option>
   					<option value="Chad">Chad</option>
   					<option value="Channel Islands">Channel Islands</option>
   					<option value="Chile">Chile</option>
   					<option value="China">China</option>
   					<option value="Christmas Island">Christmas Island</option>
   					<option value="Cocos Island">Cocos Island</option>
   					<option value="Colombia">Colombia</option>
   					<option value="Comoros">Comoros</option>
   					<option value="Congo">Congo</option>
   					<option value="Cook Islands">Cook Islands</option>
   					<option value="Costa Rica">Costa Rica</option>
   					<option value="Cote DIvoire">Cote DIvoire</option>
   					<option value="Croatia">Croatia</option>
   					<option value="Cuba">Cuba</option>
   					<option value="Curaco">Curacao</option>
   					<option value="Cyprus">Cyprus</option>
   					<option value="Czech Republic">Czech Republic</option>
   					<option value="Denmark">Denmark</option>
   					<option value="Djibouti">Djibouti</option>
   					<option value="Dominica">Dominica</option>
   					<option value="Dominican Republic">Dominican Republic</option>
   					<option value="East Timor">East Timor</option>
   					<option value="Ecuador">Ecuador</option>
   					<option value="Egypt">Egypt</option>
   					<option value="El Salvador">El Salvador</option>
   					<option value="Equatorial Guinea">Equatorial Guinea</option>
   					<option value="Eritrea">Eritrea</option>
   					<option value="Estonia">Estonia</option>
   					<option value="Ethiopia">Ethiopia</option>
   					<option value="Falkland Islands">Falkland Islands</option>
   					<option value="Faroe Islands">Faroe Islands</option>
   					<option value="Fiji">Fiji</option>
   					<option value="Finland">Finland</option>
   					<option value="France">France</option>
   					<option value="French Guiana">French Guiana</option>
   					<option value="French Polynesia">French Polynesia</option>
   					<option value="French Southern Ter">French Southern Ter</option>
   					<option value="Gabon">Gabon</option>
   					<option value="Gambia">Gambia</option>
   					<option value="Georgia">Georgia</option>
   					<option value="Germany">Germany</option>
   					<option value="Ghana">Ghana</option>
   					<option value="Gibraltar">Gibraltar</option>
   					<option value="Great Britain">Great Britain</option>
   					<option value="Greece">Greece</option>
   					<option value="Greenland">Greenland</option>
   					<option value="Grenada">Grenada</option>
   					<option value="Guadeloupe">Guadeloupe</option>
   					<option value="Guam">Guam</option>
   					<option value="Guatemala">Guatemala</option>
   					<option value="Guinea">Guinea</option>
   					<option value="Guyana">Guyana</option>
   					<option value="Haiti">Haiti</option>
   					<option value="Hawaii">Hawaii</option>
   					<option value="Honduras">Honduras</option>
   					<option value="Hong Kong">Hong Kong</option>
   					<option value="Hungary">Hungary</option>
   					<option value="Iceland">Iceland</option>
   					<option value="Indonesia">Indonesia</option>
   					<option value="India">India</option>
   					<option value="Iran">Iran</option>
   					<option value="Iraq">Iraq</option>
   					<option value="Ireland">Ireland</option>
   					<option value="Isle of Man">Isle of Man</option>
   					<option value="Israel">Israel</option>
   					<option value="Italy">Italy</option>
   					<option value="Jamaica">Jamaica</option>
   					<option value="Japan">Japan</option>
   					<option value="Jordan">Jordan</option>
   					<option value="Kazakhstan">Kazakhstan</option>
   					<option value="Kenya">Kenya</option>
   					<option value="Kiribati">Kiribati</option>
   					<option value="Korea North">Korea North</option>
   					<option value="Korea Sout">Korea South</option>
   					<option value="Kuwait">Kuwait</option>
   					<option value="Kyrgyzstan">Kyrgyzstan</option>
   					<option value="Laos">Laos</option>
   					<option value="Latvia">Latvia</option>
   					<option value="Lebanon">Lebanon</option>
   					<option value="Lesotho">Lesotho</option>
   					<option value="Liberia">Liberia</option>
   					<option value="Libya">Libya</option>
   					<option value="Liechtenstein">Liechtenstein</option>
   					<option value="Lithuania">Lithuania</option>
   					<option value="Luxembourg">Luxembourg</option>
   					<option value="Macau">Macau</option>
   					<option value="Macedonia">Macedonia</option>
   					<option value="Madagascar">Madagascar</option>
   					<option value="Malaysia">Malaysia</option>
   					<option value="Malawi">Malawi</option>
   					<option value="Maldives">Maldives</option>
   					<option value="Mali">Mali</option>
   					<option value="Malta">Malta</option>
   					<option value="Marshall Islands">Marshall Islands</option>
   					<option value="Martinique">Martinique</option>
   					<option value="Mauritania">Mauritania</option>
   					<option value="Mauritius">Mauritius</option>
   					<option value="Mayotte">Mayotte</option>
   					<option value="Mexico">Mexico</option>
   					<option value="Midway Islands">Midway Islands</option>
   					<option value="Moldova">Moldova</option>
   					<option value="Monaco">Monaco</option>
   					<option value="Mongolia">Mongolia</option>
   					<option value="Montserrat">Montserrat</option>
   					<option value="Morocco">Morocco</option>
   					<option value="Mozambique">Mozambique</option>
   					<option value="Myanmar">Myanmar</option>
   					<option value="Nambia">Nambia</option>
   					<option value="Nauru">Nauru</option>
   					<option value="Nepal">Nepal</option>
   					<option value="Netherland Antilles">Netherland Antilles</option>
   					<option value="Netherlands">Netherlands (Holland, Europe)</option>
   					<option value="Nevis">Nevis</option>
   					<option value="New Caledonia">New Caledonia</option>
   					<option value="New Zealand">New Zealand</option>
   					<option value="Nicaragua">Nicaragua</option>
   					<option value="Niger">Niger</option>
   					<option value="Nigeria">Nigeria</option>
   					<option value="Niue">Niue</option>
   					<option value="Norfolk Island">Norfolk Island</option>
   					<option value="Norway">Norway</option>
   					<option value="Oman">Oman</option>
   					<option value="Pakistan">Pakistan</option>
   					<option value="Palau Island">Palau Island</option>
   					<option value="Palestine">Palestine</option>
   					<option value="Panama">Panama</option>
   					<option value="Papua New Guinea">Papua New Guinea</option>
   					<option value="Paraguay">Paraguay</option>
   					<option value="Peru">Peru</option>
   					<option value="Phillipines">Philippines</option>
   					<option value="Pitcairn Island">Pitcairn Island</option>
   					<option value="Poland">Poland</option>
   					<option value="Portugal">Portugal</option>
   					<option value="Puerto Rico">Puerto Rico</option>
   					<option value="Qatar">Qatar</option>
   					<option value="Republic of Montenegro">Republic of Montenegro</option>
   					<option value="Republic of Serbia">Republic of Serbia</option>
   					<option value="Reunion">Reunion</option>
   					<option value="Romania">Romania</option>
   					<option value="Russia">Russia</option>
   					<option value="Rwanda">Rwanda</option>
   					<option value="St Barthelemy">St Barthelemy</option>
   					<option value="St Eustatius">St Eustatius</option>
   					<option value="St Helena">St Helena</option>
   					<option value="St Kitts-Nevis">St Kitts-Nevis</option>
   					<option value="St Lucia">St Lucia</option>
   					<option value="St Maarten">St Maarten</option>
   					<option value="St Pierre & Miquelon">St Pierre & Miquelon</option>
   					<option value="St Vincent & Grenadines">St Vincent & Grenadines</option>
   					<option value="Saipan">Saipan</option>
   					<option value="Samoa">Samoa</option>
   					<option value="Samoa American">Samoa American</option>
   					<option value="San Marino">San Marino</option>
   					<option value="Sao Tome & Principe">Sao Tome & Principe</option>
   					<option value="Saudi Arabia">Saudi Arabia</option>
   					<option value="Senegal">Senegal</option>
   					<option value="Seychelles">Seychelles</option>
   					<option value="Sierra Leone">Sierra Leone</option>
   					<option value="Singapore">Singapore</option>
   					<option value="Slovakia">Slovakia</option>
   					<option value="Slovenia">Slovenia</option>
   					<option value="Solomon Islands">Solomon Islands</option>
   					<option value="Somalia">Somalia</option>
   					<option value="South Africa">South Africa</option>
   					<option value="Spain">Spain</option>
   					<option value="Sri Lanka">Sri Lanka</option>
   					<option value="Sudan">Sudan</option>
   					<option value="Suriname">Suriname</option>
   					<option value="Swaziland">Swaziland</option>
   					<option value="Sweden">Sweden</option>
   					<option value="Switzerland">Switzerland</option>
   					<option value="Syria">Syria</option>
   					<option value="Tahiti">Tahiti</option>
   					<option value="Taiwan">Taiwan</option>
   					<option value="Tajikistan">Tajikistan</option>
   					<option value="Tanzania">Tanzania</option>
   					<option value="Thailand">Thailand</option>
   					<option value="Togo">Togo</option>
   					<option value="Tokelau">Tokelau</option>
   					<option value="Tonga">Tonga</option>
   					<option value="Trinidad & Tobago">Trinidad & Tobago</option>
   					<option value="Tunisia">Tunisia</option>
   					<option value="Turkey">Turkey</option>
   					<option value="Turkmenistan">Turkmenistan</option>
   					<option value="Turks & Caicos Is">Turks & Caicos Is</option>
   					<option value="Tuvalu">Tuvalu</option>
   					<option value="Uganda">Uganda</option>
   					<option value="United Kingdom">United Kingdom</option>
   					<option value="Ukraine">Ukraine</option>
   					<option value="United Arab Erimates">United Arab Emirates</option>
   					<option value="United States of America">United States of America</option>
   					<option value="Uraguay">Uruguay</option>
   					<option value="Uzbekistan">Uzbekistan</option>
   					<option value="Vanuatu">Vanuatu</option>
   					<option value="Vatican City State">Vatican City State</option>
   					<option value="Venezuela">Venezuela</option>
   					<option value="Vietnam">Vietnam</option>
   					<option value="Virgin Islands (Brit)">Virgin Islands (Brit)</option>
   					<option value="Virgin Islands (USA)">Virgin Islands (USA)</option>
   					<option value="Wake Island">Wake Island</option>
   					<option value="Wallis & Futana Is">Wallis & Futana Is</option>
   					<option value="Yemen">Yemen</option>
   					<option value="Zaire">Zaire</option>
   					<option value="Zambia">Zambia</option>
   					<option value="Zimbabwe">Zimbabwe</option>
   </select>
				<select name="motherLanguage" id="motherLanguage" required>
  					<option value="title">Select your mother language &#9660;</option>
  					<%
  					ArrayList<String> motherLanguage = AppWithDB.sqlSelectMotherLanguage();
  					  									for ( int i = 0 ; i<motherLanguage.size(); i++ ){
  					%>
							<option value ="<%=motherLanguage.get(i)%>"><%=motherLanguage.get(i)%></option>
							<%
							}
							%>
				</select>
				<select name="residencePermit" id="residencePermit" required>
  					<option value="title">Select your residence permit type &#9660;</option>
  					<%
  					ArrayList<String> residencePermit = AppWithDB.sqlSelectResidencePermit();
  					  									for ( int i = 0 ; i<residencePermit.size(); i++ ){
  					%>
							<option value ="<%=residencePermit.get(i)%>"><%=residencePermit.get(i)%></option>
							<%
						}
  					%>
				</select>
				<input type="Text" placeholder="Street" name="street" required />
				<input type="Text" placeholder="No." name="number" required />
				<input type="Text" placeholder="ZIP." name="post_code" required />
				<input type="Text" placeholder="City" name="city" required />
				<br>
				<label class = "TextLabel" for="male">Do you have high school certificate ? </label>
				<input type="radio" name="high_school" value="Yes" required>
				<label for="male" style="color: rgba(255, 255, 255, 0.7);">Yes</label>
				<input type="radio" name="high_school" value="No" required>
				<label for="male" style="color: rgba(255, 255, 255, 0.7);">No</label>
				<br>
				<label class = "TextLabel" for="male">Have you been graduated from university ?</label>
				<input type="radio" name="university" value="Yes" required>
				<label for="male" style="color: rgba(255, 255, 255, 0.7);">Yes</label>
				<input type="radio" name="university" value="No" required>
				<label for="male" style="color: rgba(255, 255, 255, 0.7);">No</label>
				<br>
				<label class = "TextLabel" for="male">Did you pass the integration course ?</label>
				<input type="radio" name="integration_course" value="Yes" required>
				<label for="male" style="color: rgba(255, 255, 255, 0.7);">Yes</label>
				<input type="radio" name="integration_course" value="No" required>
				<label for="male" style="color: rgba(255, 255, 255, 0.7);">No</label>
				<br>
				<label class = "TextLabel" for="male">Do you have DSH I or DSH II certificate ?</label>
				<input type="radio" name="dsh_course" value="Yes" required>
				<label for="male" style="color: rgba(255, 255, 255, 0.7);">Yes</label>
				<input type="radio" name="dsh_course" value="No" required>
				<label for="male" style="color: rgba(255, 255, 255, 0.7);">No</label>
				<br>
				<select name="german_level" required>
  					<option value="title">Select Your German Language Level &#9660;</option>
  					<option value="A1">A1</option>
  					<option value="A2">A2</option>
  					<option value="B1">B1</option>
  					<option value="B2">B2</option>
  					<option value="C1">C1</option>
  					<option value="C2">C2</option>
  				</select>
  				<br><br>
				<center><input type="submit" value="Register" name="register"
					class="btn btn-block btn-primary" /></center>
			</form>
			<br>
			<center><button onclick="location.href='HomePage.jsp'" type="button" class="btn2 btn2-block btn2-primary" />
         Cancel</button></center>
		</div>
	</div>
	
	<script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
<df-messenger
  
  chat-title="VAKS Bot"
  agent-id="25531a17-59eb-44b8-906e-8df67aac36ae"
  language-code="de"
></df-messenger>
</body>

</html>