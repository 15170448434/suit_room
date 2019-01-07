package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "T_Apparel")
@NamedQueries({
    @NamedQuery(name = "Apparel.findAll", query = "SELECT apparel FROM Apparel apparel"),
    @NamedQuery(name = "Apparel.findAllById", query = "SELECT apparel FROM Apparel apparel where apparel.id like :id"),
    @NamedQuery(name = "Apparel.findAllByName", query = "SELECT apparel FROM Apparel apparel where apparel.number like :number"),
    @NamedQuery(name = "Apparel.findAllByClothNumberAndsex", query = "SELECT apparel FROM Apparel apparel where apparel.clothNumber like :clothNumber and apparel.sex like :sex"),
    @NamedQuery(name = "Apparel.findAllBySex", query = "SELECT apparel FROM Apparel apparel where apparel.sex like :sex"),
})
public class Apparel extends IdEntity {
	private String number;
	private int price;
	private boolean sex;
	private String name;
	private String clothNumber;
	private String img;
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public boolean isSex() {
		return sex;
	}
	public void setSex(boolean sex) {
		this.sex = sex;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getClothNumber() {
		return clothNumber;
	}
	public void setClothNumber(String clothNumber) {
		this.clothNumber = clothNumber;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	

}
