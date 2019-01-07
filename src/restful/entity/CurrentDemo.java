package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "T_Current")
@NamedQueries({
    @NamedQuery(name = "CurrentDemo.findAll", query = "SELECT currentDemo FROM CurrentDemo currentDemo"),
    @NamedQuery(name = "CurrentDemo.findAllByName", query = "SELECT currentDemo FROM CurrentDemo currentDemo where currentDemo.userName like :userName")
})
public class CurrentDemo extends IdEntity{

	private String userName;
	private String number;
	private int zIndex;
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public int getzIndex() {
		return zIndex;
	}
	public void setzIndex(int zIndex) {
		this.zIndex = zIndex;
	}
	
}
