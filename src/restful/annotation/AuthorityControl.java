package restful.annotation;

import java.lang.annotation.RetentionPolicy;

@java.lang.annotation.Retention(value=RetentionPolicy.RUNTIME)
public @interface AuthorityControl {
	public String value() default "fail";
}
