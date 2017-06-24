package cn.edu.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.edu.util.Const;

public class LoginInterceptor implements HandlerInterceptor {
	private List<String>excludeUrls;

	public List<String> getExcludeUrls() {
		return excludeUrls;
	}

	public void setExcludeUrls(List<String> excludeUrls) {
		this.excludeUrls = excludeUrls;
	}

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2) throws Exception {
		String uri=arg0.getRequestURI();
		for(String url:excludeUrls){
			if(uri.endsWith(url)){
				return true;
			}
		}
		if(arg0.getSession().getAttribute(Const.SESSION_USER)!=null){
			return true;
		}
		arg1.sendRedirect(arg0.getContextPath()+"/initLogin");
		//arg0.getRequestDispatcher("/index.jsp").forward(arg0, arg1);
		return false;
	}

}
