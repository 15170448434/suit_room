package restful.api;

import java.util.List;

import javax.persistence.TypedQuery;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import restful.bean.Result;
import restful.database.EM;
import restful.entity.CurrentDemo;

@Path("/currentDemo")
public class CurrentDemoAPI {
	private @Context HttpServletRequest request;
	
	@POST
	@Path("/list")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result list() {
		try {
		List<CurrentDemo> result = EM.getEntityManager()
				.createNamedQuery("CurrentDemo.findAll",CurrentDemo.class)
				.getResultList();
		return new Result(0, "查询成功", result, "");
		}catch (RuntimeException re) {
			return  new Result(-1,"查询失败","","");		
			} 
	}
	
	@POST
	@Path("/listByName")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result listByName(CurrentDemo currentDemo) {
		try {
		List<CurrentDemo> result = EM.getEntityManager()
				.createNamedQuery("CurrentDemo.findAllByName", CurrentDemo.class)
				.setParameter("userName", "%"+currentDemo.getUserName()+"%").getResultList();	
		return new Result(0,"查询成功",result,"");}
		catch (RuntimeException re) {
			return  new Result(-1,"查询失败","","");		
			} 
	}

	@POST
	@Path("/add")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result add(CurrentDemo currentDemo) {
		String name=(String) request.getSession().getAttribute("userName");
		currentDemo.setUserName(name);
		if(null==currentDemo.getNumber()||null==currentDemo.getUserName())
			return new Result(-1,"非法进入，失败","","");	
		try {
			currentDemo.setId(0);
			currentDemo = EM.getEntityManager().merge(currentDemo);
			EM.getEntityManager().persist(currentDemo);
			EM.getEntityManager().getTransaction().commit();
			return new Result(0,"添加成功",currentDemo,"");
			} catch (RuntimeException re) {
			return  new Result(-1,"穿戴失败，已穿戴在身","","");		
			} 
		
			
	}

	@POST
	@Path("/update")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result update(CurrentDemo currentDemo) {
		String name=(String) request.getSession().getAttribute("userName");
		currentDemo.setUserName(name);
		try {
		System.out.println(currentDemo.getzIndex());
		EM.getEntityManager().persist(EM.getEntityManager().merge(currentDemo));
		EM.getEntityManager().getTransaction().commit();
		return new Result(0, "查询成功", currentDemo, "");}
		catch (RuntimeException re) {
			return  new Result(-1,"修改失败","","");		
			} 
	}
	
	@POST
	@Path("/delete")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result delete(CurrentDemo currentDemo) 
	{
		String name=(String) request.getSession().getAttribute("userName");
		currentDemo.setUserName(name);
		try {
		EM.getEntityManager().remove(EM.getEntityManager().merge(currentDemo));
		EM.getEntityManager().getTransaction().commit();
		return new Result(0,"删除成功",currentDemo,"");}
		catch (RuntimeException re) {
			return  new Result(-1,"删除失败","","");		
			} 
	}
}

