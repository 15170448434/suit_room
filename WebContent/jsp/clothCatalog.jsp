<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../css/clothCatalog.css" />
<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=basePath%>/js/main.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=basePath%>/js/clothCatalog.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div class="add_catalogBox" id="add_Box"
		style="border: solid #000 1px; width: 230px; height: auto; float: left">
		<form>
			<table>
				<tr align="center">
					<td><div class="title">服饰类别</div></td>
				</tr>
				<tr>
					<td>编号：<input type="text" name="add_clothNO" id="add_clothNO" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td>名称：<input type="text" name="add_clothName"
						id="add_clothName" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<td align="right"><input type="button" id="add_button"
						class="add_button" onClick="doAdd()" value="添加" /></td>
				</tr>

			</table>
		</form>
	</div>
	<div style="display: none">
		<div class="catalogBox" id="catalogBox0"
			style="border: solid #000 1px; width: 230px; height: auto; float: left">
			<form>
				<table>
					<tr align="center">
						<td><div class="title">服饰类别</div></td>
					</tr>
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
						<td align="right"><input type="button" class=" change_button"
							onClick=" doUpdate(this.closest('div').id)" value="保存" /> <input
							type="button" class=" del_button" id="del_button"
							onClick="delInfor(this.closest('div').id)" value="删除" /></td>
					</tr>

				</table>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function () {
		request("POST","<%=basePath%>/cloth/list",{},drawList,serverError,true);
	});
	
	function check() {
		var clothNO = document.getElementById("add_clothNO");
		var clothName = document.getElementById("add_clothName");
		if (clothNO.value.length < 1) {
			alert("编号不能为空！ ");
			return false;
		}
		if (clothName.value.length < 1) {
			alert("名称不能为空！ ");
			return false;
		}
		return true;
	}
	var oId = 1;

	function add_cloth(item) {
		var clothId = item.id;
		var clothNO = item.clothNumber;
		var clothName = item.clothName;
		$("#catalogBox0").clone(true).attr({
			'id' : 'catalogBox0' + oId
		}).insertAfter("#add_Box");
		$("#clothId").val(clothId);
		$("#clothNO").val(clothNO);
		$("#clothName").val(clothName);
		oId += 1;
	}

	function checkNull(id) {
		var obj = $("#" + id);
		var cid = obj.find("input").eq(0).val();
		var cclothNumber = obj.find("input").eq(1).val();
		var cclothName = obj.find("input").eq(2).val();
		if (cclothNumber < 1) {
			alert("编号不能为空！ ");
			return false;
		}
		if (cclothName < 1) {
			alert("名称不能为空！ ");
			return false;
		}
		return true;
	}
	function drawList(responseData) {
		if (responseData.description == "查询成功"||responseData.description == "添加成功") {
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
			add_cloth(item);
		});

	}

	function doAdd() {
		var cloth = {};
		if (check()) {
				cloth.clothNumber = $("#add_clothNO").val();
				cloth.clothName = $("#add_clothName").val();
				request("POST","<%=basePath%>/cloth/add",cloth,showReturnMessagess,serverError,true);
		}
	}
	var obbj;
 
	function delInfor(id) {
		var cloth = {};
		var obj = $("#" + id);
		cloth.id = obj.find("input").eq(0).val();
		cloth.clothNumber = obj.find("input").eq(1).val();
		cloth.clothName = obj.find("input").eq(2).val();
		var message = confirm("确认删除  " + cloth.clothNumber + "  吗？")
		if (message == true) {
			obbj=$("#" + id);
			request("POST","<%=basePath%>/cloth/delete",cloth,showReturnMessagess,serverError,true);
			} 

		}
	

	function doUpdate(id) {
			var cloth = {};
			var obj = $("#" + id);
			if (checkNull(id)) {
				cloth.id = obj.find("input").eq(0).val();
				cloth.clothNumber = obj.find("input").eq(1).val();
				cloth.clothName = obj.find("input").eq(2).val();
				request("POST","<%=basePath%>/cloth/update", cloth, showMessage,serverError, true);
	}
	}
	
	 function showReturnMessagess(responseData)
	  {
	    showMessage(responseData);
		 if(responseData.code==0)
			 obbj.remove();
		 else
			 if(responseData.code==1)
				 drawList(responseData);
	  }
</script>
</html>