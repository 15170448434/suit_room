	function drawList(responseData){
		showMessage(responseData);
		if(responseData.code<0){
			return;
		}
			jumpJsp1();
}
	function doSearch(){
		if(check()==true)
			{
		    var user = {};
		    user.userName = $("#userName").val();
		    user.passWd = $("#passWd").val();
		    dolLginCheck(user)
			}
		}
	function check() {

		var password = document.getElementsByName("passWd")[0];
		var username = document.getElementsByName("userName")[0];
		var reg = /^[1-9]\d*$|^0$/; // 注意：故意限制了 0321 这种格式，如不需要，直接reg=/^\d+$/;
		if (username.value.length < 1) {
			alert("用户名不能为空！ ");
			return false;
		}
		if (password.value.length < 1) {
			alert("密码不能为空！ ");
			return false;
		}
	/*	if (reg.test(username.value) == true) {
			alert("提交成功 ");
			return true;
		} else {
			alert("含有非法字符 ");
			return false;
		}*/

		return true;
	}
	
	