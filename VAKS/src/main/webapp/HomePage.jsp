<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome To VAKS Siegen</title>

<style>
  df-messenger {
   --df-messenger-bot-message: #878fac;
   --df-messenger-button-titlebar-color: black;
   --df-messenger-chat-background-color: #fafafa;
   --df-messenger-font-color: white;
   --df-messenger-send-icon: #878fac;
   --df-messenger-user-message: #0e7f94;
  }
</style>

</head>
<body>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">    
<div class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">

                    <div class="navbar-header">
                        <button class="navbar-toggle" data-target="#mobile_menu" data-toggle="collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
                        <a href="HomePage.jsp" class="navbar-brand">VAKS Siegen</a>
                    </div>

                    <div class="navbar-collapse collapse" id="mobile_menu">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="#">Home</a></li>
                            <li><a href="#" class="dropdown-toggle" data-toggle="dropdown">About Us <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">About One</a></li>
                                    <li><a href="#">About Two</a></li>
                                    <li><a href="#">About Three</a></li>
                                    <li><a href="#">About Four</a></li>
                                    <li><a href="#">About Five</a></li>
                                    <li><a href="#">About Six</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Welcome</a></li>
                            <li><a href="#">Services</a></li>
                            <li><a href="#">Gallery</a></li>
                            <li><a href="#">Contact Us</a></li>
                        </ul>
                        <ul class="nav navbar-nav">
                            <li>
                                
                            </li>
                        </ul>

                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#"><span class="glyphicon glyphicon-user"></span> Profile</a></li>
                            <li><a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-log-in"></span> Login / Sign Up <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="Login">Login</a></li>
                                    <li><a href="SignUp">Sign Up</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
           <center>
            <img src="data:image/jpeg;base64,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" alt="W3Schools.com">
		   </center>


<!-- <script type="text/javascript"> -->
<!--     (function(d, m){ -->
<!--         var kommunicateSettings =  -->
<!--             {"appId":"bb07110ba3620bdcc712359b5a6e41ee","popupWidget":true,"automaticChatOpenOnNavigation":true}; -->
<!--         var s = document.createElement("script"); s.type = "text/javascript"; s.async = true; -->
<!--         s.src = "https://widget.kommunicate.io/v2/kommunicate.app"; -->
<!--         var h = document.getElementsByTagName("head")[0]; h.appendChild(s); -->
<!--         window.kommunicate = m; m._globals = kommunicateSettings; -->
<!--     })(document, window.kommunicate || {}); -->
<!-- /* NOTE : Use web server to view HTML files as real-time update will not work if you directly open the HTML file in the browser. */ -->
<!-- </script> -->
		   
<script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
<df-messenger
  intent="WELCOME"
  wait-open="1"
  chat-title="VAKS Bot"
  agent-id="25531a17-59eb-44b8-906e-8df67aac36ae"
  language-code="de"
></df-messenger>
		   
</body>
</html>