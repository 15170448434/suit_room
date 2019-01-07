package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "T_User")
@NamedQueries({
    @NamedQuery(name = "User.findAll", query = "SELECT user FROM User user"),
    @NamedQuery(name = "User.findAllByName", query = "SELECT user FROM User user where user.userName like :userName"),
    @NamedQuery(name = "User.findAllById", query = "SELECT user FROM User user where user.id like :id"),
    @NamedQuery(name = "User.checkLogin", query = "SELECT user FROM User user where user.userName like :userName and user.passWd like :passWd")
})
public class User extends IdEntity{

	private String userName;
	private String passWd;
	private String userRealName;
	private boolean userSex;
	private boolean userAdmin;
	private String userAvatar;
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWd() {
		return passWd;
	}
	public void setPassWd(String passWd) {
		this.passWd = passWd;
	}
	public String getUserRealName() {
		return userRealName;
	}
	public void setUserRealName(String userRealName) {
		this.userRealName = userRealName;
	}
	public boolean isUserSex() {
		return userSex;
	}
	public void setUserSex(boolean userSex) {
		this.userSex = userSex;
	}
    
	public boolean isUserAdmin() {
		return userAdmin;
	}
	public void setUserAdmin(boolean userAdmin) {
		this.userAdmin = userAdmin;
	}
	public String getUserAvatar() {
		return userAvatar;
	}
	public void setUserAvatar(String userAvatar) {
		this.userAvatar = userAvatar;
	}
	
}
