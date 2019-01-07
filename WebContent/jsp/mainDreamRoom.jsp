<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="../css/mainDR.css" />
	<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
	<script type="text/javascript"  charset="utf-8" src="<%=basePath%>/js/main.js"></script>
<title>主界面</title>
</head>
<body>
	<div class="box">
		<div class="box-left">
			<img src="../images/ui/boy.png" class="img" />
		</div>
		<div class="box-center">
			<div id="nowUser" class="box1">当前用户: 
			<div id="userLogo" style="height:50px;width:50px;position:absolute;top:-10px;left:380px;">
					<img id="userSign" src="" class="img" style="width:50px;height:50px"/>
				</div>
				<div> <input type="text" readonly="readonly" style="color:skyblue;font-size:34px;position:absolute;margin-top:-30px;left:450px;"  id="nameArea" /></div>
			 <div id="mainLogo" style="position:absolute;margin-top:-30px;margin-left:900px;">
					<img  src="../images/ui/mainLogo.png" />
				</div>
			 </div>
			
			<div class="box2">
				<div class="box2-1">
					<ul>
						<li><a href="changeInformation.jsp" target="port"><img src="../images/ui/self.png" /></a></li>
						<li><a href="userManage.jsp" target="port"><img src="../images/ui/userList.png" /></a></li>
						<li><a href="clothCatalog.jsp" target="port"><img src="../images/ui/catalog.png" /></a></li>
						<li><a href="clothManage.jsp" target="port"><img src="../images/ui/suits.png" /></a></li>
						<li><a href="fittingRoom.jsp" target="port"><img src="../images/ui/mySuits.png" /></a></li>
						<li><a href="login.jsp"><img src="../images/ui/exit.png" /></a></li>
					</ul>
				</div>
				<div class="box2-2">
					<iframe name="port" style="backgroud:transparent" src="" width="960" height="780"></iframe>
				</div>
			</div>
		</div>

		<div class="box-right">
			<img src="../images/ui/girl.png" class="img" />
		</div>
	</div>

</body>
<script type="text/javascript">

$(document).ready(function(){
var tempb= "<%=session.getAttribute("userName")%>";
	var user = {}
	user.userName = tempb;
	request("POST","<%=basePath%>/user/listByName",user,changeJspUrl,serverError,true); 
	
});		
function changeJspUrl(responseData){
	if(responseData.code<0){
		return;
	}
	var users = responseData.data;
	$(users).each(function(index,item){
		if(item.userAdmin==true)
			{
			$("#userSign").attr("src","../images/ui/admin.png")
			}else{
				$("#userSign").attr("src","../images/ui/userLogo.png")
			}
		$("#nameArea").val(item.userRealName);
		});	

	}
</script>
</html>