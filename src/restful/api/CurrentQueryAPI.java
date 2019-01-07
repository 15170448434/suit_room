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
import restful.entity.Apparel;
import restful.entity.CurrentQuery;

@Path("/currentQuery")
public class CurrentQueryAPI {
	private @Context HttpServletRequest request;

	@POST
	@Path("/list")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result list() {
		try {
			List<CurrentQuery> result = EM.getEntityManager()
					.createNamedQuery("CurrentQuery.findAll", CurrentQuery.class).getResultList();
			return new Result(0, "查询成功", result, "");
		} catch (RuntimeException re) {
			return new Result(-1, "查询失败", "", "");
		}
	}

	@POST
	@Path("/listByName")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result listByName(CurrentQuery currentQuery) {
		String name = (String) request.getSession().getAttribute("userName");
		currentQuery.setUserName(name);
		try {
			List<CurrentQuery> result = EM.getEntityManager()
					.createNamedQuery("CurrentQuery.findAllByName", CurrentQuery.class)
					.setParameter("userName", "%" + currentQuery.getUserName() + "%").getResultList();
			for (CurrentQuery attribute : result) {
				EM.getEntityManager().refresh(attribute);
			}
			return new Result(0, "查询成功", result, "");
		} catch (RuntimeException re) {
			return new Result(-1, "查询失败", "", "");
		}
	}

	@POST
	@Path("/findById")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result findById(CurrentQuery currentQuery) {

		try {
			List<CurrentQuery> result = EM.getEntityManager()
					.createNamedQuery("CurrentQuery.findById", CurrentQuery.class)
					.setParameter("id", currentQuery.getId()).getResultList();
			return new Result(0, "查询成功", result, "");
		} catch (RuntimeException re) {
			return new Result(-1, "查询失败", "", "");
		}
	}

	@POST
	@Path("/add")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result add(CurrentQuery currentQuery) {
		try {
			currentQuery.setId(0);
			currentQuery = EM.getEntityManager().merge(currentQuery);
			EM.getEntityManager().persist(currentQuery);
			EM.getEntityManager().getTransaction().commit();
			return new Result(0, "添加成功", currentQuery, "");
		} catch (RuntimeException re) {
			return new Result(-1, "添加失败", "", "");
		}
	}

	@POST
	@Path("/update")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result update(CurrentQuery currentQuery) {
		try {
			EM.getEntityManager().persist(EM.getEntityManager().merge(currentQuery));
			EM.getEntityManager().getTransaction().commit();
			return new Result(0, "修改成功", currentQuery, "");
		} catch (RuntimeException re) {
			return new Result(-1, "修改失败", "", "");
		}
	}

	@POST
	@Path("/delete")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result delete(CurrentQuery currentQuery) {
		try {
			EM.getEntityManager().remove(EM.getEntityManager().merge(currentQuery));
			EM.getEntityManager().getTransaction().commit();

			return new Result(0, "删除成功", currentQuery, "");
		} catch (RuntimeException re) {
			return new Result(-1, "删除失败", "", "");
		}
	}
}
