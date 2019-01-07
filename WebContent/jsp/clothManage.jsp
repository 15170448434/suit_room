<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="<%=basePath%>/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=basePath%>/js/main.js"type="text/javascript" charset="utf-8"></script>
<script src="<%=basePath%>/js/vendor/jquery.ui.widget.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=basePath%>/js/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=basePath%>/js/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

<link href="<%=basePath%>/css/jquery.fileupload.css" rel="stylesheet"type="text/css">
<link href="<%=basePath%>/css/jquery.fileupload-ui.css" rel="stylesheet"type="text/css">
<link rel="stylesheet" href="../css/clothManage.css" />
<title>服饰管理</title>
</head>
<body>
	<div class="configBox">
		&nbsp;性别: <select class="select_sex" id="select_sex">
			<option value="male">男</option>
			<option value="female">女</option>
		</select> 服饰类别: <select class="select_catalog" id="select_catalog">
			<option value="0">请选择</option>
		</select> <input type="button" value="查询" class="query_button"
			onClick="doSearch()" />
	</div>
	<div class="add_clothBox" id="add_Box">
		<div class="title">服饰细目</div>
		<form>
			<table>
				<tr>
					<td width="30%">编号：</td>
					<td width="70%"><input type="text" name="add_cloth_NO"
						id="add_cloth_NO" /></td>
				</tr>
				<tr>
					<td>名称：</td>
					<td><input type="text" name="add_cloth_name"
						id="add_cloth_name" /></td>
				</tr>
				<tr>
					<td>价格：</td>
					<td><input type="text" name="add_cloth_price"
						id="add_cloth_price" /></td>
				</tr>
				<tr>
					<td>性别：</td>
					<td><select class="select_cloth_sex" name="select_cloth_sex"
						id="select_cloth_sex">
							<option value="male">男</option>
			<option value="female">女</option>
					</select></td>
				</tr>
				<tr>
					<td>分类：</td>
					<td><select class="select_cloth_catalog"
						name="select_cloth_catalog" id="select_cloth_catalog">
							<option>请选择</option>
					</select></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="button"
						class="add_button" id="add_button" value="添加"
						onClick="add_cloth()"></td>
				</tr>
			</table>
		</form>
	</div>
	<div  id="showBox0" style="width:auto;height:auto;">	
	</div>
	
	<div style="display: none">
		<div class="clothBox" id="clothBox0">
			<div class="title">服饰类别</div>
			<form style="float: left">
				<table>
					<tr>
						<input id="clothId" type="hidden" />
						<td>编号：<input type="text" name="clothNO" id="clothNO"
							value="" />
						</td>
					</tr>
					<tr>
						<td>名称：<input type="text" name="clothName" id="clothName"
							value="" />
						</td>
					</tr>
					<tr>
						<td>价格：<input type="text" name="clothPrice" id="price"
							value="" />
						</td>
					</tr>
					<tr>
						<td>性别： <select id="sex">
								<option value="male">男</option>
			<option value="female">女</option>
						</select>
						</td>
					</tr>
					<tr>
						<td>分类： <select id="catalog">
								<option value="0">请选择</option>
						</select>
						</td>
					</tr>
					<tr>
						<td align="right"><input type="button" class="change_button"
							id="chenge_button" onclick="doUpdate(this.closest('div').id)"
							value="保存" /> <input type="button" class=" del_button"
							id="del_button" onclick="delInfor(this.closest('div').id)"
							value="删除" /></td>
					</tr>
				</table>
			</form>
	         <div id="uploaderContainer">
				<label style="cursor: pointer"> <span> 点击添加图片 
				<input type="file" name="files[]" id="fileupload"  style="width:40px;"  onclick="uploadFileRequest($(this).parent().parent().parent().parent(),'<%=basePath%>/images/clothImage/')" multiple/>
				</span>
				</label>
				<div style="margin-top: 20px;">
					<img id="suitImage" name="suitImage" width="120px" height="150px" />
				</div>
			</div>
		</div>
	</div>
	<div id="resultList"></div>
	<script type="text/javascript" charset="UTF-8">

	$(document).ready(function () {
		request("POST","<%=basePath%>/cloth/list",{},drawSleectList,serverError,true);
	});
	
	function check() {
		var cloth_NO1 = document.getElementById("add_cloth_NO");
		var cloth_Name1 = document.getElementById("add_cloth_name");
		var cloth_price1=document.getElementById("add_cloth_price");
		 var cloth_sex1=document.getElementById("select_cloth_sex");
		 var cloth_catalog1=$("#select_cloth_catalog").val();
		if (cloth_NO1.value.length < 1) {
			alert("编号不能为空！ ");
			return false;
		}
		if (cloth_Name1.value.length < 1) {
			alert("名称不能为空！ ");
			return false;
		}
		var reg=/^[1-9]\d*$|^0$/;   
		if (cloth_price1.value.length < 1) {
			alert("价格不能为空！ ");
			return false;
		}
		if (!reg.test(cloth_price1.value)) {
			alert("价格不是纯数字，或者输入有误！ ");
			return false;
		}
		if(cloth_catalog1<1)
			{
			alert("请选择分类！ ");
			return false;
			}
		return true;
	}
	
	 function drawSleectList(responseData){
			//showMessage(responseData);//输出“查询成功”
			if(responseData.code<0){
				return;
			}
			var users = responseData.data;
			console.log("users:",users);
			var clothNos = [];
			var clothNames = [];
			$(users).each(function(index,item){
				clothNos.push(item.clothNumber);
				clothNames.push(item.clothName);	
			});
			var sel1 = document.getElementById('select_catalog');
			var sel2 = document.getElementById('select_cloth_catalog');
			var sel3 = document.getElementById('catalog');
			var str = '<option value="0">请选择</option>';
			for(var i=0;i<clothNames.length;i++){
			  str +='<option value="'+clothNos[i] +'">'+clothNames[i]+'</option>';
			}
			sel1.innerHTML = str;	
			sel2.innerHTML = str;
			sel3.innerHTML = str;
	 }
	//********************************************************************************* 
	 function doSearch(){
		 $("#showBox0").html("<div id="+"showBox"+"></div>");
		 if($("#select_sex").val()=='female')//女
			 {
			 var sex = false;
			 if($("#select_catalog").val()=='0')
			 {
				var apparel = {"sex":sex};
				request("POST","<%=basePath%>/apparel/findAllBySex",apparel,drawSearchList,serverError,true);
				 
			 }else{
				var clothNumber = $("#select_catalog");
				var apparel = {"clothNumber":clothNumber.val(),"sex":sex};
				request("POST","<%=basePath%>/apparel/findAllByClothNumberAndsex",apparel,drawSearchList,serverError,true);
			 }
			 }
		 
		 if($("#select_sex").val()=='male')//男
		 {
			 var sex = true;
		 if($("#select_catalog").val()=='0')
		 {	
			var apparel = {"sex":sex};
			request("POST","<%=basePath%>/apparel/findAllBySex",apparel,drawSearchList,serverError,true);
			 
		 }else{
			 var clothNumber = $("#select_catalog");
			var apparel = {"clothNumber":clothNumber.val(),"sex":sex};
			request("POST","<%=basePath%>/apparel/findAllByClothNumberAndsex",apparel,drawSearchList,serverError,true);
		 }
		 }
		}		 	 
	 
	 function drawSearchList(responseData) {
			if (responseData.description == "查询成功") {
			} else {
				showMessage(responseData);
			}
			if (responseData.code < 0) {
				return;
			}
			var list = responseData.data;
			$(list).each(function(index, item) {
				
				show_cloth(item);
			});

		}
		var oId = 1
		
		function show_cloth(item) {
			var cloth_Id = item.id;
			var cloth_No=item.number;
			var cloth_name = item.name;
			var cloth_price = item.price;
			var cloth_sex = item.sex;
			var cloth_img =item.img;
			var cloth_catalog = item.clothNumber;
			$("#clothBox0").clone(true).attr({'id' : 'clothBox0' + oId}).insertAfter("#showBox");	
			$("#clothId").val(cloth_Id);
			$("#clothNO").val(cloth_No);
			$("#clothName").val(cloth_name);
			$("#price").val(cloth_price);
			$("#suitImage").attr("src",cloth_img);
			if(cloth_sex==true){
				$("#sex").val("male")
			}
			if(cloth_sex==false){
				$("#sex").val("female")
			}
			$("#catalog").val(cloth_catalog);
			oId += 1;
		}
		
		function drawList(responseData) {
			if (responseData.description == "查询成功") {
			} else {
				showMessage(responseData);
			}
			if (responseData.code < 0) {
				return;
			}
			var resultList = $("#resultList");
			var cloths = responseData.data;
			console.log("cloths:", cloths);
			resultList.html("");
			$(cloths).each(function(index, item) {
				show_cloth(item);
			});

		}
		
//&*****==**********************************************************）-8*******************************
	var obbj;
	function showReturnMessage(responseData)
	{
		showMessage(responseData);
		if(responseData.code===22)
			{
			       doadd();
			}
		else
			if(responseData.code===1)
					{
					obbj.remove();
					}
	} 
	
    function delInfor(id) {
	var cloth = {};
	var obj = $("#" + id);
	cloth.id =obj.find("input").eq(0).val();
	cloth.number =obj.find("input").eq(1).val();
	cloth.name = obj.find("input").eq(2).val();
	var message = confirm("确认删除  " +cloth.name + "  吗？")
	if (message == true) {
	   obbj = obj; 
	  request("POST","<%=basePath%>/apparel/delete",cloth,showReturnMessage,serverError,true);
		}

}
  
         function doUpdate(id) {
			var obj = $("#" + id);
			//if (checkNull(id)) {
			var cloth = {};
			cloth.id =  obj.find("input").eq(0).val(); 
		//	alert(' id   =   '+cloth.id);
			cloth.number =obj.find("input").eq(1).val(); 
			cloth.name = obj.find("input").eq(2).val();
			cloth.price = obj.find("input").eq(3).val();
			var cloth_sex = obj.find("select").eq(0).val();
			if(cloth_sex=="male"){
				cloth.sex=true;
			}
			if(cloth_sex=="female"){
				cloth.sex=false;
			}
			var img1= obj.find('img').attr("src");
               	cloth.img=img1;
			cloth.clothNumber = obj.find("select").eq(1).val();
			request("POST", "<%=basePath%>/apparel/update",cloth,showReturnMessage,serverError,true);
		}

		function add_cloth(){
			if(check())
				{
			var cloth = {};
			cloth.number = $("#add_cloth_NO").val();
			cloth.name = $("#add_cloth_name").val();
			var cloth_sex = $("#sex").val();
			if(cloth_sex=="male"){
				cloth.sex=true;
			}
			if(cloth_sex=="female"){
				cloth.sex=false;
			}
			cloth.price = $("#add_cloth_price").val();
			cloth.clothNumber = $("#select_cloth_catalog").val();
			request("POST","<%=basePath%>/apparel/add",cloth,showReturnMessage,serverError,true);
				}
		}

		function doadd() {
			var cloth_NO = document.getElementById("add_cloth_NO");
			var cloth_name = document.getElementById("add_cloth_name");
			var cloth_price = document.getElementById("add_cloth_price");
			var cloth_sex = document.getElementById("select_cloth_sex");
			var cloth_catalog = document.getElementById("select_cloth_catalog");
			$("#clothBox0").clone(true).attr({'id' : 'clothBox0' + oId}).insertAfter("#showBox");
			$("#clothNO").val(cloth_NO.value);
			$("#clothName").val(cloth_name.value);
			$("#price").val(cloth_price.value);
			$("#sex").val(cloth_sex.value);
			$("#catalog").val(cloth_catalog.value);
			oId += 1;
		
		}
//*************************************************************************************************** 
	
		function uploadFileRequest(suit,urlPrefix){
			console.log(suit);
			var ss='<%=basePath%>';
			var Cloth_IDD=$(suit).find("input").get(0).value;
			suit.find("#uploaderContainer input").fileupload({
					url:"<%=basePath%>/apparel/uploadImage?code="+Cloth_IDD,
				    dataType: 'json',
				    done: function (e, data) {
				    	// suit.find("#imageUrl").val(data.result.description);
				    	if(data.result.code==0)
				    	{suit.find("#uploaderContainer img").attr("src",urlPrefix+data.result.description);
				    	showMessage({"code":0,"description":data.result.description+"上传成功！"});
				    	}
				    	else  if(data.result.code==-3)
				    		{
				    		 showMessage({"code":0,"description":data.result.description+"上传失败！"});
				    		}
				    		},
				    		fail:function(e,data)
				    		{
				    			showMessage({"code":0,"description":data.result.description+"上传失败！"});
				    		}        
				});
		}
		
		
	</script>
</body>
</html>