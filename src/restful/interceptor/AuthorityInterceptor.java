package restful.interceptor;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;

import org.jboss.resteasy.core.Headers;
import org.jboss.resteasy.core.ResourceMethodInvoker;
import org.jboss.resteasy.core.ServerResponse;
import org.jboss.resteasy.spi.Failure;
import org.jboss.resteasy.spi.HttpRequest;
import org.jboss.resteasy.spi.interception.PreProcessInterceptor;

import restful.annotation.AuthorityControl;
import restful.bean.Result;

@SuppressWarnings("deprecation")
public class AuthorityInterceptor implements PreProcessInterceptor {
	@Context HttpServletRequest request;

	@Override
	public ServerResponse preProcess(HttpRequest httpRequest, ResourceMethodInvoker resourceMethodInvoker) {
		Method method = resourceMethodInvoker.getMethod();
        System.out.println("进入拦截器");
        Annotation[] annotations  = method.getDeclaredAnnotations();
        
        for(Annotation annotation : annotations) {
            String permissionValue = "";
            if(annotation instanceof AuthorityControl) {
                permissionValue = ((AuthorityControl)annotation).value();
            }
            System.out.printf("%s\t permission value = %s\n",
                    annotation.toString(),permissionValue);
        }
        //权限校验
        if(method.isAnnotationPresent(AuthorityControl.class)) {
            Boolean  aControl = (Boolean) request.getSession().getAttribute("userAdmin");
           if( !aControl) {
            	return new ServerResponse(new Result(-3, "本功能需要具有admin权限的用户操作！!", "", null), 200, new Headers<Object>());
            }
        }
		return null;
	}

}
