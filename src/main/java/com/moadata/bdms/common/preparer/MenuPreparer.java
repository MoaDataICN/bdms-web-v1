package com.moadata.bdms.common.preparer;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import com.moadata.bdms.announcement.service.AnnouncementService;
import com.moadata.bdms.model.vo.MenuVO;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.support.menu.service.MenuService;
import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.PreparerException;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


@Component(value="menuPreparer")
public class MenuPreparer implements ViewPreparer {
	@Resource(name="menuService")
	private MenuService menuService;

	@Resource(name="announcementService")
	private AnnouncementService announcementService;
	
	@Override
	public void execute(Request context, AttributeContext attributeContext) throws PreparerException {
		
		ServletRequestAttributes servletContainer = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = servletContainer.getRequest();
		List<?> menuPath = null;
		if(request.getRequestURI() != null) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("url", request.getRequestURI());
			/* userGrou 제거 22.09.02
			String userGroupId = "";
			UserGroupVO usergroup = (UserGroupVO) RequestContextHolder.currentRequestAttributes().getAttribute("usergroup", RequestAttributes.SCOPE_SESSION);
			if(usergroup != null) {
				userGroupId = usergroup.getUsergroupId();
			}
			map.put("usergroupId", userGroupId);*/
			//사용자 uid로 변경 22.09.02
			String uid = "";
			UserVO user = (UserVO) RequestContextHolder.currentRequestAttributes().getAttribute("user", RequestAttributes.SCOPE_SESSION);
			if(user != null) {
				uid = user.getUsergroupId();
			}
			map.put("usergroupId", uid);
			
			menuPath = menuService.selectMenuListByPath(map);

			setCurMenuId(request.getRequestURI(),menuPath);
		}

		attributeContext.putAttribute("menuPathList", new Attribute(menuPath), true);
		request.setAttribute("menuPathList", menuPath);
		UserVO user = (UserVO) RequestContextHolder.currentRequestAttributes().getAttribute("user", RequestAttributes.SCOPE_SESSION);

		request.setAttribute("annSt", announcementService.selectUnreadAnnCnt(user.getUserId()));
		List<?> menu = null;
		if(user != null) {
			menu = menuService.selectMenuListByGroup(user.getUsergroupId());
		}
		attributeContext.putAttribute("menuList", new Attribute(menu), true);
		request.setAttribute("menuList", menu);

		Cookie[] cookies = request.getCookies();
		String value = "";
		if(cookies != null){ 
			for(int i=0;i<cookies.length;i++){
				if("HEADER_THEME".equals(cookies[i].getName())){
					try {
						value = java.net.URLDecoder.decode(cookies[i].getValue(), "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					} 
					break; 
				} 
			} 
		}
		
		attributeContext.putAttribute("headerTheme", new Attribute(value), true);
	}

	private void setCurMenuId(String url, List<?> argMenuPath){

		String mngMenuId = null;
		String menuId = null; //메뉴 ID 추가.
		try{
			List<MenuVO> menuPath = (List<MenuVO>)argMenuPath;

			if(url!=null && !url.equals("") && menuPath != null &&!menuPath.isEmpty()){
				mngMenuId = menuPath.stream().filter(s -> url.equals(s.getMenuUrl()) && s.getMngMenuId() != null).map(s -> s.getMngMenuId()).findFirst().orElse(null);
				menuId  = menuPath.stream().filter(s -> url.equals(s.getMenuUrl()) && s.getMenuId() != null).map(s -> s.getMenuId()).findFirst().orElse(null);				
			}

		}catch (Exception e){

		}finally {
			RequestContextHolder.currentRequestAttributes().setAttribute("mngMenuId", mngMenuId,RequestAttributes.SCOPE_SESSION);//관리메뉴id 세션에 추가
			RequestContextHolder.currentRequestAttributes().setAttribute("menuId", menuId,RequestAttributes.SCOPE_SESSION);//메뉴id 추가.
		}
	}
}