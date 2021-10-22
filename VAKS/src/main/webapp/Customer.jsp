
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="VAKS.run.Controller.CustomerController"%>
<%@page import="VAKS.run.GoogleCalendar.GoogleKalendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="VAKS.run.Model.AppWithDB"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="VAKS.run.Controller.LoginController"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=LoginController.getLoggedInUsername()%> | Customer | VAKS</title>
</head>
<style>
body {
	background-color: rgb(220, 220, 220);
	padding: 0;
	margin: 0;
	font-size: 16px;
	font-family: sans-serif;
}

.clearfix:after {
	content: "";
	display: block;
	height: 0;
	width: 0;
	clear: both;
}

.admin-panel {
	
}
/*slidebar侧边栏*/
.slidebar {
	width: 10%;
	min-height: 690px;
	float: left;
	border-right: 1px solid rgb(235, 235, 235);
	background-color: rgb(247, 247, 247);
}

.slidebar .logo {
	height: 100px;
	border-bottom: 1px solid rgb(235, 235, 235);
}

.slidebar ul {
	padding: 0;
	margin: 0;
}

.slidebar li {
	list-style-type: none;
	margin: 0;
	position: relative;
}

.slidebar li:before {
	content: "";
	font-family: 'icomoon';
	speak: none;
	font-weight: normal;
	font-variant: normal;
	text-transform: none;
	position: absolute;
	display: block;
	line-height: 40px;
	color: rgb(102, 102, 102);
	right: 20px;
	-webkit-font-smoothing: antialiased;
}
/*插入icon图标*/
.slidebar li:nth-child(1):before {
	content: "";
}

.slidebar li:nth-child(2):before {
	content: "";
}

.slidebar li:nth-child(3):before {
	content: "";
}

.slidebar li:nth-child(4):before {
	content: "";
}

.slidebar li:nth-child(5):before {
	content: "";
}

.slidebar li:nth-child(6):before {
	content: "";
}

.slidebar li:nth-child(7):before {
	content: "";
}

.slidebar li:nth-child(8):before {
	content: "";
}

.slidebar li:nth-child(9):before {
	content: "";
}

.slidebar li:nth-child(10):before {
	content: "";
}

.slidebar li:nth-child(11):before {
	content: "";
}
/*插入icon图标*/
.slidebar ul a {
	color: rgb(140, 140, 140);
	text-decoration: none;
	font: 16px/40px helvetica, verdana, sans-serif;
	box-sizing: border-box;
	border-bottom: 1px solid rgb(235, 235, 235);
	display: block;
	box-shadow: inset 0 1px 0 rgb(255, 255, 255);
	text-indent: 20px;
	text-transform: capitalize;
}

.slidebar li:hover a {
	background-color: rgb(255, 255, 255);
	box-shadow: 1px 0 0 rgb(255, 255, 255), inset 5px 0 0 -1px
		rgb(234, 83, 63);
}
/*main*/
.main {
	float: left;
	background-color: rgb(255, 255, 255);
	font-family: helvetica, verdana, sans-serif;
}

.main .topbar {
	border-bottom: 1px solid rgb(235, 235, 235);
	margin: 0;
	padding: 0;
}
/*topbar顶部按钮栏*/
.topbar li {
	float: right;
	list-style: none;
}

.topbar li:first-child {
	float: left;
}

.topbar a {
	font-family: 'icomoon';
	display: block;
	line-height: 50px;
	width: 50px;
	text-align: center;
	text-decoration: none;
	color: rgb(102, 102, 102);
	border-left: 1px solid rgb(235, 235, 235);
}

.topbar a:hover {
	background-color: rgb(247, 247, 247);
}

.topbar li:first-child a {
	border: none;
	border-right: 1px solid rgb(235, 235, 235);
}
/*mainContent*/
.mainContent h4 {
	line-height: 1;
	font-size: 18px;
	margin: 1.3em 0 1em;
	margin-left: 17px;
}

.mainContent>div {
	position: absolute;
	opacity: 0;
	-webkit-transition: opacity 200ms linear;
	-moz-transition: opacity 200ms linear;
	-ms-transition: opacity 200ms linear;
	transition: opacity 200ms linear;
}
/*通过opacity来切换不同的选项卡*/
.mainContent>div:target {
	opacity: 1;
}

.mainContent h2 {
	margin: 1em 30px;
	color: rgb(234, 83, 63);
	font-size: 20px;
}

.mainContent h2:before {
	font-family: 'icomoon';
	content: attr(data-icon);
	font-weight: normal;
	font-variant: normal;
	text-transform: none;
	line-height: 1;
	margin-right: 10px;
	-webkit-font-smoothing: antialiased;
}

.mainContent div:nth-child(1) h2:before {
	content: "";
}

.mainContent div:nth-child(2) h2:before {
	content: "";
}

.mainContent div:nth-child(3) h2:before {
	content: "";
}

.mainContent div:nth-child(4) h2:before {
	content: "";
}

.mainContent div:nth-child(5) h2:before {
	content: "";
}

.mainContent div:nth-child(6) h2:before {
	content: "";
}

.mainContent div:nth-child(7) h2:before {
	content: "";
}

.mainContent div:nth-child(8) h2:before {
	content: "";
}

.mainContent div:nth-child(9) h2:before {
	content: "";
}

.mainContent div:nth-child(10) h2:before {
	content: "";
}

.mainContent div:nth-child(11) h2:before {
	content: "";
}

#dashboard>div {
	border: 1px solid rgb(235, 235, 235);
	margin-left: 30px;
	float: left;
	border-radius: 5px;
	min-width: 345px;
	height: 262px;
	display: inline-block;
}

.monitor ul {
	float: left;
	padding: 0;
	margin: 0 31px 0 17px;
}

.monitor li {
	list-style: none;
	font: 600 14px/28px helvetica, verdana, sans-serif;
	color: rgb(102, 102, 102);
	text-transform: capitalize;
}

.monitor li a {
	color: rgb(102, 102, 102);
	text-transform: capitalize;
	text-decoration: none;
}

.monitor li:first-child {
	border-bottom: 1px dotted rgb(153, 153, 153);
}

.discussions .comments {
	color: rgb(27, 106, 173);
}

.discussions .approved {
	color: rgb(105, 174, 48);
}

.discussions .pending {
	color: rgb(246, 129, 15);
}

.discussions .spam {
	color: rgb(243, 47, 47);
}

.monitor .count {
	color: rgb(27, 106, 173);
	text-align: right;
	font-weight: 600;
	margin-right: 15px;
	min-width: 25px;
	display: inline-block;
}

.monitor p {
	color: rgb(128, 128, 128);
	margin: 28px 0 18px 17px;
	display: block;
	font-weight: 600;
	font-size: 12px;
}

.monitor p a {
	text-decoration: none;
	color: rgb(27, 106, 173);
}

.quick-press form {
	margin: 0 20px 0 13px;
}

.quick-press input[type="text"] {
	display: block;
	width: 100%;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	height: 35px;
	line-height: 15px;
	padding: 10px 0;
	margin: 0 0 7px 0;
	background-color: rgb(246, 246, 246);
	outline: none;
	border: none;
	text-indent: 10px;
}
/*统一各浏览器下placeholder内的字体样式*/
.quick-press input[type="text"]::-webkit-input-placeholder {
	font-size: 14px;
}

.quick-press input[type="text"]:-moz-input-placeholder {
	font-size: 14px;
}

.quick-press input[type="text"]::-moz-input-placeholder {
	font-size: 14px;
}

.quick-press input[type="text"]:-ms-input-placeholder {
	font-size: 14px;
}

.quick-press button {
	margin-top: 13px;
	border-radius: 5px;
	text-align: center;
	line-height: 30px;
	padding: 0;
}

.quick-press .save, .quick-press .delet {
	font-family: 'icomoon';
	width: 37px;
	background: -webkit-linear-gradient(top, rgb(246, 246, 240),
		rgb(232, 232, 232));
	background: -moz-linear-gradient(top, rgb(246, 246, 240),
		rgb(232, 232, 232));
	background: -ms-linear-gradient(top, rgb(246, 246, 240),
		rgb(232, 232, 232));
	background: linear-gradient(top, rgb(246, 246, 240), rgb(232, 232, 232));
	border: 1px solid rgb(229, 229, 229);
	color: rgb(102, 102, 102);
	float: left;
	margin-right: 5px;
}

.quick-press .save:hover, .quick-press .delet:hover {
	background: -webkit-linear-gradient(top, rgb(232, 232, 232),
		rgb(246, 246, 240));
	background: -moz-linear-gradient(top, rgb(232, 232, 232),
		rgb(246, 246, 240));
	background: -ms-linear-gradient(top, rgb(232, 232, 232),
		rgb(246, 246, 240));
	background: linear-gradient(top, rgb(232, 232, 232), rgb(246, 246, 240));
}

.quick-press .save:active, .quick-press .delet:active {
	background: -webkit-linear-gradient(top, rgb(228, 228, 228),
		rgb(210, 210, 210));
	background: -moz-linear-gradient(top, rgb(228, 228, 228),
		rgb(210, 210, 210));
	background: -ms-linear-gradient(top, rgb(228, 228, 228),
		rgb(210, 210, 210));
	background: linear-gradient(top, rgb(228, 228, 228), rgb(210, 210, 210));
}

.quick-press .submit {
	float: right;
	width: 70px;
	border: 1px solid rgb(238, 85, 64);
	color: #fff;
	font-size: 16px;
	background: -webkit-linear-gradient(top, rgb(245, 101, 82),
		rgb(234, 83, 63));
	background: -moz-linear-gradient(top, rgb(245, 101, 82),
		rgb(234, 83, 63));
	background: -ms-linear-gradient(top, rgb(245, 101, 82), rgb(234, 83, 63));
	background: linear-gradient(top, rgb(245, 101, 82), rgb(234, 83, 63));
}

.quick-press .submit:hover {
	background: -webkit-linear-gradient(top, rgb(220, 85, 70),
		rgb(210, 65, 53));
	background: -moz-linear-gradient(top, rgb(220, 85, 70), rgb(210, 65, 53));
	background: -ms-linear-gradient(top, rgb(220, 85, 70), rgb(210, 65, 53));
	background: linear-gradient(top, rgb(220, 85, 70), rgb(210, 65, 53));
}
/*logo*/
.logo a {
	width: 88px;
	height: 88px;
	display: inline-block;
	position: relative;
	left: 50%;
	top: 50%;
	margin: -45px 0 0 -45px;
	border: 1px solid rgb(200, 200, 200);
	border-radius: 50%;
	background-color: rgb(214, 214, 214);
}

.logo a:before {
	content: "C";
	width: 70px;
	height: 70px;
	font: 50px/70px helvetica, verdana, sans-serif;
	text-align: center;
	position: absolute;
	top: 8px;
	left: 8px;
	border-radius: 35px;
	border: 1px solid rgb(210, 210, 210);
	display: inline-block;
	background: -webkit-linear-gradient(top, rgb(255, 255, 255),
		rgb(245, 245, 245));
	background: -moz-linear-gradient(top, rgb(255, 255, 255),
		rgb(245, 245, 245));
	background: -ms-linear-gradient(top, rgb(255, 255, 255),
		rgb(245, 245, 245));
	background: linear-gradient(top, rgb(255, 255, 255), rgb(245, 245, 245));
}
/*statusbar底部功能按钮*/
.statusbar {
	position: absolute;
	bottom: 0;
	border-top: 1px solid rgb(235, 235, 235);
	width: 100%;
	padding: 0;
	margin: 0;
}

.statusbar li {
	list-style: none;
}

.statusbar a {
	color: rgb(102, 102, 102);
	text-decoration: none;
	text-align: center;
	display: block;
}

.statusbar a:hover {
	background-color: rgb(247, 247, 247);
}

.statusbar .profiles-setting, .statusbar .logout {
	float: right;
}

.statusbar .profiles-setting a, .statusbar .logout a {
	font-family: 'icomoon';
	width: 49px;
	height: 49px;
	line-height: 50px;
	border-left: 1px solid rgb(235, 235, 235);
}

@font-face {
	font-family: 'icomoon';
	src: url('fonts/icomoon.eot');
	src: url('fonts/icomoon.eot?#iefix') format('embedded-opentype'),
		url('fonts/icomoon.woff') format('woff'), url('fonts/icomoon.ttf')
		format('truetype'), url('fonts/icomoon.svg#icomoon') format('svg');
	font-weight: normal;
	font-style: normal;
}

.page-wrap {
	padding: 20px 60px;
}

.breadcrumb {
	margin: 25px 0;
}

.scrollit {
	overflow: scroll;
	height: 300px;
}

.AddUser-container {
	display: grid;
	grid-column-gap: 10px;
	grid-template-columns: auto auto auto;
	border-style: groove;
	padding: 5px;
	border: 1px groove;
	border-radius: 20px;
}

.grid-item {
	padding: 5px;
	text-align: left;
}

.AddDocument-container {
	display: grid;
	grid-column-gap: 10px;
	grid-template-columns: auto auto;
	border-style: groove;
	padding: 5px;
	border: 1px groove;
	border-radius: 20px;
}

/* Button used to open the contact form - fixed at the bottom of the page */
.open-button {
	background-color: #555;
	color: white;
	padding: 16px 20px;
	border: none;
	cursor: pointer;
	opacity: 0.8;
	position: fixed;
	bottom: 23px;
	right: 28px;
	width: 280px;
}

/* The popup form - hidden by default */
.form-popup2 {
	display: block;
	position: fixed;
	bottom: 0;
	right: 15px;
	border: 3px solid #f1f1f1;
	z-index: 9;
}

/* The popup form - hidden by default */
.form-popup {
	display: none;
	position: fixed;
	bottom: 0;
	right: 15px;
	border: 3px solid #f1f1f1;
	z-index: 9;
}

/* Add styles to the form container */
.form-container {
	max-width: 300px;
	padding: 10px;
	background-color: white;
}

/* Full-width input fields */
.form-container input[type=text], .form-container input[type=password],
	.form-container input[type=date], .form-container input[type=time],
	.form-container select {
	width: 100%;
	padding: 5px;
	margin: 5px 0 22px 0;
	border: none;
	background: #f1f1f1;
}

/* When the inputs get focus, do something */
.form-container input[type=text]:focus, .form-container input[type=password]:focus,
	.form-container input[type=date]:focus, .form-container input[type=time]:focus,
	.form-container select:focus {
	background-color: #ddd;
	outline: none;
}

/* Set a style for the submit/login button */
.form-container .btn {
	background-color: #04AA6D;
	color: white;
	padding: 16px 20px;
	border: none;
	cursor: pointer;
	width: 100%;
	margin-bottom: 10px;
	opacity: 0.8;
}

/* Add a red background color to the cancel button */
.form-container .cancel {
	background-color: red;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
	opacity: 1;
}
</style>

<body>

	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<div class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">

					<div class="navbar-header">
						<button class="navbar-toggle" data-target="#mobile_menu"
							data-toggle="collapse">
							<span class="icon-bar"></span><span class="icon-bar"></span><span
								class="icon-bar"></span>
						</button>
						<a href="HomePage.jsp" class="navbar-brand">VAKS Siegen</a>
					</div>

					<div class="navbar-collapse collapse" id="mobile_menu">
						<ul class="nav navbar-nav">
							<li class="active"><a href="#">Home</a></li>
							<li><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">About Us <span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="#">About One</a></li>
									<li><a href="#">About Two</a></li>
									<li><a href="#">About Three</a></li>
									<li><a href="#">About Four</a></li>
									<li><a href="#">About Five</a></li>
									<li><a href="#">About Six</a></li>
								</ul></li>
							<li><a href="#">Welcome</a></li>
							<li><a href="#">Services</a></li>
							<li><a href="#">Gallery</a></li>
							<li><a href="#">Contact Us</a></li>
						</ul>
						<ul class="nav navbar-nav">
							<li></li>
						</ul>

						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><span class="glyphicon glyphicon-user"></span>
									Profile</a></li>
							<li><a href="#" class="dropdown-toggle"
								data-toggle="dropdown"><span
									class="glyphicon glyphicon-log-in"></span> Login / Sign Up <span
									class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="Login">Login</a></li>
									<li><a href="SignUp">Sign Up</a></li>
								</ul></li>
						</ul>
					</div>
				</div>
			</div>

		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



	<div class="admin-panel clearfix">
		<div class="slidebar">
			<div class="logo">
				<a href=""></a>
			</div>
			<ul>
				<li><a href="#Dashboard" onclick="showHideBar('Dashboard')">Dashboard</a></li>
<!-- 				<li><a href="#User" onclick="showHideBar('User')">Manage User</a></li> -->
<!-- 				<li><a href="#Calendar" onclick="showHideBar('Calendar')">Calendar</a></li> -->
				<li><a href="#ManageEvents" onclick="showHideBar('ManageEvents')">Events</a></li>
				<li><a href="#Documents" onclick="showHideBar('Documents')">Documents</a></li>
				<!--				<li><a href="#Statistics" onclick="showHideBar('Statistics')">Statistics</a></li> -->
				<!-- 				<li><a href="#widgets">widgets</a></li> -->
				<!-- 				<li><a href="#plugins">plugins</a></li> -->
				<!-- 				<li><a href="#users">users</a></li> -->
				<!-- 				<li><a href="#tools">tools</a></li> -->
				<!-- 				<li><a href="#settings">settings</a></li> -->
			</ul>
		</div>
		<div class="main">
			<ul class="topbar clearfix">
				<li><a href="#">q</a></li>
				<li><a href="#">p</a></li>
				<li><a href="#">o</a></li>
				<li><a href="#">f</a></li>
				<li><a href="#">n</a></li>
			</ul>
			<div class="mainContent clearfix">
				<div id="Dashboard">
					<h2 class="header"><span class="icon"></span>Dashboard</h2>
										<div class="monitor">
											<h4>Information about your supervisor</h4>
											<div class="clearfix">
												<ul class="content">
												<%
												ResultSet rD = null;

																						String QueryD = "Select first_name, last_name, email, mobile, language, gender from User NATURAL JOIN Mother_Language Natural Join User_Mother_Language  where user_id = ( Select worker_id from Kunde_Supervised_By_Worker where kunde_id = '" + LoginController.getLoggedInUserId() + "' ) ;";
																						Statement sD = AppWithDB.connect().createStatement();
																						rD = sD.executeQuery(QueryD);
																						String first_nameD=null;
																						String last_nameD=null;;
																						String emailD=null;
																						String mobileD=null;
																						String motherLanguageD=null;
																						String genderD=null;
																						while (rD.next()) {
																							first_nameD = rD.getString("first_name");
																							last_nameD = rD.getString("last_name");
																							emailD = rD.getString("email");
																							mobileD = rD.getString("mobile");
																							motherLanguageD = rD.getString("language");
																							genderD = rD.getString("gender");
																						}
																						rD.close();
																						sD.close();
												%>
													<li><%=first_nameD + ", " + last_nameD.toUpperCase()%></li>
													<li class="posts"><a>Gender : </a>&#09; &#09; &#09; &#09;<span class="count"><%=genderD%></span></li>
													<li class="posts"><a>Mobile. : </a>&#09; &#09; &#09; &#09;<span class="count"><%=mobileD%></span></li>
													<li class="posts"><a>E-Mail : </a>&#09; &#09; &#09; &#09;<a href="mailto:<%=emailD%>?subject=E-Mail From User ID : <%=LoginController.getLoggedInUserId() + ", Username : " + LoginController.getLoggedInUsername()%>" class="count"><%=emailD%></a></li>
													<li class="posts"><a>Mother Language : </a>&#09; &#09; &#09; &#09;<span class="count"><%=motherLanguageD%></span></li>
													
												</ul>
<!-- 												<ul class="discussions"> -->
<!-- 													<li>discussions</li> -->
<!-- 													<li class="comments"><span class="count">353</span><a -->
<!-- 														href="">comments</a></li> -->
<!-- 													<li class="approved"><span class="count">319</span><a -->
<!-- 														href="">approved</a></li> -->
<!-- 													<li class="pending"><span class="count">0</span><a href="">pending</a></li> -->
<!-- 													<li class="spam"><span class="count">34</span><a href="">spam</a></li> -->
<!-- 												</ul> -->
											</div>
											
										</div>
<!-- 										<div class="quick-press"> -->
<!-- 											<h4>Quick Press</h4> -->
<!-- 											<form action="" method="post"> -->
<!-- 												<input type="text" name="title" placeholder="Title" /> <input -->
<!-- 													type="text" name="content" placeholder="Content" /> <input -->
<!-- 													type="text" name="tags" placeholder="Tags" /> -->
<!-- 												<button type="button" class="save">l</button> -->
<!-- 												<button type="button" class="delet">m</button> -->
<!-- 												<button type="submit" class="submit" name="submit">Publish</button> -->
<!-- 											</form> -->
<!-- 										</div> -->
				</div>

				<div id="User">
					<h2 class="header">Manage User</h2>
					<div class="page-wrap">

						<div class="scrollit">
							<form action="Customer/deleteUser" method="post">
								<table id="UserTable" class="table table-bordered">
									<thead>
										<tr>
											<th>ID</th>
											<th>First Name</th>
											<th>Surname</th>
											<th>Country</th>
											<th>Language</th>
											<th>Residence Permit</th>
											<th>E-Mail</th>
											<th>Role</th>
											<th>Address</th>

<!-- 											<th>Delete</th> -->
											<!-- 											<th>Edit</th> -->
										</tr>
									</thead>
									<tbody>
										<%
										ResultSet r = null;

																		String Query = "Select user_id, first_name, last_name, country, language, residence_permit_type, email, street, number, post_code, city, role_type From User Natural Join User_Role Natural Join Role Natural Join  Residence_Permit Natural Join User_Residence_Permit Natural Join Mother_Language Natural Join User_Mother_Language Natural Join Address Natural Join User_Address ORDER By role_id, user_id;";
																		Statement s = AppWithDB.connect().createStatement();
																		r = s.executeQuery(Query);
																		while (r.next()) {
																			String user_id = String.valueOf(r.getString("user_id"));
																			String first_name = r.getString("first_name");
																			String last_name = r.getString("last_name");
																			String country = r.getString("country");
																			String residence_permit_type = r.getString("language");
																			String email = r.getString("residence_permit_type");
																			String language = r.getString("email");
																			String role_type = r.getString("role_type");
																			String street = r.getString("street");
																			String number = r.getString("number");
																			String post_code = r.getString("post_code");
																			String city = r.getString("city");
										%>

										<tr>
											<td><%=user_id%></td>
											<td><%=first_name%></td>
											<td><%=last_name%></td>
											<td><%=country%></td>
											<td><%=residence_permit_type%></td>
											<td><%=email%></td>
											<td><%=language%></td>
											<td><%=role_type%></td>
											<td><%=street + ", " + number + ", " + post_code + ", " + city%></td>
<!-- 											<td><input type="submit" Value="Delete" name="actionBtnValue" onClick="deleteConfirmUser(1)"></td> -->
											<!-- 											<td><input type="submit" Value="Edit" -->
											<!-- 												name="actionBtnValue" onClick="deleteConfirmUser(2)"></td> -->
										</tr>
										<%
										}
																		r.close();
																		s.close();
										%>

									</tbody>
								</table>
								<input type="hidden" name="user_id_hidden" id="user_id_hidden" />
							</form>
						</div>
						<br> 
<!-- 						<input type="button" Value="Add User" onclick="showHideDiv(1)"> -->
<!-- 						 Scroll Div -->
<!-- 						<form action="Volunteer/AddUser" method="post"> -->
<!-- 							<div class="AddUser-container " id="AddUser-container" -->
<!-- 								style="visibility: hidden"> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>First Name :</label> <input type="text" -->
<!-- 										placeholder="First Name" name="firstName" required /> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>Country :</label> <select id="country" name="country" -->
<!-- 										required> -->
<!-- 										<option>Select your country</option> -->
<!-- 										<option value="Afganistan">Afghanistan</option> -->
<!-- 										<option value="Albania">Albania</option> -->
<!-- 										<option value="Algeria">Algeria</option> -->
<!-- 										<option value="American Samoa">American Samoa</option> -->
<!-- 										<option value="Andorra">Andorra</option> -->
<!-- 										<option value="Angola">Angola</option> -->
<!-- 										<option value="Anguilla">Anguilla</option> -->
<!-- 										<option value="Antigua & Barbuda">Antigua & Barbuda</option> -->
<!-- 										<option value="Argentina">Argentina</option> -->
<!-- 										<option value="Armenia">Armenia</option> -->
<!-- 										<option value="Aruba">Aruba</option> -->
<!-- 										<option value="Australia">Australia</option> -->
<!-- 										<option value="Austria">Austria</option> -->
<!-- 										<option value="Azerbaijan">Azerbaijan</option> -->
<!-- 										<option value="Bahamas">Bahamas</option> -->
<!-- 										<option value="Bahrain">Bahrain</option> -->
<!-- 										<option value="Bangladesh">Bangladesh</option> -->
<!-- 										<option value="Barbados">Barbados</option> -->
<!-- 										<option value="Belarus">Belarus</option> -->
<!-- 										<option value="Belgium">Belgium</option> -->
<!-- 										<option value="Belize">Belize</option> -->
<!-- 										<option value="Benin">Benin</option> -->
<!-- 										<option value="Bermuda">Bermuda</option> -->
<!-- 										<option value="Bhutan">Bhutan</option> -->
<!-- 										<option value="Bolivia">Bolivia</option> -->
<!-- 										<option value="Bonaire">Bonaire</option> -->
<!-- 										<option value="Bosnia & Herzegovina">Bosnia & -->
<!-- 											Herzegovina</option> -->
<!-- 										<option value="Botswana">Botswana</option> -->
<!-- 										<option value="Brazil">Brazil</option> -->
<!-- 										<option value="British Indian Ocean Ter">British -->
<!-- 											Indian Ocean Ter</option> -->
<!-- 										<option value="Brunei">Brunei</option> -->
<!-- 										<option value="Bulgaria">Bulgaria</option> -->
<!-- 										<option value="Burkina Faso">Burkina Faso</option> -->
<!-- 										<option value="Burundi">Burundi</option> -->
<!-- 										<option value="Cambodia">Cambodia</option> -->
<!-- 										<option value="Cameroon">Cameroon</option> -->
<!-- 										<option value="Canada">Canada</option> -->
<!-- 										<option value="Canary Islands">Canary Islands</option> -->
<!-- 										<option value="Cape Verde">Cape Verde</option> -->
<!-- 										<option value="Cayman Islands">Cayman Islands</option> -->
<!-- 										<option value="Central African Republic">Central -->
<!-- 											African Republic</option> -->
<!-- 										<option value="Chad">Chad</option> -->
<!-- 										<option value="Channel Islands">Channel Islands</option> -->
<!-- 										<option value="Chile">Chile</option> -->
<!-- 										<option value="China">China</option> -->
<!-- 										<option value="Christmas Island">Christmas Island</option> -->
<!-- 										<option value="Cocos Island">Cocos Island</option> -->
<!-- 										<option value="Colombia">Colombia</option> -->
<!-- 										<option value="Comoros">Comoros</option> -->
<!-- 										<option value="Congo">Congo</option> -->
<!-- 										<option value="Cook Islands">Cook Islands</option> -->
<!-- 										<option value="Costa Rica">Costa Rica</option> -->
<!-- 										<option value="Cote DIvoire">Cote DIvoire</option> -->
<!-- 										<option value="Croatia">Croatia</option> -->
<!-- 										<option value="Cuba">Cuba</option> -->
<!-- 										<option value="Curaco">Curacao</option> -->
<!-- 										<option value="Cyprus">Cyprus</option> -->
<!-- 										<option value="Czech Republic">Czech Republic</option> -->
<!-- 										<option value="Denmark">Denmark</option> -->
<!-- 										<option value="Djibouti">Djibouti</option> -->
<!-- 										<option value="Dominica">Dominica</option> -->
<!-- 										<option value="Dominican Republic">Dominican Republic</option> -->
<!-- 										<option value="East Timor">East Timor</option> -->
<!-- 										<option value="Ecuador">Ecuador</option> -->
<!-- 										<option value="Egypt">Egypt</option> -->
<!-- 										<option value="El Salvador">El Salvador</option> -->
<!-- 										<option value="Equatorial Guinea">Equatorial Guinea</option> -->
<!-- 										<option value="Eritrea">Eritrea</option> -->
<!-- 										<option value="Estonia">Estonia</option> -->
<!-- 										<option value="Ethiopia">Ethiopia</option> -->
<!-- 										<option value="Falkland Islands">Falkland Islands</option> -->
<!-- 										<option value="Faroe Islands">Faroe Islands</option> -->
<!-- 										<option value="Fiji">Fiji</option> -->
<!-- 										<option value="Finland">Finland</option> -->
<!-- 										<option value="France">France</option> -->
<!-- 										<option value="French Guiana">French Guiana</option> -->
<!-- 										<option value="French Polynesia">French Polynesia</option> -->
<!-- 										<option value="French Southern Ter">French Southern -->
<!-- 											Ter</option> -->
<!-- 										<option value="Gabon">Gabon</option> -->
<!-- 										<option value="Gambia">Gambia</option> -->
<!-- 										<option value="Georgia">Georgia</option> -->
<!-- 										<option value="Germany">Germany</option> -->
<!-- 										<option value="Ghana">Ghana</option> -->
<!-- 										<option value="Gibraltar">Gibraltar</option> -->
<!-- 										<option value="Great Britain">Great Britain</option> -->
<!-- 										<option value="Greece">Greece</option> -->
<!-- 										<option value="Greenland">Greenland</option> -->
<!-- 										<option value="Grenada">Grenada</option> -->
<!-- 										<option value="Guadeloupe">Guadeloupe</option> -->
<!-- 										<option value="Guam">Guam</option> -->
<!-- 										<option value="Guatemala">Guatemala</option> -->
<!-- 										<option value="Guinea">Guinea</option> -->
<!-- 										<option value="Guyana">Guyana</option> -->
<!-- 										<option value="Haiti">Haiti</option> -->
<!-- 										<option value="Hawaii">Hawaii</option> -->
<!-- 										<option value="Honduras">Honduras</option> -->
<!-- 										<option value="Hong Kong">Hong Kong</option> -->
<!-- 										<option value="Hungary">Hungary</option> -->
<!-- 										<option value="Iceland">Iceland</option> -->
<!-- 										<option value="Indonesia">Indonesia</option> -->
<!-- 										<option value="India">India</option> -->
<!-- 										<option value="Iran">Iran</option> -->
<!-- 										<option value="Iraq">Iraq</option> -->
<!-- 										<option value="Ireland">Ireland</option> -->
<!-- 										<option value="Isle of Man">Isle of Man</option> -->
<!-- 										<option value="Israel">Israel</option> -->
<!-- 										<option value="Italy">Italy</option> -->
<!-- 										<option value="Jamaica">Jamaica</option> -->
<!-- 										<option value="Japan">Japan</option> -->
<!-- 										<option value="Jordan">Jordan</option> -->
<!-- 										<option value="Kazakhstan">Kazakhstan</option> -->
<!-- 										<option value="Kenya">Kenya</option> -->
<!-- 										<option value="Kiribati">Kiribati</option> -->
<!-- 										<option value="Korea North">Korea North</option> -->
<!-- 										<option value="Korea Sout">Korea South</option> -->
<!-- 										<option value="Kuwait">Kuwait</option> -->
<!-- 										<option value="Kyrgyzstan">Kyrgyzstan</option> -->
<!-- 										<option value="Laos">Laos</option> -->
<!-- 										<option value="Latvia">Latvia</option> -->
<!-- 										<option value="Lebanon">Lebanon</option> -->
<!-- 										<option value="Lesotho">Lesotho</option> -->
<!-- 										<option value="Liberia">Liberia</option> -->
<!-- 										<option value="Libya">Libya</option> -->
<!-- 										<option value="Liechtenstein">Liechtenstein</option> -->
<!-- 										<option value="Lithuania">Lithuania</option> -->
<!-- 										<option value="Luxembourg">Luxembourg</option> -->
<!-- 										<option value="Macau">Macau</option> -->
<!-- 										<option value="Macedonia">Macedonia</option> -->
<!-- 										<option value="Madagascar">Madagascar</option> -->
<!-- 										<option value="Malaysia">Malaysia</option> -->
<!-- 										<option value="Malawi">Malawi</option> -->
<!-- 										<option value="Maldives">Maldives</option> -->
<!-- 										<option value="Mali">Mali</option> -->
<!-- 										<option value="Malta">Malta</option> -->
<!-- 										<option value="Marshall Islands">Marshall Islands</option> -->
<!-- 										<option value="Martinique">Martinique</option> -->
<!-- 										<option value="Mauritania">Mauritania</option> -->
<!-- 										<option value="Mauritius">Mauritius</option> -->
<!-- 										<option value="Mayotte">Mayotte</option> -->
<!-- 										<option value="Mexico">Mexico</option> -->
<!-- 										<option value="Midway Islands">Midway Islands</option> -->
<!-- 										<option value="Moldova">Moldova</option> -->
<!-- 										<option value="Monaco">Monaco</option> -->
<!-- 										<option value="Mongolia">Mongolia</option> -->
<!-- 										<option value="Montserrat">Montserrat</option> -->
<!-- 										<option value="Morocco">Morocco</option> -->
<!-- 										<option value="Mozambique">Mozambique</option> -->
<!-- 										<option value="Myanmar">Myanmar</option> -->
<!-- 										<option value="Nambia">Nambia</option> -->
<!-- 										<option value="Nauru">Nauru</option> -->
<!-- 										<option value="Nepal">Nepal</option> -->
<!-- 										<option value="Netherland Antilles">Netherland -->
<!-- 											Antilles</option> -->
<!-- 										<option value="Netherlands">Netherlands (Holland, -->
<!-- 											Europe)</option> -->
<!-- 										<option value="Nevis">Nevis</option> -->
<!-- 										<option value="New Caledonia">New Caledonia</option> -->
<!-- 										<option value="New Zealand">New Zealand</option> -->
<!-- 										<option value="Nicaragua">Nicaragua</option> -->
<!-- 										<option value="Niger">Niger</option> -->
<!-- 										<option value="Nigeria">Nigeria</option> -->
<!-- 										<option value="Niue">Niue</option> -->
<!-- 										<option value="Norfolk Island">Norfolk Island</option> -->
<!-- 										<option value="Norway">Norway</option> -->
<!-- 										<option value="Oman">Oman</option> -->
<!-- 										<option value="Pakistan">Pakistan</option> -->
<!-- 										<option value="Palau Island">Palau Island</option> -->
<!-- 										<option value="Palestine">Palestine</option> -->
<!-- 										<option value="Panama">Panama</option> -->
<!-- 										<option value="Papua New Guinea">Papua New Guinea</option> -->
<!-- 										<option value="Paraguay">Paraguay</option> -->
<!-- 										<option value="Peru">Peru</option> -->
<!-- 										<option value="Phillipines">Philippines</option> -->
<!-- 										<option value="Pitcairn Island">Pitcairn Island</option> -->
<!-- 										<option value="Poland">Poland</option> -->
<!-- 										<option value="Portugal">Portugal</option> -->
<!-- 										<option value="Puerto Rico">Puerto Rico</option> -->
<!-- 										<option value="Qatar">Qatar</option> -->
<!-- 										<option value="Republic of Montenegro">Republic of -->
<!-- 											Montenegro</option> -->
<!-- 										<option value="Republic of Serbia">Republic of Serbia</option> -->
<!-- 										<option value="Reunion">Reunion</option> -->
<!-- 										<option value="Romania">Romania</option> -->
<!-- 										<option value="Russia">Russia</option> -->
<!-- 										<option value="Rwanda">Rwanda</option> -->
<!-- 										<option value="St Barthelemy">St Barthelemy</option> -->
<!-- 										<option value="St Eustatius">St Eustatius</option> -->
<!-- 										<option value="St Helena">St Helena</option> -->
<!-- 										<option value="St Kitts-Nevis">St Kitts-Nevis</option> -->
<!-- 										<option value="St Lucia">St Lucia</option> -->
<!-- 										<option value="St Maarten">St Maarten</option> -->
<!-- 										<option value="St Pierre & Miquelon">St Pierre & -->
<!-- 											Miquelon</option> -->
<!-- 										<option value="St Vincent & Grenadines">St Vincent & -->
<!-- 											Grenadines</option> -->
<!-- 										<option value="Saipan">Saipan</option> -->
<!-- 										<option value="Samoa">Samoa</option> -->
<!-- 										<option value="Samoa American">Samoa American</option> -->
<!-- 										<option value="San Marino">San Marino</option> -->
<!-- 										<option value="Sao Tome & Principe">Sao Tome & -->
<!-- 											Principe</option> -->
<!-- 										<option value="Saudi Arabia">Saudi Arabia</option> -->
<!-- 										<option value="Senegal">Senegal</option> -->
<!-- 										<option value="Seychelles">Seychelles</option> -->
<!-- 										<option value="Sierra Leone">Sierra Leone</option> -->
<!-- 										<option value="Singapore">Singapore</option> -->
<!-- 										<option value="Slovakia">Slovakia</option> -->
<!-- 										<option value="Slovenia">Slovenia</option> -->
<!-- 										<option value="Solomon Islands">Solomon Islands</option> -->
<!-- 										<option value="Somalia">Somalia</option> -->
<!-- 										<option value="South Africa">South Africa</option> -->
<!-- 										<option value="Spain">Spain</option> -->
<!-- 										<option value="Sri Lanka">Sri Lanka</option> -->
<!-- 										<option value="Sudan">Sudan</option> -->
<!-- 										<option value="Suriname">Suriname</option> -->
<!-- 										<option value="Swaziland">Swaziland</option> -->
<!-- 										<option value="Sweden">Sweden</option> -->
<!-- 										<option value="Switzerland">Switzerland</option> -->
<!-- 										<option value="Syria">Syria</option> -->
<!-- 										<option value="Tahiti">Tahiti</option> -->
<!-- 										<option value="Taiwan">Taiwan</option> -->
<!-- 										<option value="Tajikistan">Tajikistan</option> -->
<!-- 										<option value="Tanzania">Tanzania</option> -->
<!-- 										<option value="Thailand">Thailand</option> -->
<!-- 										<option value="Togo">Togo</option> -->
<!-- 										<option value="Tokelau">Tokelau</option> -->
<!-- 										<option value="Tonga">Tonga</option> -->
<!-- 										<option value="Trinidad & Tobago">Trinidad & Tobago</option> -->
<!-- 										<option value="Tunisia">Tunisia</option> -->
<!-- 										<option value="Turkey">Turkey</option> -->
<!-- 										<option value="Turkmenistan">Turkmenistan</option> -->
<!-- 										<option value="Turks & Caicos Is">Turks & Caicos Is</option> -->
<!-- 										<option value="Tuvalu">Tuvalu</option> -->
<!-- 										<option value="Uganda">Uganda</option> -->
<!-- 										<option value="United Kingdom">United Kingdom</option> -->
<!-- 										<option value="Ukraine">Ukraine</option> -->
<!-- 										<option value="United Arab Erimates">United Arab -->
<!-- 											Emirates</option> -->
<!-- 										<option value="United States of America">United -->
<!-- 											States of America</option> -->
<!-- 										<option value="Uraguay">Uruguay</option> -->
<!-- 										<option value="Uzbekistan">Uzbekistan</option> -->
<!-- 										<option value="Vanuatu">Vanuatu</option> -->
<!-- 										<option value="Vatican City State">Vatican City State</option> -->
<!-- 										<option value="Venezuela">Venezuela</option> -->
<!-- 										<option value="Vietnam">Vietnam</option> -->
<!-- 										<option value="Virgin Islands (Brit)">Virgin Islands -->
<!-- 											(Brit)</option> -->
<!-- 										<option value="Virgin Islands (USA)">Virgin Islands -->
<!-- 											(USA)</option> -->
<!-- 										<option value="Wake Island">Wake Island</option> -->
<!-- 										<option value="Wallis & Futana Is">Wallis & Futana Is</option> -->
<!-- 										<option value="Yemen">Yemen</option> -->
<!-- 										<option value="Zaire">Zaire</option> -->
<!-- 										<option value="Zambia">Zambia</option> -->
<!-- 										<option value="Zimbabwe">Zimbabwe</option> -->
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>Street :</label> <input type="Text" placeholder="Street" -->
<!-- 										name="street" required /> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>Last Name :</label> <input type="text" -->
<!-- 										placeholder="Last Name" name="lastName" required /> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>Mother Language :</label> <select name="motherLanguage" -->
<!-- 										id="motherLanguage" required> -->
<!-- 										<option value="title">Select your mother language</option> -->
<%-- 										<% --%>
<!--  										ArrayList<String> motherLanguage = SqlConnection.sqlSelectMotherLanguage(); -->
<!--  										for (int i = 0; i < motherLanguage.size(); i++) { -->
<%-- 										%> --%>
<%-- 										<option value="<%=motherLanguage.get(i)%>"><%=motherLanguage.get(i)%></option> --%>
<%-- 										<% --%>
<!--  										} -->
<%-- 										%> --%>
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>Nr. :</label> <input type="Text" placeholder="No." -->
<!-- 										name="number" required /> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>Birthday :</label> <input type="date" -->
<!-- 										placeholder="Birthday" name="birthday" required /> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>Residence Permit Type :</label> <select -->
<!-- 										name="residencePermit" id="residencePermit" required> -->
<!-- 										<option value="title">Select your residence permit -->
<!-- 											type</option> -->
<%-- 										<% --%>
<!--  										ArrayList<String> residencePermit = SqlConnection.sqlSelectResidencePermit(); -->
<!--  										for (int i = 0; i < residencePermit.size(); i++) { -->
<%-- 										%> --%>
<%-- 										<option value="<%=residencePermit.get(i)%>"><%=residencePermit.get(i)%></option> --%>
<%-- 										<% --%>
<!--  										} -->
<%-- 										%> --%>
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>ZIP. :</label> <input type="Text" placeholder="ZIP." -->
<!-- 										name="post_code" required /> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label class="TextLabel" for="male">Gender: </label> <input -->
<!-- 										type="radio" id="male" name="gender" value="male" required> -->
<!-- 									<label for="male">Male</label> <input type="radio" id="female" -->
<!-- 										name="gender" value="female" required> <label -->
<!-- 										for="female">Female</label> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label class="TextLabel" for="male">High School Degree -->
<!-- 										? </label> <input type="radio" name="high_school" value="Yes" required> -->
<!-- 									<label for="male">Yes</label> <input type="radio" -->
<!-- 										name="high_school" value="No"> <label for="male">No</label> -->
<!-- 									<input type="radio" name="high_school" -->
<!-- 										value="Nicht Interessiert"> <label for="male">Nicht -->
<!-- 										Interessiert</label> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>City :</label> <input type="Text" placeholder="City" -->
<!-- 										name="city" required /> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>E-Mail :</label> <input type="email" placeholder="Email" -->
<!-- 										name="email" required /> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label class="TextLabel" for="male">University Degree ?</label> -->
<!-- 									<input type="radio" name="university" value="Yes" required> -->
<!-- 									<label for="male">Yes</label> <input type="radio" -->
<!-- 										name="university" value="No"> <label for="male">No</label> -->
<!-- 									<input type="radio" name="university" -->
<!-- 										value="nicht interessiert"> <label for="male">Nicht -->
<!-- 										Interessiert</label> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"></div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>Username :</label> <input type="Text" -->
<!-- 										placeholder="Username" name="userName" required /> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label class="TextLabel" for="male">Integration Course -->
<!-- 										?</label> <input type="radio" name="integration_course" value="Yes" -->
<!-- 										required> <label for="male">Yes</label> <input -->
<!-- 										type="radio" name="integration_course" value="No"> <label -->
<!-- 										for="male">No</label> <input type="radio" -->
<!-- 										name="integration_course" value="Nicht Interessiert"> -->
<!-- 									<label for="male">Nicht Interessiert</label> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"></div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>Password :</label> <input type="password" -->
<!-- 										placeholder="Password" name="password" required /> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label class="TextLabel" for="male">DSH I or DSH II -->
<!-- 										Certificate ?</label> <input type="radio" name="dsh_course" -->
<!-- 										value="Yes" required> <label for="male">Yes</label> <input -->
<!-- 										type="radio" name="dsh_course" value="No"> <label -->
<!-- 										for="male">No</label> <input type="radio" name="dsh_course" -->
<!-- 										value="Nicht Interessiert"> <label for="male">Nicht -->
<!-- 										Interessiert</label> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"></div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>Role Type :</label> <select name="roleType" -->
<!-- 										id="roleType" required> -->
<!-- 										<option value="title">Select your Role Type</option> -->
<%-- 										<% --%>
<!--  										ArrayList<String> roleType = SqlConnection.sqlSelectRoleType(); -->
<!--  										for (int i = 2; i < roleType.size(); i++) { -->
<%-- 										%> --%>
<%-- 										<option value="<%=roleType.get(i)%>"><%=roleType.get(i)%></option> --%>
<%-- 										<% --%>
<!--  										} -->
<%-- 										%> --%>
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 								<div class="grid-item"> -->
<!-- 									<label>German Language Level :</label> <select -->
<!-- 										name="german_level" required> -->
<!-- 										<option value="A1">A1</option> -->
<!-- 										<option value="A2">A2</option> -->
<!-- 										<option value="B1">B1</option> -->
<!-- 										<option value="B2">B2</option> -->
<!-- 										<option value="C1">C1</option> -->
<!-- 										<option value="C2">C2</option> -->
<!-- 										<option value="Nicht Interessiert">Nicht Interessiert</option> -->
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 								<center> -->
<!-- 									<input type="submit" value="Submit" name="submitBtn"> -->
<!-- 								</center> -->
<!-- 								<div class="grid-item"></div> -->
<!-- 							</div> -->
<!-- 						</form> -->
					</div>
				</div>

				<div id="Calendar">
					<%
					// Find the Calendar ID and convert it to BASE64
								ResultSet r1 = null;
								String string_calendar_id = null;

								String Query1 = "Select string_calendar_id from Calendar Natural Join User NATURAL Join User_Calendar where username = '"
										+ LoginController.getLoggedInUsername() + "';";
								Statement s1 = AppWithDB.connect().createStatement();
								r1 = s1.executeQuery(Query1);
								while (r1.next()) {
									string_calendar_id = r1.getString("string_calendar_id");
								}
								String id = GoogleKalendar.utfTObase(string_calendar_id);
								String publicCalendarId = GoogleKalendar.utfTObase("vaks.noreply@gmail.com");
								System.err.println(id);
					%>
					<div class="page-wrap">
						<!-- The ID's here most be in Base64
							 1. Calendar is personal Calendar
							 2. Calendar is the public Calendar
							 3. Calendar is the holiday in Germany 
						-->
						<iframe
							src="https://calendar.google.com/calendar/embed?height=325&amp;wkst=2&amp;bgcolor=%23ffffff&amp;ctz=Europe%2FBerlin&amp;src=<%=id%>;src=dmFrcy5ub3JlcGx5QGdtYWlsLmNvbQ&amp;src=ZW4uZ2VybWFuI2hvbGlkYXlAZ3JvdXAudi5jYWxlbmRhci5nb29nbGUuY29t&amp;color=%239E69AF&amp;color=%230B8043&amp;showPrint=0&amp;showCalendars=0&amp;showTz=0"
							style="border: solid 1px #777" width="1300" height="600"
							frameborder="0" scrolling="no"> </iframe>
						<br>
					</div>

				</div>

				<div id="ManageEvents">
					<h2 class="header">Manage Events</h2>
					<div class="page-wrap">
					
					<div class="form-popup" id="myForm2">
							<form action="Customer/editEvent" class="form-container" method="post">
								<h1>Edit Appointment</h1>
								
<!-- 								<input type="radio" id="all2" name="privacy" value="All" required="required">  -->
<!-- 								<label for="public">For All</label>  -->
								<input type="radio" id="special2" name="privacy" value="Special" checked="checked">
								<label for="private">For Special</label><br><b>User</b> 
								<input type="hidden" id="forUser2Hidden" name="for_user">
								<select name="forUser" id="forUser2" required>
									<%
									ResultSet r44 = null;
																String Query44 = "Select user_id, first_name, last_name From User Natural Join User_Role Natural Join Role Natural Join  Residence_Permit Natural Join User_Residence_Permit Natural Join Mother_Language Natural Join User_Mother_Language Natural Join Address Natural Join User_Address ORDER By role_id, user_id;";
																Statement s44 = AppWithDB.connect().createStatement();
																r44 = s44.executeQuery(Query44);
																while (r44.next()) {
																	String user_id = r44.getString("user_id");
																	String first_name = r44.getString("first_name");
																	String last_name = r44.getString("last_name");
									%>
									<option value="<%=user_id%>"><%=user_id + ", " + first_name + " " + last_name.toUpperCase()%></option>
									<%
									}
																r44.close();
																s44.close();
									%>
								</select> 
								 
								<input type="hidden"name="event_id" id="event_id2" required>
								
								<label for="title"><b>Title</b></label> 
								<input type="text"name="title" id="title2" required> 
								
								<label for="date"><b>Date</b></label>
								<input type="date" name="date" id="date2" required> 
								
								<label for="startTime"><b>Start Time</b></label> 
								<input type="time" name="startTime" id="startTime2" required> 
								
								<label for="endTime"><b>End Time</b></label> 
								<input type="time" name="endTime" id="endTime2" required> 
								
								<label for="location"><b>Location</b></label> 
								<input type="text" name="location" id="location2">

								<button type="submit" class="btn">Edit</button>
								<button type="button" class="btn cancel" onclick="closeForm2()">Cancel and Close</button>

							</form>
						</div>

<!-- 							<form action="Customer/showEvents" method="post"> -->
							
<!-- 								<label>Search By Date</label> -->
<%-- 								<input type="date" name="search" id="myDate"  value= "<%=CustomerController.defaultDate%>" onchange="this.form.submit()"> --%>
<!-- 								<br> <br> -->
<!-- 								<label>Search By User</label> -->
<!-- 								<input list="brow" name="search" onchange="this.form.submit()"> -->
<!-- 								<br> <br> -->
								 
<!-- 								<datalist id="brow"> -->
<%-- 													<% --%>
<!-- 													ResultSet r8 = null; -->
<!-- 													String Query8 = "Select user_id, first_name, last_name From User Natural Join User_Role Natural Join Role Natural Join  Residence_Permit Natural Join User_Residence_Permit Natural Join Mother_Language Natural Join User_Mother_Language Natural Join Address Natural Join User_Address ORDER By role_id, user_id;"; -->
<!-- 													Statement s8 = SqlConnection.connect().createStatement(); -->
<!-- 													r8 = s8.executeQuery(Query8); -->
<!-- 													while (r8.next()) { -->
<!-- 														String user_id = r8.getString("user_id"); -->
<!-- 														String first_name = r8.getString("first_name"); -->
<!-- 														String last_name = r8.getString("last_name"); -->
<!-- 													%> -->
<%-- 													<option value="<%=user_id%>"><%=first_name + " " + last_name.toUpperCase()%></option> --%>
<%-- 													<% --%>
<!-- 													} -->
<!-- 													r8.close(); -->
<!-- 													s8.close(); -->
<!-- 													%> -->
<!-- 													</datalist> -->
<!-- 													</form> -->
						<div class="scrollit">
												
								
								
							
							
							
							
								<form action="Customer/deleteEvent" method="post">							
								<table id="EventTable" class="table table-bordered">
									<thead>
										<tr>
											<th>Event ID</th>
											<th>Event Name</th>
											<th>Start Date</th>
											<th>End Date</th>
											<th>Start Time</th>
											<th>End Time</th>
											<th>Location</th>
											<th>Created By</th>
											<th>Delete</th>
<!-- 											<th>Edit</th> -->
										</tr>
									</thead>
									<tbody>
										<%
										ResultSet r10 = null;
																		String Query10 = "Select DISTINCT event_id, event_name, from_date, to_date, from_time, to_time, location, created_by_user_id From Event  Natural Join User_Event Natural Join User Where for_user_id = '" + LoginController.getLoggedInUserId() + "' AND user_id=for_user_id;";
																		Statement s10 = null;
																		s10 = AppWithDB.connect().createStatement();
																		r10 = s.executeQuery(Query10);

																		while (r10.next()) {
																			String event_id = r10.getString("event_id");
																			String event_name = r10.getString("event_name");
																			String from_date = r10.getString("from_date");
																			String to_date = r10.getString("to_date");
																			String from_time = r10.getString("from_time");
																			String to_time = r10.getString("to_time");
																			String location = r10.getString("location");
																			
																			
																			String created_by_user_id = r10.getString("created_by_user_id");
																			
																			ResultSet r101 = null;
																			String Query101 = "Select user_id, first_name, last_name from User where user_id = '" + created_by_user_id + "'";
																			Statement s101 = null;
																			s101 = AppWithDB.connect().createStatement();
																			r101 = s101.executeQuery(Query101);
																			
																			while (r101.next()) {
																				String first_name = r101.getString("first_name");
																				String last_name = r101.getString("last_name");
																			
																				LocalDate today = java.time.LocalDate.now();
																				LocalDate eventDay = java.time.LocalDate.parse(from_date);
																				
																				if(today.compareTo(eventDay) < 0 ) { // Coming Event
										%>

												<tr>
													<td><%=event_id%></td>
													<td><%=event_name%></td>
													<td><%=from_date%></td>
													<td><%=to_date%></td>
													<td><%=from_time%></td>
													<td><%=to_time%></td>
													<td><%=location%></td>
													<td><%=first_name + ", " + last_name.toUpperCase()%></td>

													<td><input type="submit" Value="Delete"
														name="actionBtnValue" onClick="deleteConfirmEvent()"></td>
		<!-- 											<td><button onclick="openForm()">Edit1</button></td> -->
<!-- 													<td><button type="button" onclick="editConfirmEvent(); openForm2();">Edit</button></td> -->
												</tr>
												<%
												} else { // Past Event
												%>
												<tr>
													<td><%=event_id%></td>
													<td><%=event_name%></td>
													<td><%=from_date%></td>
													<td><%=to_date%></td>
													<td><%=from_time%></td>
													<td><%=to_time%></td>
													<td><%=location%></td>
													<td><%=first_name + ", " + last_name.toUpperCase()%></td>

													<td style="color:red">Past Event ! Not More Deletable</td>
		<!-- 											<td><button onclick="openForm()">Edit1</button></td> -->
<!-- 													<td><button type="button" onclick="editConfirmEvent(); openForm2();">Edit</button></td> -->
												</tr>
												<%
												}
																					}
																					r101.close();
																					s101.close();
																				}
																				r10.close();
																				s10.close();
												%>

									</tbody>
								</table>
								<input type="hidden" name="event_id_hidden" id="event_id_hidden" />
							</form>
						</div>
						
						
						
<!-- 						<button class="open-button">Book An Appointment</button> -->
						​
						<div class="form-popup2" id="myForm">
						<center><h3>Booking an Appointment</h3></center>
						
						<form action="Customer/selectDate" class="form-container" method="post">
						<label for="date">Date</label>
						<select name="date" onchange="this.form.submit()" required>
						<option value="" disabled="disabled" selected="selected">Select a date</option>
								<%
								int limit=0;
															for ( int i=1; i<25 ; i++) {
																SimpleDateFormat sdf = new SimpleDateFormat("E, yyyy-MM-dd");
																//Getting current date
																Calendar cal = Calendar.getInstance();
																//Displaying current date in the desired format
																String now = sdf.format(cal.getTime()).toString();
																//Number of Days to add
															    cal.add(Calendar.DAY_OF_MONTH, i);  
																//Date after adding the days to the current date
																String firstDay = sdf.format(cal.getTime());  
																//Displaying the new Date after addition of Days to current date
																
																System.out.println("Date after Addition: "+firstDay);
																
																if(!firstDay.split(",")[0].equals("Sat") && !firstDay.split(",")[0].equals("Sun")) {
																	
																	if(limit!=15){
																	limit++;
																	ResultSet rss = null;
																	String Queryq = "Select string_calendar_id from User Natural Join Calendar Natural Join User_Calendar where user_id = ( Select worker_id from Kunde_Supervised_By_Worker where kunde_id='" + LoginController.getLoggedInUserId() + "');";
																	Statement sss = null;
																	sss = AppWithDB.connect().createStatement();
																	rss = sss.executeQuery(Queryq);
																	String string_calendar_id_s = null;
																	while (rss.next()) {
																		string_calendar_id_s = rss.getString("string_calendar_id");
																	}
								// 											ArrayList<String> avalibleTime = GoogleKalendar.avalibleTimeForUser(string_calendar_id_s, firstDay.split(", ")[1]);
								// 											if(avalibleTime.size()>0) {
								%>
													<option value="<%=firstDay.split(", ")[1]%>"><%=firstDay%></option>
												<%
												// 												}											
																					} else {
																						break;
																						}
																						
																					} 
																			}
												%>	
								</select>
								</form>
						
							<form action="Customer/createEvent" class="form-container" method="post">
								
<!-- 								​<input type="radio" id="all" name="privacy" value="All" onclick="enableUserSelect()" required="required">  -->
<!-- 								<label for="public">For All</label>  -->
								<input type="radio" id="special" name="privacy" value="Special" onclick="enableUserSelect()" checked="checked" hidden="hidden">
								<label for="private" hidden="hidden">For Special</label> 
								
								<label for="user" hidden="hidden"><b>User</b></label> 
								<select name="forUser" id="forUser" required hidden="hidden">
									<option value="<%=LoginController.getLoggedInUserId()%>"><%=LoginController.getLoggedInUserId()%></option>	
								</select>
								 
								<label for="time"><b>Time</b></label>
								<select name="time" id="time" required>
								<%
								ResultSet rss = null;
														String Queryq = "Select string_calendar_id from User Natural Join Calendar Natural Join User_Calendar where user_id = ( Select worker_id from Kunde_Supervised_By_Worker where kunde_id='" + LoginController.getLoggedInUserId() + "');";
														Statement sss = null;
														sss = AppWithDB.connect().createStatement();
														rss = sss.executeQuery(Queryq);
														String string_calendar_id_s = null;
														while (rss.next()) {
															string_calendar_id_s = rss.getString("string_calendar_id");
														}
														if(!CustomerController.bookingSelectedDate.equals("basic"))  {
															ArrayList<String> time = GoogleKalendar.avalibleTimeForUser(string_calendar_id_s, CustomerController.bookingSelectedDate);
															for(int i=0 ; i<time.size(); i++) {
								%>
									<option value="<%=time.get(i)%>"><%=time.get(i)%></option>
									<%
									}
															}
															else {
									%>
									<option value="">Select Date First</option>
									<%
									}
									%>	
								</select>
								
								<label for="title"><b>Title</b></label> 
								<input type="text" name="title" id="title" required>
								
								 
								 
<!-- 								<label for="startTime"><b>Start Time</b></label>  -->
<!-- 								<input type="time" name="startTime" required>  -->
<!-- 								<label for="endTime"><b>End Time</b></label>  -->
<!-- 								<input type="time" name="endTime" required>  -->
								<label for="location" hidden="hidden"><b>Location</b></label> 
								<input type="text" name="location" id="location" hidden="hidden">

								<button type="submit" class="btn">Book</button>
<!-- 								<button type="button" class="btn cancel" onclick="closeForm()">Cancel and Close</button> -->

							</form>
						</div>
						
						
						
						
					</div>
				</div>

				<div id="Documents">
					<h2 class="header">Manage Documents</h2>
					<div class="page-wrap">
					
					<form action="Customer/searchByUser_Document" method="post">
							
<!-- 								<label>Select Documents Type : </label> -->
								 
								<Select id="brow2"  name="searchDocumentUser" onchange="this.form.submit()">
									<option value="Select">Select Documents Type : </option>
									<option value="-- Public Documents --">Show Public Documents</option>
									<option value="-- My Documents --">Show Just My Documents</option>
 								</Select>
 						</form>
					
						<div class="scrollit">
							<form action="Customer/deleteDocument" method="post">
								<table id="DocumentTable" class="table table-bordered">
									<thead>
										<tr>
											<th>ID</th>
											<th>Name</th>
											<th>Language</th>
											<th>Type</th>
											<th>Belong To</th>
											<th>Download</th>
											<th>Delete</th>
										</tr>
									</thead>
									<tbody>
										<%
										if(CustomerController.documentSearch.equals("empty")){
																			
																			
																		}
																		else if (CustomerController.documentSearch.equals("-- Public Documents --")) {
																			
																			ResultSet r2 = null;
																			String Query2 = "Select document_id, document_name, document_language, Type.document_type, document_for_user, User_Document.user_id FROM Document NATURAL JOIN Type Natural JOIN Document_Type Natural Join User_Document where User_Document.document_for_user='';";
																			Statement s2 = AppWithDB.connect().createStatement();
																			r2 = s2.executeQuery(Query2);
																			while (r2.next()) {
																				String document_id = r2.getString("document_id");
																				String document_name = r2.getString("document_name");
																				String document_language = r2.getString("document_language");
																				String document_type = r2.getString("document_type");
																				String document_for_user = r2.getString("document_for_user");
																				String user_id = r2.getString("user_id");
																				
																				
																				ResultSet r22 = null;
																				String Query22 = "select first_name, last_name from User Where user_id='" + document_for_user + "';"; 
																				Statement s22 = AppWithDB.connect().createStatement();
																				r22 = s22.executeQuery(Query22);
																				String first_name=null;
																				String last_name=null;
																				while (r22.next()) {
																					first_name = r22.getString("first_name");
																					last_name = r22.getString("last_name");
																				}
																				r22.close();
																				s22.close();
										%>
														<tr>
															<td style="color:green"><%=document_id%></td>
															<td style="color:green"><%=document_name.split("<>")[0]%></td>
															<td style="color:green"><%=document_language%></td>
															<td style="color:green"><%=document_type%></td>
															<td style="color:green">-</td>
															<td ><a href="Volunteer/downloadDocument/<%=document_id%>">Download</a></td>
															<td style="color:red">NOT ALLOWED</td>
														</tr>
														<%
														}
																							r2.close();
																							s2.close();
																							
																						} else if (CustomerController.documentSearch.equals("-- My Documents --")) {
																							
																							ResultSet r2 = null;
																							String Query2 = "Select document_id, document_name, document_language, Type.document_type, document_for_user FROM Document NATURAL JOIN Type Natural JOIN Document_Type Natural Join User_Document where User_Document.document_for_user='" + LoginController.getLoggedInUserId() + "';";
																							Statement s2 = AppWithDB.connect().createStatement();
																							r2 = s2.executeQuery(Query2);
																							while (r2.next()) {
																								String document_id = r2.getString("document_id");
																								String document_name = r2.getString("document_name");
																								String document_language = r2.getString("document_language");
																								String document_type = r2.getString("document_type");
																								String document_for_user = r2.getString("document_for_user");
																								
																								
																								ResultSet r22 = null;
																								String Query22 = "select first_name, last_name from User Where user_id='" + document_for_user + "';"; 
																								Statement s22 = AppWithDB.connect().createStatement();
																								r22 = s22.executeQuery(Query22);
																								String first_name=null;
																								String last_name=null;
																								while (r22.next()) {
																									first_name = r22.getString("first_name");
																									last_name = r22.getString("last_name");
																								}
																								r22.close();
																								s22.close();
														%>

													<tr>
														<td style="color:red"><%=document_id%></td>
														<td style="color:red"><%=document_name.split("<>")[0]%></td>
														<td style="color:red"><%=document_language%></td>
														<td style="color:red"><%=document_type%></td>
														<td style="color:red">Me</td>
														<td ><a href="Volunteer/downloadDocument/<%=document_id%>">Download</a></td>
														<td ><input type="submit" Value="Delete"
															name="actionBtnValue" onClick="deleteConfirmDocument()"></td>
													</tr>
													<%
													}
																						r2.close();
																						s2.close();
																						
																					}
													%>

									</tbody>
								</table>
								<input type="hidden" name="document_id_hidden"
									id="document_id_hidden" />
							</form>
						</div>
						<br> <br> <input type="button" Value="Add Document"
							onclick="showHideDiv(2)">
						<form action="Customer/uploadDocument" method="post" enctype="multipart/form-data">
							<div class="AddDocument-container " id="AddDocument-container" style="visibility: hidden">
								<label>Name :</label> 
								<input type="text" name="name"> 
								<label>Language :</label> 
								<input type="text" name="language" required> 
<!-- 								<label>Type :</label>  -->
								<select name="Type" id="document_type" required onchange="enableDocumentForUser(this)" hidden="hidden">
									<%
									ResultSet r3 = null;
																String Query3 = "Select document_type From Type where document_type='For User';";
																Statement s3 = AppWithDB.connect().createStatement();
																r3 = s3.executeQuery(Query3);
																while (r3.next()) {
																	String document_type = r3.getString("document_type");
									%>
									<option value="<%=document_type%>" selected="selected"><%=document_type%></option>
									<%
									}
									r3.close();
									s3.close();
									%>
								</select>
								
<!-- 								<label>For User :</label> -->
								<input list="brow" name="document_for_user" id="document_for_user" value="<%=LoginController.getLoggedInUserId() %>" hidden="hidden">
								<br> <br>		
								<input type="file" name="browse" required>
								<input type="submit" name="submitBtn" value="Upload" required> 
								

							</div>
						</form>
					</div>
				</div>

<!-- 				<div id="Statistics"> -->
<!-- 					<h2 class="header">Statistics</h2> -->
<!-- 				</div> -->


				<!-- 				<div id="widgets"> -->
				<!-- 					<h2 class="header">widgets</h2> -->
				<!-- 				</div> -->

				<!-- 				<div id="plugins"> -->
				<!-- 					<h2 class="header">plugins</h2> -->
				<!-- 				</div> -->

				<!-- 				<div id="users"> -->
				<!-- 					<h2 class="header">users</h2> -->
				<!-- 				</div> -->

				<!-- 				<div id="tools"> -->
				<!-- 					<h2 class="header">tools</h2> -->
				<!-- 				</div> -->

				<!-- 				<div id="settings"> -->
				<!-- 					<h2 class="header">settings</h2> -->
				<!-- 				</div> -->

			</div>

		</div>
	</div>

	<script>
		//add event listener to table rows
		function deleteConfirmUser(a) {
			let thetable = document.getElementById('UserTable')
					.getElementsByTagName('tbody')[0];
			for (let i = 0; i < thetable.rows.length; i++) {
				thetable.rows[i].onclick = function() {
					TableRowClick(this, a);
				};
			}
		}

		function TableRowClick(therow, y) {
			let msg = therow.cells[0].innerHTML;
			if (y == 1) {
				var r = confirm("Do you want to delete the user " + msg + "?");
				if (r != true) {
					msg = "cancel";
				}
				document.getElementById('user_id_hidden').value = msg;
			} else {
				var r = confirm("Do you want to edit the user " + msg + "?");
				if (r != true) {
					msg = "cancel";
				}
				document.getElementById('user_id_hidden').value = msg;
			}
		};

		function showHideDiv(a) {
			if (a == 1) {
				var x = document.getElementById("AddUser-container");
				if (x.style.visibility === "hidden") {
					x.style.visibility = "visible";
				} else {
					x.style.visibility = "hidden";
				}
			} else if (a == 2) {
				var x = document.getElementById("AddDocument-container");
				if (x.style.visibility === "hidden") {
					x.style.visibility = "visible";
				} else {
					x.style.visibility = "hidden";
				}

			}
		}

		function showHideBar(d) {
			var onediv = document.getElementById(d);
			var divs = [ 'Dashboard', 'User', 'Calendar', 'Documents', 'ManageEvents' ];
			for (var i = 0; i < divs.length; i++) {
				if (onediv != document.getElementById(divs[i])) {
					document.getElementById(divs[i]).style.display = 'none';
				}
			}
			onediv.style.display = 'block';
		}

		//add event listener to table rows
		function deleteConfirmDocument() {
			let thetable2 = document.getElementById('DocumentTable')
					.getElementsByTagName('tbody')[0];
			for (let i = 0; i < thetable2.rows.length; i++) {
				thetable2.rows[i].onclick = function() {
					TableRowClick2(this);
				};
			}
		}
		function TableRowClick2(therow) {
			let msg2 = therow.cells[0].innerHTML;

			var r = confirm("Do you want to delete the Document " + msg2 + "?");
			if (r != true) {
				msg2 = "cancel";
				document.getElementById('document_id_hidden').value = msg2;
			} else {
				document.getElementById('document_id_hidden').value = msg2;
			}
		};

		function openForm() {
			document.getElementById("myForm").style.display = "block";
		}

		function closeForm() {
			document.getElementById("myForm").style.display = "none";
		}
		
		function openForm2() {
			document.getElementById("myForm2").style.display = "block";
		}

		function closeForm2() {
			document.getElementById("myForm2").style.display = "none";
		}

		function enableUserSelect() {
			if (document.getElementById("all").checked) {
				document.getElementById("forUser").disabled = true;

			} else if (document.getElementById("special").checked) {
				document.getElementById("forUser").disabled = false;

			}
		}
		
		
		
		
		//add event listener to table rows
		function deleteConfirmEvent() {
			let thetable3 = document.getElementById('EventTable')
					.getElementsByTagName('tbody')[0];
			for (let i = 0; i < thetable3.rows.length; i++) {
				thetable3.rows[i].onclick = function() {
					TableRowClick3(this);
				};
			}
		}
		function TableRowClick3(therow) {
			let msg3 = therow.cells[0].innerHTML;

			var r = confirm("Do you want to delete the Event " + msg3 + "?");
			if (r != true) {
				msg3 = "cancel";
				document.getElementById('event_id_hidden').value = msg3;
			} else {
				document.getElementById('event_id_hidden').value = msg3;
			}
		};
		
		function editConfirmEvent() {
			let thetable4 = document.getElementById('EventTable')
					.getElementsByTagName('tbody')[0];
			for (let i = 0; i < thetable4.rows.length; i++) {
				thetable4.rows[i].onclick = function() {
					TableRowClick4(this);
				};
			}
		}
		function TableRowClick4(therow) {
			let event_id = therow.cells[0].innerHTML;
			let event_name = therow.cells[1].innerHTML;
			let start_date = therow.cells[2].innerHTML;
			let end_date = therow.cells[3].innerHTML;
			let start_time = therow.cells[4].innerHTML;
			let end_time = therow.cells[5].innerHTML;
			let location = therow.cells[6].innerHTML;
			let user_id = therow.cells[7].innerHTML;
			
			if (user_id == '-') {
				document.getElementById("all2").checked = true;
				}
			else {
				document.getElementById("special2").checked = true;
			}
			
			document.getElementById('event_id2').value = event_id;
			
			document.getElementById('title2').value = event_name;
			
			document.getElementById('date2').value = start_date;
			
			document.getElementById('startTime2').value = start_time;
			
			document.getElementById('endTime2').value = end_time;
			
			document.getElementById('location2').value = location;
			
			document.getElementById('forUser2').value=user_id;
			
			document.getElementById('forUser2Hidden').value=user_id;

		};
		
		function enableDocumentForUser(obj){
			document.getElementById('document_for_user').setAttribute('disabled',true);
			if(obj.value == "For User")
				document.getElementById('document_for_user').removeAttribute('disabled');
		 
			}
	</script>


</body>
</html>