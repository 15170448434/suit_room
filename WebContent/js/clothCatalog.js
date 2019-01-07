
  
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
			$("#catalogBox0").clone(true).attr({'id':'catalogBox0'+oId}).insertAfter("#add_Box");
			 $("#clothId").val(clothId);
			$("#clothNO").val(clothNO);
			$("#clothName").val(clothName);
			oId += 1;
	}

 function checkNull(id)
{
var obj =$("#"+id);
var cid = obj.find("input").eq(0).val();
var cclothNumber=obj.find("input").eq(1).val();
var cclothName=obj.find("input").eq(2).val();
if (cclothNumber < 1) {
	alert("编号不能为空！ ");
	return false;
}
if (cclothName < 1){
	alert("名称不能为空！ ");
	return false;
}
return true;
}
 function drawList(responseData){		
		if(responseData.description=="查询成功"){}	
		else{showMessage(responseData);}
		if(responseData.code<0){return;}
		var resultList = $("#resultList");
		var cloths = responseData.data;
		console.log("cloths:",cloths);
		resultList.html("");
		$(cloths).each(function(index,item){
			add_cloth(item);});
	
	 }
 
	function doAdd(){
		var cloth = {};
		if(check())
		{ 
		if(checkAdmin())
		{	
		cloth.clothNumber = $("#add_clothNO").val();
		cloth.clothName = $("#add_clothName").val();
		doAddd(cloth);
		}
		else
		{  alert('本功能需要具有admin权限的用户操作！');
    	  }
		}	 
	}
	
	function delInfor(id){
		var cloth={};
		var obj=$("#"+id);
		cloth.id=obj.find("input").eq(0).val();
		cloth.clothNumber=obj.find("input").eq(1).val();
		cloth.clothName=obj.find("input").eq(2).val();
		 var message=confirm("确认删除  "+cloth.clothNumber+"  吗？")
		 if(message==true)
		{
			 if(checkAdmin())
			 { $("#"+id).remove();
			 delInforr(cloth)
	     
	      }else
	    	  {  alert('本功能需要具有admin权限的用户操作！');
	    	  }
			 
		}
	}
    
	function doUpdate(id){
		if(checkAdmin()){
		var cloth = {};
		var obj =$("#"+id);
		if(checkNull(id))
		{
		cloth.id = obj.find("input").eq(0).val();
		cloth.clothNumber=obj.find("input").eq(1).val();
		cloth.clothName=obj.find("input").eq(2).val();
		doUpdatee(cloth);
		}
		}else{ alert('本功能需要具有admin权限的用户操作！');}
		
	}