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
<title>修改信息</title>
<link rel="stylesheet" href="../css/iframe_content.css" />
	<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
		<script type="text/javascript"  charset="utf-8" src="<%=basePath%>/js/main.js" ></script>
<%-- 		<script type="text/javascript"  charset="utf-8" src="<%=basePath%>/js/changeInformation.js" ></script> --%>
</head>

<body>
	<div class="changeForm">
		<div class="topText">信息修改 </div>
		<form  method="post" class="form">
			<table>
				<tr>
				<input id="userId" type="hidden"/>
					<td>用户名称:</td>
					<td><input type="text" id="userName" name="userName"  readonly="readonly"  autocomplete="off" /></td>
				</tr>
				<tr>
					<td>用户实名:</td>
					<td><input type="text" id="userRealName" name="userRealName"
						autocomplete="off" /></td>
				</tr>
				<tr>
					<td>密 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:</td>
					<td><input type="text" id="passWd" name="passWd"
						autocomplete="off"/></td>
				</tr>

				<tr>
					<td>密码确认:</td>
					<td><input type="text" id="rePassWd" name="rePassWd"
						 autocomplete="off"/></td>
				</tr>

				<tr>
					<td>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别:</td>
					<td align="center"><label  style="margin-left:50px"><input type="radio" name="sex"
							value="1" id="maleRadio" onclick="male_display()"
							style="width: auto; height: auto; margin-left: 60px" /><span>男</span></label>
						<label style="margin-left:20px"><input type="radio" name="sex" value="0"
							id="maleRadio" onclick="female_display()"
							style="width: auto; height: auto; margin-left: 10px" /><span>女</span></label>
					</td>
				</tr>


				<tr>
					<td colspan="2" class="subTitle">模型选择</td>
				</tr>
				<tr>
					<td colspan="2" id="malePortrait" align="center"
						style="display: none;"><label> <input type="radio"
							name="portrait" value="../images/data/model/mheadA.png" /> <img
							src="../images/data/model/mheadA.png" name="one"
							style="width: 70px; height: 105px;" />
					</label> <label> <input type="radio" name="portrait" value="../images/data/model/mheadB.png" />
							<img src="../images/data/model/mheadB.png" name="two"
							style="width: 70px; height: 105px;" />
					</label></td>
				</tr>
				<tr>
					<td colspan="2" id="femalePortrait" align="center"
						style="display: none;"><label> <input type="radio"
							name="portrait" value="../images/data/model/wheadA.png" /> <img
							src="../images/data/model/wheadA.png" name="three"
							style="width: 70px; height: 105px;" />
					</label> 
					<label> <input type="radio" name="portrait" value="../images/data/model/wheadB.png" />
							<img src="../images/data/model/wheadB.png" name="four"
							style="width: 70px; height: 105px;" />
					</label></td>
				</tr>

				<tr>
					<td colspan="2" width="550px"align="center"><input
						type="button" value="保存修改" id="save_button" onclick="doUpdate()"></input>
					</td>
				</tr>
			</table>
		</form>

	</div>
</body>
<script>

$(document).ready(function(){
var b="<%=session.getAttribute("userName")%>";
	var user = {}
	user.userName = b;
	request("POST","<%=basePath%>/user/listByName",user,drawList,serverError,true);
});

var malePortrait = document.getElementById("malePortrait");
var femalePortrait = document.getElementById("femalePortrait");
var sex = document.getElementsByName("sex");
var password = document.getElementsByName("passWd")[0];
var password_re = document.getElementsByName("rePassWd")[0];
var username = document.getElementsByName("userName")[0];
var realName = document.getElementsByName("userRealName")[0];
var portrait = document.getElementsByName("portrait");

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

function back() {
	window.history.go(-1);
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
	
	if(password.value.length >= 1) {
		if(password_re.value.length < 1) {
			{ 
			alert("重复密码不能为空！ ");
	    	return false;
			}
	}
		if(password_re.value != password.value) {
			
			alert("两次密码不相同");
			return false;
		}
	}
	
	if(password_re.value.length >= 1) {
		if(password.value.length < 1) {
			{ 
			alert("密码不能为空！ ");
	    	return false;
			}
	}
		if(password_re.value != password.value) {
			
			alert("两次密码不相同");
			return false;
		}
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


function getUserImage()
{
	var obj = document.getElementsByName("portrait");
	//var obj = document.getElementsByTagName("input");
    for(var i=0; i<obj.length; i ++){
        if(obj[i].checked){
            return obj[i].value;
        }
    }
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

function doUpdate(){
	if(check()==true)
	{
	var user = {};
	user.id = $("#userId").val();
	user.userName = $("#userName").val();
	user.userRealName = $("#userRealName").val();
	user.userSex = getUserSex();
	user.passWd = $("#passWd").val();
	user.userAvatar=getUserImage();
	request("POST","<%=basePath%>/user/update",user,drawList,serverError,true);	
	}
}

function drawList(responseData){
	if(responseData.description=="查询成功"){}	
	else{showMessage(responseData);}
	if(responseData.code<0){
		return;
	}
	var users = responseData.data;
	$(users).each(function(index,item){
		var sexx;
		$("#userId").val(item.id);
			$("#userName").val(item.userName);
			//$("#passWd").val(item.passWd);
			$("#tempPassWd").val(item.passWd);
			$("#userRealName").val(item.userRealName);
			if(item.userSex==true)
				{	sexx=1;	}
			else	{ sexx=0;	}
		   $("input[name=sex][value="+sexx+"]").attr("checked","true");
		   for(var i = 0; i < sex.length; i++) {
				if(sex[i].checked) {
					if(i == 1){
						femalePortrait.style.display = "block";
						malePortrait.style.display = "none";
					}
				}
				else{
						femalePortrait.style.display = "none";
						malePortrait.style.display = "block";
					}
			}
		   for(var i = 0; i < portrait.length; i++) {
			   if(item.userAvatar == portrait[i].value)
				   portrait[i].checked="true";
		   }

		});	
	}

	</script>
</html>


