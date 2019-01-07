package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "V_Current")
@NamedQueries({
	@NamedQuery(name = "CurrentQuery.findAll", query = "SELECT currentQuery FROM CurrentQuery currentQuery"),
    @NamedQuery(name = "CurrentQuery.findAllByName", query = "SELECT currentQuery FROM CurrentQuery currentQuery where currentQuery.userName like :userName"),
	@NamedQuery(name = "CurrentQuery.findById", query = "SELECT currentQuery FROM CurrentQuery currentQuery where currentQuery.id like :id")
})
public class CurrentQuery extends IdEntity {
	
	private String userName;
	private String number;
	private String img;
	private int price;
	private String name;
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
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getzIndex() {
		return zIndex;
	}
	public void setzIndex(int zIndex) {
		this.zIndex = zIndex;
	}
	
	

}
