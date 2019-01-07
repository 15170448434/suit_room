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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>修改信息</title>
    <link rel="stylesheet" href="../css/userManage.css" />
    <script type="text/javascript"src="<%=basePath%>/js/jquery.min.js" ></script>
    <script type="text/javascript"  charset="utf-8" src="<%=basePath%>/js/main.js" ></script>
  <%--     <script type="text/javascript"  charset="utf-8" src="<%=basePath%>/js/userManage.js" ></script> --%>
  </head>

  
  <body>
    <!-- 蒙板 -->
    <div id="mask"></div>
    <!-- 蒙板结束 -->
    <!-- 弹出层-- -->
    <div class="PopForm">
      <div class="changeForm">
        <div class="topText">用户信息</div>
        <form method="post" class="form">
          <table>
            <tr>
              <td>用户名称:</td>
              <input id="userId" name="userId" type="hidden" />
              <td>
                <input type="text" id="userName" name="userName" readonly="readonly" autocomplete="off"/>
              </td>
            </tr>
            <tr>
              <td>用户实名:</td>
              <td>
                <input type="text" id="userRealName" name="userRealName" autocomplete="off"/>
              </td>
            </tr>
            <tr>
              <td>密 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:</td>
              <td>
                <input  type="password" id="passWd" name="passWd" autocomplete="off"/>
              </td>
            </tr>
            <tr>
              <td>密码确认:</td>
              <td>
                <input type="password" id="rePassWd" name="rePassWd"  autocomplete="off"/>
              </td>
            </tr>
          </table>
          <div class="subTitle">头像</div>
          <table>
            <tr>
              <td width="100px">性别:</td>
              <td style="margin-right:150px">
                <label>
                  <input type="radio" name="sex" value="1" id="maleRadio" onclick="male_display()" style="width: auto; height: auto;"/>
                  <span>男</span>
                </label>
                <label>
                  <input type="radio" name="sex" value="0" id="femaleRadio" onclick="female_display()" style="width: auto; height: auto; margin-left: 10px"/>
                  <span>女</span>
                </label>
              </td>
            </tr>
            <tr>
              <td colspan="2" id="malePortrait" style="display: none;">
                <label>
                  <input type="radio" name="portrait" value="../images/data/model/mheadA.png"/>
                  <img src="../images/data/model/mheadA.png" name="one" style="width: 70px; height: 105px;"/>
                </label>
                <label>
                  <input type="radio" name="portrait" value="../images/data/model/mheadB.png"/>
                  <img src="../images/data/model/mheadB.png" name="two" style="width: 70px; height: 105px;" />
                </label>
              </td>
            </tr>
            <tr>
              <td colspan="2" id="femalePortrait" align="center" style="display: none;">
                <label>
                  <input type="radio" name="portrait" value="../images/data/model/wheadA.png" />
                  <img src="../images/data/model/wheadA.png" name="three" style="width: 70px; height: 105px;" />
                </label>
                <label>
                  <input type="radio" name="portrait" value="../images/data/model/wheadB.png" />
                  <img src="../images/data/model/wheadB.png" name="four" style="width: 70px; height: 105px;"/>
                </label>
              </td>
            </tr>
            <tr>
              <td>是否管理员:</td>
              <td>
                <label>
                  <input type="radio" name="isAdmin" value="1" id="yes" style="width: auto; height: auto;"/>
                  <span>是</span>
                </label>
                <label>
                  <input type="radio" name="isAdmin" value="0" id="no" style="width: auto; height: auto; margin-left: 10px" />
                  <span>否</span>
                </label>
              </td>
            </tr>
            <tr>
              <td colspan="2" width="550px" align="center">
                <input type="button" value="保存修改" id="save_button" onclick="doUpdate()"/>
                <input type="button" value="关闭窗口" id="close_button" onclick="hidePop()"/>
              </td>
            </tr>
          </table>
        </form>
      </div>
    </div>
    <form class="manageTable">
      <table>
        <thead id="mainThead">
          <tr>
            <td width="8%">id</td>
            <td width="11%">用户名称</td>
            <td width="11%">用户实名</td>
            <!-- <td width="0%"></td> -->
            <td width="9%">性别</td>
            <td width="14%">模型选择</td>
            <td width="17%">是否管理员</td>
            <td width="30%">操作</td>
          </tr>
        </thead>
        <tbody id="mainTbody"></tbody>
      </table>
    </form>
     </body> 
    <script type="text/javascript" charset="utf-8">
      $(document).ready(function() {	  
        request( "POST", "<%=basePath%>/user/list", {},drawListUser, serverError,true);
      });
    	var malePortrait = document.getElementById("malePortrait");
    	var femalePortrait = document.getElementById("femalePortrait");
    	var sex = document.getElementsByName("sex");
    	var password = document.getElementsByName("passWd")[0];
    	var password_re = document.getElementsByName("rePassWd")[0];
    	var username = document.getElementsByName("userName")[0];
    	var realName = document.getElementsByName("userRealName")[0];
    	var portrait = document.getElementsByName("portrait");
 
   	 function drawListUser(responseData) {
   	  if(responseData.description=="查询成功"){}	
			else{showMessage(responseData);}
       if (responseData.code < 0) {
         return;
       }
       var users = responseData.data;
       $(users).each(function(index, item) {
         user = $(
           "<tr class='user-item'>" +
           "<td id='id1'>" +item.id + "</td>" +
             "<td id='userName1'>" + item.userName +"</td>" +
             "<td id='userRealName1'>" + item.userRealName +"</td>" +
             /* "<td id='userPassWd1' style='display:none'>" + item.passWd +"</td>" + */
             "<td id='userSex1'>" + (item.userSex == 1 ? "男" : "女") +"</td>"+
             "<td id='userAvatar1'><img src="+item.userAvatar+" style='width: 70px; height: 105px;'></td>" + 
             "<td id='userAdmin1'>" + (item.userAdmin == 1 ? "是" : "否") +"</td>" +
             "<td >" + "<div onclick='showPop(this)' id='left_button'>修改</div>" +
             "<div onclick='doDelete(this)' id='right_button'>删除</div>" +
             "</td>" +
             "</tr>"
         );
         $("#mainTbody").append(user);
       });
     }
    	

      function check() {
       		
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
                    request("POST","<%=basePath%>/user/delete",user,showMessage,serverError,true);
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
            	 request("POST","<%=basePath%>/user/update1",user,showMessage,serverError,true);
                }
              }
            
    </script>

</html>
