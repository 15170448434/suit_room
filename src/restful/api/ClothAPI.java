package restful.api;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import restful.annotation.AuthorityControl;
import restful.bean.Result;
import restful.database.EM;
import restful.entity.Cloth;


@Path("/cloth")
public class ClothAPI {
	private @Context HttpServletRequest request;
	
	@POST
	@Path("/list")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result list() {
		try {
		List<Cloth> result = EM.getEntityManager()
				.createNamedQuery("Cloth.findAll",Cloth.class)
				.getResultList();
		return new Result(1, "查询成功", result, "");
		}catch (RuntimeException re)
		{
			return new Result(-1, "查询失败", "", "");
		}
	}
	
	@POST
	@Path("/listByName")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result listByName(Cloth cloth) {
		try {
		List<Cloth> result = EM.getEntityManager()
				.createNamedQuery("Cloth.findAllByName", Cloth.class)
				.setParameter("clothNumber", cloth.getClothNumber()).getResultList();
		if(result.size()>0)
		return new Result(-1,"饰品已存在",result,"") ;
		else
		return  new Result(0,"查询成功",result,"") ;
		}catch (RuntimeException re)
		{
			return new Result(-1, "查询失败", "", "");
		}
	}
	

	@POST
	@AuthorityControl("add")
	@Path("/add")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result add(Cloth cloth) {
		
		if(null==cloth.getClothNumber()||null==cloth.getClothNumber())
		{
			new Result(-1,"添加失败，非法进入","","");	
		}
		try {
			cloth.setId(0);
			cloth = EM.getEntityManager().merge(cloth);	
			EM.getEntityManager().persist(cloth);
			EM.getEntityManager().getTransaction().commit();
			} catch (RuntimeException re) {
			return  new Result(-1,"添加失败，饰品已存在",cloth,"");		
			} 
		return new Result(1,"添加成功",cloth,"");
	   }
      

	

	@POST
	@AuthorityControl("update")
	@Path("/update")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result update(Cloth cloth) {
	
		if(null==cloth.getClothNumber()||null==cloth.getClothNumber())
		{
	
			return	new Result(-1,"修改失败，非法进入",cloth,"");	
		}
		try {
		EM.getEntityManager().persist(EM.getEntityManager().merge(cloth));
		EM.getEntityManager().getTransaction().commit();
		return new Result(0,"修改成功",cloth,"");
		}
		catch(RuntimeException e)
		{
			return new Result(-1,"修改失败,xiugai",cloth,"");
		}
		}
		
	
	@POST
	@AuthorityControl("delete")
	@Path("/delete")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result delete(Cloth cloth) {
		EM.getEntityManager().remove(EM.getEntityManager().merge(cloth));
		EM.getEntityManager().getTransaction().commit();
		return new Result(0,"删除成功",cloth,"");
	}
}
