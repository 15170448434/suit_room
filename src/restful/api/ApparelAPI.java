package restful.api;

import java.io.File;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import restful.annotation.AuthorityControl;
import restful.bean.Result;
import restful.database.EM;
import restful.entity.Apparel;
import restful.entity.User;
import restful.utils.Util;


@Path("/apparel")
public class ApparelAPI {
	private @Context HttpServletRequest request;
	
	@POST
	@Path("/list")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result list() {
		try {
		List<Apparel> result = EM.getEntityManager()
				.createNamedQuery("Apparel.findAll",Apparel.class)
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
	public Result listByName(Apparel apparel) {
		try {
		List<Apparel> result = EM.getEntityManager()
				.createNamedQuery("Apparel.findAllByName", Apparel.class)
				.setParameter("number", "%"+apparel.getNumber()+"%")
				.getResultList();
		return new Result(0,"查询成功",result,"");}
		catch (RuntimeException re) {
			return  new Result(-1,"查询失败","","");		
			} 
	}
	
	@POST
	@Path("/findAllByClothNumberAndsex")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result listByClothNumberAndsex(Apparel apparel) {
            try {
		List<Apparel> result = EM.getEntityManager()
				.createNamedQuery("Apparel.findAllByClothNumberAndsex", Apparel.class)
				.setParameter("clothNumber", "%"+apparel.getClothNumber()+"%")
				.setParameter("sex",apparel.isSex())
				.getResultList();
		return new Result(0,"查询成功",result,"");
            }catch (RuntimeException re) 
            {
            	return new Result(-11,"未知原因失败","","");
            }
            
	}
		
	@POST
	@Path("/findAllBySex")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result listBySex(Apparel apparel) {
		try {
		List<Apparel> result = EM.getEntityManager()
				.createNamedQuery("Apparel.findAllBySex", Apparel.class)
				.setParameter("sex",apparel.isSex())
				.getResultList();
		return new Result(0,"查询成功",result,"");
		}catch (RuntimeException re) {
			return new Result(0,"查询失败","","");
		}
	}
	
	

	@POST
	
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@AuthorityControl("add")
	@Path("/add")
	public Result add(Apparel apparel) {
		try {
		apparel.setId(0);
		apparel = EM.getEntityManager().merge(apparel);
		EM.getEntityManager().persist(apparel);
		EM.getEntityManager().getTransaction().commit();
		return new Result(22,"添加成功",apparel,"");}
		catch (RuntimeException re) 
		{
			return new Result(-22, "添加失败，编号重复！", "", "");
		}
	}

	@POST
	@AuthorityControl("update")
	@Path("/update")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result update(Apparel apparel) {
		try {
			String id1=apparel.getId()+"";
			Apparel apparel1=(Apparel) Util.findByName(new Apparel(),id1 , "id").get(0);
			if(apparel.getClothNumber().trim().equals("0"))
			{
			 System.out.println("apparel.getClothNumber() =  "+apparel1.getClothNumber());	
				apparel.setClothNumber(apparel1.getClothNumber());
				System.out.println("appare.getClothNumber() = "+apparel.getClothNumber());
			}
		EM.getEntityManager().persist(EM.getEntityManager().merge(apparel));
		EM.getEntityManager().getTransaction().commit();
		return new Result(0, "修改成功", apparel, "");
		}
		 catch (RuntimeException re) 
		{
		return new Result(0, "修改失败", "", "");
		}
	}
	
	@POST
	@AuthorityControl("delete")
	@Path("/delete")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result delete(Apparel apparel) 
	{
		try {
		EM.getEntityManager().remove(EM.getEntityManager().merge(apparel));
		EM.getEntityManager().getTransaction().commit();
		return new Result(1,"删除成功",apparel,"");
	} catch (RuntimeException re) 
	{
		return new Result(1,"删除失败","","");
	}
	}
	
	//@SuppressWarnings("deprecation")
	@POST
	@AuthorityControl("uploadImage")
	@Path("/uploadImage")
	@Produces("application/json;charset=UTF-8")
	public Result uploadImage(@QueryParam("code") String suitCode) 
	{
		System.out.println("--------------------------------------------");
		System.out.println("suitcode----->:" + suitCode);
		DiskFileItemFactory factory = new DiskFileItemFactory();// 创建DiskFileItem工厂
		ServletFileUpload upload = new ServletFileUpload(factory); //创建文件解析对象
		upload.setHeaderEncoding("UTF-8");
		String savePath = request.getRealPath("/images/clothImage");
		System.out.println(savePath);
		factory.setRepository(new File(request.getRealPath("/") + "image\\"));//设置上传文件的临时目录
		factory.setSizeThreshold(1024*1024);//设定了1M的缓冲区
		long MAXSIZE=1024*1024*5;//单位是byte，所以这里指定的是5M
		upload.setFileSizeMax(MAXSIZE);
		upload.setSizeMax(MAXSIZE*2);//一共最多上传10M
		
	    try {
	        // 解析并保存
	    	List<FileItem> fileItems = upload.parseRequest(request);//解析request请求
	        for (FileItem item : fileItems) {
	        	if (!item.isFormField()) {
	        		String fileName = item.getName();//文件的全路径，绝对路径名加文件名
	        		System.out.println(fileName);
	        		if(fileName.trim().equals(""))
	        			continue;
	        		fileName.substring(fileName.lastIndexOf("\\") + 1);
	        		
	        		InputStream input = item.getInputStream();
					File saveFile = new File(savePath + "\\" + fileName);//定义一个file指向一个具体的文件
					System.out.println("ppppp = "+saveFile);
					System.out.println(saveFile.getPath());
					item.write(saveFile);//把上传的内容写到一个文件中
					input.close();
					Apparel apparel = (Apparel) Util.findByName(new Apparel(), suitCode, "id").get(0);
					 apparel.setImg("../images/clothImage/" + fileName);
					 
		          //  System.out.println(apparel.getImg() +  request.getContextPath() + request.getServletPath());
		            EM.getEntityManager().persist(EM.getEntityManager().merge(apparel));
					EM.getEntityManager().getTransaction().commit();
                     return new Result(0, fileName, "", null);
	        	}
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new Result(-1, "服务器文件解析错误", "", null);
	    }
	    return new Result(-1, "未发现可供服务保存的数据", "", null);
	}
	
}
