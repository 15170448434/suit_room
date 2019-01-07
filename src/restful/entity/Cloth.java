package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "T_Cloth")
@NamedQueries({
    @NamedQuery(name = "Cloth.findAll", query = "SELECT cloth FROM Cloth cloth"),
    @NamedQuery(name = "Cloth.findAllByName", query = "SELECT cloth FROM Cloth cloth where cloth.clothNumber like :clothNumber")
})
public class Cloth extends IdEntity{
	private String clothNumber;
	private String clothName;
	public String getClothNumber() {
		return clothNumber;
	}
	public void setClothNumber(String clothNumber) {
		this.clothNumber = clothNumber;
	}
	public String getClothName() {
		return clothName;
	}
	public void setClothName(String clothName) {
		this.clothName = clothName;
	}
	
}
