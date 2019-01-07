package restful.utils;

import java.util.List;

import restful.database.EM;
import restful.entity.User;

public class Util {
	
	public static List<Object> findByName(Object obj, Object key, String keyName) {
		System.out.println("findbyname + " + keyName);
		String queryName = ""; 
		if ("id".equals(keyName)) {
			queryName = ".findAllBy" + "Id";
		} else if ("number".equals(keyName)) {
			queryName = ".findAllBy" + "Number";
		} else if("name".equals(keyName))
			queryName = ".findAllBy" + "Name";
		long ke=Integer.parseInt((String) key);
		System.out.println("ke  = "+ke);
		String[] s = (obj.getClass().getTypeName()).split("\\.");
		List<Object> result = EM.getEntityManager()
				.createNamedQuery(s[s.length-1] + queryName, Object.class)
				.setParameter(keyName, ke)
				.getResultList();
		System.out.println(result.size());
		return result;
	}
}
