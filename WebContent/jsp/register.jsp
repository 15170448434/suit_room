<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>    
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>注册界面</title>
		<link rel="stylesheet" href="../css/register.css" />
		<link rel="stylesheet" href="../css/main.css" />
		<script src="<%=basePath%>/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="<%=basePath%>/js/main.js"type="text/javascript" charset="utf-8"></script>
	    <script src="<%=basePath%>/js/register.js" type="text/javascript" charset="utf-8"></script>   
	</head>
<body>
	<div id="background_re">
		<div class="registerForm">
			<div class="topText">注册</div>
			<form method="post" class="form">
				<table>
					<tr>
						<td>用户名称:</td>
						<td><input id="userName" type="text" name="userName"
							autocomplete="off" /></td>
					</tr>
					<tr>
						<td>用户实名:</td>
						<td><input id="userRealName" type="text" name="userRealName"
							autocomplete="off" /></td>
					</tr>
					<tr>
						<td>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:</td>
						<td><input id="passWd" type="password" name="passWd"
							autocomplete="off" /></td>
					</tr>

					<tr>
						<td>密码确认:</td>
						<td><input id="rePassWd" type="password" name="rePassWd"
							autocomplete="off" /></td>
					</tr>
				</table>
				性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别: <label
					style="margin-left: 30px;"> <input type="radio" name="sex"
					value="1" id="maleRadio" onclick="male_display()" /> <span>男</span>
				</label> <label style="margin-left: 40px;"> <input type="radio"
					name="sex" value="0" id="femaleRadio"
					onclick="female_display()" /> <span>女</span>
				</label>
				<div class="subTitle">模型选择</div>
				<div id="malePortrait" align="center" style="display: none;">
					<label> <input type="radio" name="portrait"
						value="../images/data/model/mheadA.png" /> <img
						src="../images/data/model/mheadA.png" name="one"
						style="width: 54px; height: 81px;" />
					</label> <label> <input type="radio" name="portrait"
						value="../images/data/model/mheadB.png" /> <img
						src="../images/data/model/mheadB.png" name="two"
						style="width: 54px; height: 81px;" />
					</label>
				</div>
				<div id="femalePortrait" align="center" style="display: none;">
					<label> <input type="radio" name="portrait"
						value="../images/data/model/wheadA.png" /> <img
						src="../images/data/model/wheadA.png" name="three"
						style="width: 54px; height: 81px;" />
					</label> <label> <input type="radio" name="portrait"
						value="../images/data/model/wheadB.png" /> <img
						src="../images/data/model/wheadB.png" name="four"
						style="width: 54px; height: 81px;" />
					</label>
				</div>
				<div id="buttonBox" align="center">
					<input type="button" value="点击注册" id="register_submit"
						onclick="doAdd()"></input> <input type="button" value="返回登录"
						id="back_button" onclick="backJSP()"></input>
				</div>
			</form>

		</div>
	</div>
	</body>
	<script type="text/javascript" charset="utf-8">
	


	var malePortrait = document.getElementById("malePortrait");
		var femalePortrait = document.getElementById("femalePortrait");
		var sex = document.getElementsByName("sex");
		var password = document.getElementsByName("passWd")[0];
		var password_re = document.getElementsByName("rePassWd")[0];
		var username = document.getElementsByName("userName")[0];
		var realName = document.getElementsByName("userRealName")[0];
		var portrait = document.getElementsByName("portrait");	
		
		function backJSP() {
			$(location).attr('href','http://localhost:8080/suit/jsp/login.jsp');
		}
		


		
function male_display() {
		femalePortrait.style.display = "none";
		malePortrait.style.display = "block";
		for(var i = 0; i < portrait.length; i++) {
			if(portrait[i].checked) {
				portrait[i].checked="";
				break;
			}
		}
	}		
	function female_display() {
		femalePortrait.style.display = "block";
		malePortrait.style.display = "none";
		for(var i = 0; i < portrait.length; i++) {
			if(portrait[i].checked) {
				portrait[i].checked="";
				break;
			}
		}
	}
	

	function check() {
	
		//		var reg = /^[1-9]\d*$|^0$/; // 注意：故意限制了 0321 这种格式，如不需要，直接reg=/^\d+$/;
		if(username.value.length < 1) {
			alert("用户名称不能为空！ ");
			return false;
		}
		if(realName.value.length < 1) {
			alert("用户实名不能为空！ ");
			return false;
		}
		if(password.value.length < 1) {
			alert("密码不能为空！ ");
			return false;
		}
		if(password_re.value.length < 1) {
			alert("重复密码不能为空！ ");
			return false;
		}
		if(password_re.value != password.value) {
			
			alert("两次密码不相同");
			return false;
		}
		var isChecked = false;
		for(var i = 0; i < sex.length; i++) {
			if(sex[i].checked) {
				isChecked = true;
				break;
			}
		}
		if(!isChecked) {
			alert("请选择性别");
			return false;
		}
		isChecked = false;
		for(var i = 0; i < portrait.length; i++) {
			if(portrait[i].checked) {
				isChecked = true;
				break;
			}
		}
		if(!isChecked) {
			alert("请选择头像");
			return false;
		}
		return true;
	}

function getUserSex()
{
	var obj = document.getElementsByName("sex");
	//var obj = document.getElementsByTagName("input");
    for(var i=0; i<obj.length; i ++){
        if(obj[i].checked){
        	if(obj[i].value==1)
        		{return true;	}
        	else	{  return false;	}
         
        }
    }
    alert("性別未选择！")
    return false;
}
function getUserImage()
{
	var obj = portrait;
	//var obj = document.getElementsByTagName("input");
    for(var i=0; i<obj.length; i ++){
        if(obj[i].checked){
            return obj[i].value;
        }
    }
}

function doAdd(){
	if(check()==true){
		var user = {};
		user.userName = $("#userName").val();
		user.passWd = $("#passWd").val();
		user.userRealName = $("#userRealName").val();
		user.userAdmin=false;
		user.userSex =getUserSex();
		user.userAvatar=getUserImage();
		request("POST","<%=basePath%>/user/add",user,showMessage,serverError,true);
	}
}


</script>
</html>