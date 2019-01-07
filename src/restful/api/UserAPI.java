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
import restful.entity.Apparel;
import restful.entity.User;
import restful.utils.Util;

@Path("/user")
public class UserAPI {
	private @Context HttpServletRequest request;
	
	@POST
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@AuthorityControl("list")
	@Path("/list")
	public Result list() {
		List<User> result = EM.getEntityManager()
				.createNamedQuery("User.findAll",User.class)
				.getResultList();
		return new Result(0, "查询成功", result, "");

	}
	
	@POST
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Path("/findeByname")
	public Result findeByname1() {
		String name=(String) request.getSession().getAttribute("userName");
		List<User> result = EM.getEntityManager()
				.createNamedQuery("User.findAllByName", User.class)
				.setParameter("userName",name )
				.getResultList();
		 return new Result(1,"查询成功",result,"");

	}
	
	
	@POST
	@Path("/listByName")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result listByName(User user) {
		
		List<User> result = EM.getEntityManager()
				.createNamedQuery("User.findAllByName", User.class)
				.setParameter("userName", user.getUserName())
				.getResultList();
		return new Result(0,"查询成功",result,"");
	}
	
	
	
	@POST
	@Path("/loginCheck")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result loginCheck(User user) {
		List<User> result1 = EM.getEntityManager()
				.createNamedQuery("User.findAllByName", User.class)
				.setParameter("userName", user.getUserName())
				.getResultList();
		if(result1.size()==0)
		{
		return new Result(-20,"用户不存在","","");
		}
		        List<User> result = EM.getEntityManager()
				.createNamedQuery("User.checkLogin", User.class)
				.setParameter("userName", user.getUserName()).setParameter("passWd", user.getPassWd())
								.getResultList();
		if(result.size()>0)
		{
			request.getSession().setAttribute("userName", user.getUserName());
			request.getSession().setAttribute("userAdmin", result.get(0).isUserAdmin());
			return new Result(0,"登陆成功",result,"");
		}
		else
			return new Result(-10,"密码错误","","");
		
	}
	
	@POST
	@Path("/add")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result add(User user) {
		user.setId(0);
		user.setUserAdmin(false);
		if(null==user.getPassWd()||null==user.getUserRealName()||null==user.getUserName()||null==user.getUserAvatar())
		{
			return  new Result(-2,"添加失败，非法进入","","");	
		}
		try {	
		user = EM.getEntityManager().merge(user);	
		EM.getEntityManager().persist(user);
		EM.getEntityManager().getTransaction().commit();
		return new Result(0,"注册成功",user,"");
			} catch (RuntimeException re) {
			return  new Result(-1,"注册失败，操作超时","","");		
			} 
		
	}

	@POST
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Path("/update")
	public Result update(User user) {
		if(null==user.getUserRealName()||null==user.getUserName()||null==user.getUserAvatar())
		{
			return  new Result(-2,"修改失败，非法进入","","");	
		}
		try {
			String id1=user.getId()+"";
			User user1=(User) Util.findByName(new User(),id1 , "id").get(0);
			if(user.getPassWd().trim().equals(""))
			{
				
				user.setPassWd(user1.getPassWd());
			}
		user.setUserAdmin(user1.isUserAdmin());
		EM.getEntityManager().persist(EM.getEntityManager().merge(user));
		EM.getEntityManager().getTransaction().commit();
		return new Result(0,"修改成功",user,"");
	} catch (RuntimeException re) {
		return  new Result(-1,"修改失败，操作超时","","");		
		} 
	}
	
	@POST
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@AuthorityControl("update1")
	@Path("/update1")
	public Result update1(User user) {
		if(null==user.getUserRealName()||null==user.getUserName()||null==user.getUserAvatar())
		{
			return  new Result(-2,"修改失败，非法进入",user,"");	
		}
		try {
			String id1=user.getId()+"";
			User user1=(User) Util.findByName(user,id1 , "id").get(0);
			if(user.getPassWd().trim().equals(""))
			{
				user.setPassWd(user1.getPassWd());
			}
		
		EM.getEntityManager().persist(EM.getEntityManager().merge(user));
		EM.getEntityManager().getTransaction().commit();
		return new Result(0,"修改成功",user,"");
	} catch (RuntimeException re) {
		return  new Result(-1,"修改失败，操作超时",user,"");		
		} 
	}
	
	@POST
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@AuthorityControl("delete")
	@Path("/delete")
	public Result delete(User user) 
	{
	try {
		EM.getEntityManager().remove(EM.getEntityManager().merge(user));
		EM.getEntityManager().getTransaction().commit();
		return new Result(0,"删除成功",user,"");
	} catch (RuntimeException re) {
		return  new Result(-1,"删除失败，操作超时","","");		
		} 
	}
}
