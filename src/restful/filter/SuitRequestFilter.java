package restful.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;

import restful.entity.User;

public class SuitRequestFilter implements Filter{

	private String checkedUrls;
	private FilterConfig fconfig;
	
	@Override
	public void init(FilterConfig arg0) throws ServletException {
		fconfig = arg0;
		checkedUrls = fconfig.getServletContext().getInitParameter("checkedUrls");
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) servletRequest;
		HttpServletResponse resp = (HttpServletResponse) servletResponse;
		
		resp.setCharacterEncoding("UTF-8");
		String url = req.getServletPath();
       
		//System.out.println("this is url from filter :"+url);
		
		List<String> urls = Arrays.asList(checkedUrls.split(","));
	
		String currentUser = (String) req.getSession().getAttribute("userName");

		if(urls!=null && currentUser==null && urls.contains(url)) {
			resp.sendRedirect("http://localhost:8080/suit/jsp/login.jsp");
		}
		filterChain.doFilter(servletRequest, servletResponse);
	}

	
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	

}