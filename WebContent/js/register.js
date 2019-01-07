
	

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
			addUser(user);
		}
	}
	