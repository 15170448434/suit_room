<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/main.js"></script>
<script type="text/javascript" src="../js/vendor/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../js/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="../js/jquery.fileupload.js"></script>
<link href="../css/jquery.fileupload.css" rel="stylesheet"
	type="text/css" />
<link href="../css/jquery.fileupload-ui.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="../css/fittingRoom.css" />
<title>试衣间</title>
</head>

<body>

	<div class="dress" dir="rtl">
	<div dir="ltr">
	<div id="hideBox" style="display:none">
		<div class="dressBox" id="dressBox">
			<div class="dressInfo">
			</div>
			<div class="menu">
				<input id="clothId" type="hidden" value=""/>
				<input type="image" class="cloth_menu" src="../images/ui/zIndex.png" />
				<font id='Zindex' class=cloth_zindex ></font>
				<input type="image" class="cloth_menu" src="../images/ui/up.png" id=" change_up" onClick="change_Z(this.closest('.dressBox').id,0)"/>
				<input type="image" class="cloth_menu" src="../images/ui/down.png" id=" change_down" onClick="change_Z(this.closest('.dressBox').id,1)" />
				<input type="image" class="cloth_menu" src="../images/ui/remove.png" id="remove_menu" onClick="doremove(this.closest('.dressBox').id)" />
			</div>
		</div>
		</div>
		<div id="dress">
		<div id="dressBox0"></div>
		</div>
	</div>
	</div>

	<div class="show_dress">
		<div class="modelBox" id="modelBox">
		
		</div>
		<div class="ground"></div>
	</div>
	<div class="show_cloth">
		<div class="cloth_catalog">
			选择分类: <select id='select_catalog' onchange="doSearch()">
			</select>
		</div>
		<div class="cloth">
			<div id="hideBox" style="display: none">
				<div class="clothBox" id="clothBox">
					<div class="addCloth">
						<input id="clothId" type="hidden" /> <input type="image" onClick="doselect(this.closest('.clothBox').id)"
							src="../images/ui/add.png" style="width: 60px; height: 60px;" />
					</div>
					<div class="clothImgBox">
						<img class="cloth_img" id="suitImage" /><!-- src="../images/data/suits/wShirt02.png" -->
					</div>
					<div class="cloth_info" id="cloth_info"></div>
				</div>
			</div>
			<div id="showBox">
			</div>
		</div>
	</div>
	<div class="price">
		<p class="priceText">总价</p>
		<p class="sum" id="sumMoney">￥ 0</p>
	</div>
	<script>
	var oId = 1
	var pid=1
	var money = 0
	var modelsex=""
	$(document).ready(function () {
		request("POST","<%=basePath%>/cloth/list",{},drawSlectList,serverError,true);
		request("POST","<%=basePath%>/user/findeByname",{},readyModel,serverError,true);
		request("POST","<%=basePath%>/currentQuery/listByName",{},showDressinfo,serverError,true);
	});
	
	function readyModel(responseData){																//准备模特模型
		 users = responseData.data;
		$(users).each(function(index,item){
				if(item.userSex==true){
					modelsex="male";	
					}else{ 
						modelsex="female";	
						}
		src=item.userAvatar.slice(0, 27) +"Model" + item.userAvatar.slice(27)
		});	
	    str ="<img  class='model'  src=" +src +" style=\"z-index:0\" />";
	    $("#modelBox").append(str);	
	}

	 function drawSlectList(responseData){                                                     //显示已有上传图片的种类
			//showMessage(responseData);//输出“查询成功”
			if(responseData.code<0){
				return;
			}
			 users = responseData.data;
			 clothNos = [];
			 clothNames = [];
			$(users).each(function(index,item){
				clothNos.push(item.clothNumber);
				clothNames.push(item.clothName);	
			});
			 sel = document.getElementById('select_catalog');
			 str = '<option value="0">请选择</option>';
			for(var i=0;i<clothNames.length;i++){
			  str +='<option value="'+clothNos[i] +'">'+clothNames[i]+'</option>';
			}
			sel.innerHTML = str;	
	 }
	
	 function doSearch(){																		//查找种类衣服
			$("#showBox").html("<div id=\"clothBox0\"></div>");
			 if(modelsex=='female')//女
				 {
				 	 sex = false;		
					 clothNumber = $("#select_catalog");
					 apparel = {"clothNumber":clothNumber.val(),"sex":sex};
					request("POST","<%=basePath%>/apparel/findAllByClothNumberAndsex",apparel,drawSearchList,serverError,true);
				 }		 
			 if(modelsex=='male')//男
			 {
				  sex = true;
				  clothNumber = $("#select_catalog");
				 apparel = {"clothNumber":clothNumber.val(),"sex":sex};request("POST","<%=basePath%>/apparel/findAllByClothNumberAndsex",
							apparel, drawSearchList, serverError, true);
				}
			}

			function drawSearchList(responseData) {														//请求查找的种类有的衣服
				if (responseData.description == "查询成功") {
				} else {
					showMessage(responseData);
				}
				if (responseData.code < 0) {
					return;
				}
				 list = responseData.data;
				$(list).each(function(index, item) {
					show_cloth(item);
				});

			}

			function show_cloth(item) {														//显示查找结果到页面上
				 cloth_Id = item.id;
				 cloth_img = item.img;
				if(cloth_img!=null)
					{
				$("#clothBox").clone(true).attr({
					'id' : 'clothBox0' + oId
				}).insertAfter("#clothBox0");
				 str1 = "<p>编号：<font class=\"cloth_number\" >" + item.number
						+ "</font></p>"
				 str2 = " <p>名称：<font class=\"cloth_name\" >" + item.name
						+ "</font></p>"
				 str3 = "<p>单价：<font class=\"cloth_price\"> " + item.price.formatMoney()
						+ "</font></p>"
				 str = str1 + str2 + str3
			 	$("#clothBox0" + oId).find("input").eq(0).val(cloth_Id);
				$("#clothBox0" + oId).find("img").attr("src",cloth_img);
				$("#clothBox0" + oId).find("div:eq(2)").append(str)
				type=$("#select_catalog").val();			
				if(type=="hat"){
					$("#clothBox0" + oId).find("img").attr("style","margin-top:120px");
				}
				if(type=="shoe"){
					$("#clothBox0" + oId).find("img").attr("style","margin-top:-120px");
				}
				if(type=="jeans"){
					$("#clothBox0" + oId).find("img").attr("style","margin-top:-50px");
				}	
				oId += 1;
					}
			}
	 
	function doselect(id){																			//选择着装服装,添加着装服装到数据库
		slectCloth = {};
		slectCloth.number = $("#" + id).find("font").eq(0).text();
		slectCloth.zIndex =1;	
		request("POST","<%=basePath%>/currentDemo/add",slectCloth,requestDressInfor,serverError,true);
		}
	 
	
	function requestDressInfor(responseData){	
		if(responseData.description=="查询成功")
		{return;}
	else
	alert(responseData.description);
		 currentDemo = responseData.data;
		$(currentDemo).each(function(index,item){
			DressInfor ={}
			DressInfor.id= item.id;
			request("POST","<%=basePath%>/currentQuery/findById",DressInfor,showDressinfo,serverError,true);
		});
		}
	
	function showDressinfo(responseData){																		//显示着装情况
		showMessage(responseData);
		if(responseData.code<0){
			return;
		}
		 dressInfors = responseData.data;
		$(dressInfors).each(function(index,dress){	
		 imgHTML="<img src="+dress.img+" class=\"model\" id='dcloth_0"+pid+"' style=\"z-index:"+dress.zIndex+"\">" ;
		$("#modelBox").append(imgHTML);
		 str1 = "<p>编号：<font class=\"cloth_number\" >" + dress.number
					+ "</font></p>"
		 str2 = " <p>名称：<font class=\"cloth_name\" >" + dress.name
					+ "</font></p>"
		 str3 = "<p>单价：<font class=\"cloth_price\" >" + dress.price.formatMoney()
					+ "</font></p>"
		 str = str1 + str2 + str3
		$("#dressBox").clone(true).attr({'id' : 'cloth_0' + pid}).insertAfter("#dressBox0");
		$("#cloth_0" + pid).find("div:eq(0)").append(str)
		$("#cloth_0" + pid).find("input").eq(0).text(dress.id);
		$("#cloth_0" + pid).find("font").eq(3).text(dress.zIndex);
		calMoney(1,parseInt(dress.price));
		pid+=1;
	});
		
	}					

	
	function calMoney(code,cloth_price){															//计算价格
		if(code==1)//增加
		{
		money=money+cloth_price;
		$("#sumMoney").text(money.formatMoney());
		}
		if(code==0)//减少
		{
		money=money-cloth_price;
		$("#sumMoney").text(money.formatMoney());
	}
	}

	
	function change_Z(id,code){																	//更新Zindex
		  a = parseInt($("#" + id).find("font").eq(3).text());
		if(code==0){
			a=a+1;
			$("#d"+id).css("z-index",a);
			$("#" + id).find("font").eq(3).text(a)
			doUpdateZIndex(id,a);
		}
		if(code==1&&a!=0){
			a=a-1;
			$("#d"+id).css("z-index",a);
			$("#" + id).find("font").eq(3).text(a)
			doUpdateZIndex(id,a);
		}

	}
	
	function doUpdateZIndex(id,a){	                             //更新Zindex进数据库
		var updateInfo = {};
		updateInfo.id = $("#" + id).find("input").eq(0).text();
		updateInfo.number = $("#" + id).find("font").eq(0).text();	
		updateInfo.zIndex=a;
		request("POST","<%=basePath%>/currentDemo/update",updateInfo,{},serverError,true);
	} 
	
	function doremove(id){//删除服装				
		var message=confirm("确认脱下服装吗？")
	    if(message==true){
	    var delInfo = {};
		cloth_price = $("#" + id).find("font").eq(2).text().slice(1);
		calMoney(0,parseInt(cloth_price));
		delInfo.id =$("#" + id).find("input").eq(0).text();
		delInfo.number = $("#" + id).find("font").eq(0).text();
		$("#"+id).remove()
		$("#d"+id).remove()
		request("POST","<%=basePath%>/currentDemo/delete",delInfo,{},serverError,true);
		  }
	}
	
	
		
		
		function showMessage(responseData){
			if(responseData.description=="查询成功")
				{return;}
			else
			alert(responseData.description);
	    	console.log("showMessage",responseData);
	    }
		
		Number.prototype.formatMoney = function (places, symbol, thousand, decimal) {
		    places = !isNaN(places = Math.abs(places)) ? places : 2;
		    symbol = symbol !== undefined ? symbol : "￥";
		    thousand = thousand || ",";
		    decimal = decimal || ".";
		    var number = this,
		        negative = number < 0 ? "-" : "",
		        i = parseInt(number = Math.abs(+number || 0).toFixed(places), 10) + "",
		        j = (j = i.length) > 3 ? j % 3 : 0;
		    return symbol + negative + (j ? i.substr(0, j) + thousand : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) + (places ? decimal + Math.abs(number - i).toFixed(places).slice(2) : "");
		};

	</script>
</body>

</html>