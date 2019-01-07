


function check() {
 		
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

      function male_display() {
        femalePortrait.style.display = "none";
        malePortrait.style.display = "block";
        for (var i = 0; i < portrait.length; i++) {
          if (portrait[i].checked) {
            portrait[i].checked = "";
            break;
          }
        }
      }

      function female_display() {
        femalePortrait.style.display = "block";
        malePortrait.style.display = "none";
        for (var i = 0; i < portrait.length; i++) {
          if (portrait[i].checked) {
            portrait[i].checked = "";
            break;
          }
        }
      }

      function showMask() {
        var obj = document.getElementById("mask");
        obj.style.width = document.body.clientWidth;
        obj.style.height = document.body.clientHeight;
        obj.style.display = "block";
      }

      function hideMask() {
        var obj = document.getElementById("mask");
        obj.style.display = "none";
      }


      function getUserImage()
      {
      	var obj = document.getElementsByName("portrait");
          for(var i=0; i<obj.length; i ++){
              if(obj[i].checked){
                  return obj[i].value;
              }
          }
      }
      function getUserAdmin()
      {
      	var obj = document.getElementsByName("isAdmin");
      	 for(var i=0; i<obj.length; i ++){
             if(obj[i].checked){
             	if(obj[i].value==1)
         		{return true;	}
         	else	{  return false;	}
             }
         }
     
         return false;
      }
      function getUserSex()
      {
      	var obj = document.getElementsByName("sex");
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
      
   
      function hidePop() {
        hideMask("mask");
        $(".PopForm").fadeOut();
      }
      
     	
 
 	 
      
      function showPop(obj) {
          showMask();
          $('#userId').val($(obj).parent().parent().find('#id1').text());
             var usid=$(obj).parent().parent().find('#id1').text();
          $('#userName').val($(obj).parent().parent().find('#userName1').text());
         $('#userRealName').val($(obj).parent().parent().find('#userRealName1').text());
        var usersexx=$(obj).parent().parent().find('#userSex1').text();
        
     /*    $("tempPassWd")=$(obj).parent().parent().find('#userPassWd1').text(); */
        var useravator=$(obj).parent().parent().children("#userAvatar1").children('img').attr('src');
        var sexx=null;
         if(usersexx=="男")
  		{	sexx=1;	}
  	   else	{ sexx=0;	}
         var useradmin=$(obj).parent().parent().find('#userAdmin1').text();
         var useradd=null;
         if(useradmin=="是")
  		{	useradd=1;	}
  	   else	{ useradd=0; }
         $("input[name=sex][value="+sexx+"]").attr("checked","true");
         $("input[name=isAdmin][value="+useradd+"]").attr("checked","true");
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
  	   if(useravator == portrait[i].value)
  		   {
  		   portrait[i].checked="true";
  		   }
    }
    $(".PopForm").fadeIn();
  }
         
      

      function doDelete(obj) {
    	  var message=confirm("确认删除吗？")
    	  if(message==true)
    		  {
              $(obj).parent().parent().remove();
              var user={};
              user.id=$(obj).parent().parent().find('#id1').text();
              user.userName=$(obj).parent().parent().find('#userName1').text();
          /*     user.passWd=$(obj).parent().parent().find('#userPassWd1').text(); */
              user.userRealName=$(obj).parent().parent().find('#userRealName1').text();
              var usersexx=$(obj).parent().parent().find('#userSex1').text();
              var sexx=null;
              if(usersexx=="男")
      		 {	sexx=1;	}
      	    else	{ sexx=0;	}
              user.userSex=sexx;
              user.userAvatar=$(obj).parent().parent().children("#userAvatar1").children('img').attr('src');
              var useradmin=$(obj).parent().parent().find('#userAdmin1').text();
              var userad=null;
              if(useradmin=="是")
      		 {	userad=1;	}
      	    else	{ userad=0;	}
              user.userAdmin=userad;
              deleteUser(user);
    		  }
      }
      
      function doUpdate() {
          
          if(check())
          {
           var user = {};
          user.id = $("#userId").val();
          user.userName = $("#userName").val();
          user.userRealName = $("#userRealName").val();
      	user.passWd = $("#passWd").val();
      	user.userSex = getUserSex();
      	user.userAvatar=getUserImage();
      	user.userAdmin=getUserAdmin();
      	updateUser(user);
 
          }
        }