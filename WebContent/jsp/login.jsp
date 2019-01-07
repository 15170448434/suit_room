<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>登录界面</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
	<link rel="stylesheet" type="text/css" href="../css/main.css" />
	<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=basePath%>/js/main.js"></script>
	<%-- <script type="text/javascript" charset="utf-8" src="<%=basePath%>/js/login.js" ></script> --%>
</head>
<body>
	<div class="all">
		<div class="loginForm">
			<div class="top">
				<img src="../images/ui/logo.png" width="50%">
			</div>
			<form method="post" class="form" action="">
				<table>
					<tr>
						<td> <img src="../images/ui/user.png" /></td><td><input id="userName" placeholder="用户名" type="text"
							name="userName" autocomplete="off" /></td>
					</tr>
					<tr>
						<td><img src="../images/ui/password.png" /></td><td><input id="passWd" placeholder="密码" type="password"
							name="passWd" autocomplete="off"/></td>
					</tr>
				</table>

				<input type="button" value="我要登录" id="login_button" onclick="doSearch()" /><br />
				<input type="button" value="我要注册" id="register_button" onclick="jumpJsp()"></input>

			</form>
		</div>
		
		<div class="logoImg">
			<img src="../images/ui/dream.png" />
		</div>
		<div class="pleaselogin">
			<img src="../images/ui/pleaseLogin.png" /></div>
		<div class="logoFont">
			<img src="../images/ui/windowsTheam.png" />
		</div>
	</div>
</body>
<script type="text/javascript">

function jumpJsp()
{
	$(location).attr('href','http://localhost:8080/suit/jsp/register.jsp');
}

function showLoginMessage(responseData){
	showMessage(responseData);
	
	if(responseData.code<0){
		return ;	
	}
	$(location).attr('href','http://localhost:8080/suit/jsp/mainDreamRoom.jsp');
	if(responseData.code==-20)
		{
		console.log("用户不存在11");
		}
	if(responseData.code==-10)
		{
		console.log("密码错误11");
		}
		
}

function doSearch(){
	if(check()==true)
		{
	    var user = {};
	    user.userName = $("#userName").val();
	    user.passWd = $("#passWd").val();
	    request("POST","<%=basePath%>/user/loginCheck",user,showLoginMessage,serverError,true);
		}
	}
function check() {

	var password = document.getElementsByName("passWd")[0];
	var username = document.getElementsByName("userName")[0];
	var reg = /^[1-9]\d*$|^0$/; // 注意：故意限制了 0321 这种格式，如不需要，直接reg=/^\d+$/;
	if (username.value.length < 1) {
		alert("用户名不能为空！ ");
		return false;
	}
	if (password.value.length < 1) {
		alert("密码不能为空！ ");
		return false;
	}
/*	if (reg.test(username.value) == true) {
		alert("提交成功 ");
		return true;
	} else {
		alert("含有非法字符 ");
		return false;
	}*/

	return true;
}


</script>
</html>
