



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
	if( password.value.length<1)
	{
	user.passWd = $("#tempPassWd").val();
	}
	else
		{
		user.passWd = $("#passWd").val();
		}
		
	user.userRealName = $("#userRealName").val();
	user.userSex = getUserSex();
	user.userAvatar=getUserImage();
	doUpdatee(user);
	}
}

function drawList(responseData){
	//showMessage(responseData);
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