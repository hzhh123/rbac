package cn.edu.test;

import cn.edu.dao.RoleMapper;
import cn.edu.dao.UserMapper;
import cn.edu.dao.UserRoleMapper;
import cn.edu.model.*;
import cn.edu.service.*;
import cn.edu.util.FileUtil;
import cn.edu.util.page.PageResult;
import com.sun.tools.doclets.formats.html.SourceToHTMLConverter;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import java.io.*;
import java.io.File;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class Test {
	@Autowired
	private DataSource dataSource;
	@Autowired
	private UserService userService;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	@Autowired
	private RoleService roleService;
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private MenuService menuService;
	@Autowired
	private UserRoleService userRoleService;
	@Autowired
	private RoleMenuService roleMenuService;
	@Autowired
	private BootstrapIconinfoService bootstrapIconinfoService;
	@Autowired
	private FileService fileService;
	@org.junit.Test
	public void test() throws SQLException{
		System.out.println(dataSource.getConnection());
	}
    @org.junit.Test
	public void test1(){
    	User user=userService.getUserByUsernameAndPassword("admin123","123456");
		System.out.println(user);
	}

    @org.junit.Test
	public void test2(){
    	User user=userMapper.getUserByUsername("admin123");
		System.out.println(user);
	}
    
    @org.junit.Test
	public void test3(){
    	User user=new User();
    	user.setPassword("111");
    	user.setUsername("asd");
		System.out.println(userMapper.insert(user));
	}
    @org.junit.Test
    public void test4(){
    	Integer ids[]=new Integer[]{16,15};
    	int f=userService.deleteBatch(ids);
    	System.out.println(f);
    }
    
    @org.junit.Test
    public void test5(){
    	UserRole ur=userRoleMapper.selectByPrimaryKey(33);
    	System.out.println(ur);
    	System.out.println(userRoleMapper.selectByUserid(1));
    }
    
    @org.junit.Test
    public void test6(){
    	List<Menu>mList=menuService.findByRoleid(25);
    	System.out.println(mList.size());
    }
    @org.junit.Test
    public void test7(){
    	List<Menu>mList=menuService.findByRoleids(new Integer[]{25,26});
    	for(Menu m:mList){
    		System.out.println(m);
    	}
    	System.out.println(mList.size());
    }
	@org.junit.Test
    public void test8(){
    	Integer[] roleids=new Integer[]{25,26};
    	Integer userid=16;
    	for(int i=0;i<roleids.length;i++){

			UserRole ur=new UserRole();
			ur.setRoleid(roleids[i]);
			ur.setUserid(userid);
			userRoleService.insert(ur);
		}
	}
	@org.junit.Test
	public void test9(){
    	User user=new User();
    	user.setUsername("admin123");
    	user.setStatue(null);
    	List<User>users=userMapper.selectByParam(user);
		for (int i = 0; i <users.size() ; i++) {
			System.out.println(users.get(i).getUsername());
		}
	}
	@org.junit.Test
	public void test10(){
		Role role=new Role();
		role.setRolename("管理员");
		role.setStatue(null);
		List<Role>roles=roleMapper.selectByParam(role);
		System.out.println(roles.size());
	}
	@org.junit.Test
	public void test11(){
		List<Role>roles=roleService.findAll();
		System.out.println(roles.size());
	}

	@org.junit.Test
	public void test12(){
		PageResult<Role>pages=roleService.find(10,1);
		System.out.println(pages.getRows().size());
	}
	@org.junit.Test
	public void test13(){
		Role role=new Role();
		role.setStatue("1");
		role.setRolename("ddcc");
		int a=roleMapper.save(role);
		System.out.println(a);

	}
	@org.junit.Test
	public void test14(){
		List<Menu>menus=menuService.findAll();
		System.out.println(menus.size());
	}
	//读取bootstrap.css写入图标类
	@org.junit.Test
	public void test15()throws IOException{
		String basePath=System.getProperty("user.dir");
		String path="/src/main/webapp/assets/admin/plugin/bootstrapV3/css/bootstrap.css";
		String readPath=basePath+path;
		List<String>slist= FileUtil.matchList(readPath,"glyphicon");
		for (int i = 0; i < slist.size(); i++) {
			BootstrapIconinfo bootstrapIconinfo=new BootstrapIconinfo();
		    bootstrapIconinfo.setId(UUID.randomUUID().toString());
		    bootstrapIconinfo.setClassname("glyphicon "+slist.get(i));
			System.out.println(slist.get(i));
			bootstrapIconinfo.setCreatetime(new Date());
		    bootstrapIconinfo.setDisplayname(slist.get(i));
		    bootstrapIconinfo.setSourcetype("Glyphicon");
		    bootstrapIconinfoService.insert(bootstrapIconinfo);
		}

	}
	@org.junit.Test
	public void test16()throws IOException{
		String basePath=System.getProperty("user.dir");
		String path="/src/main/webapp/assets/admin/plugin/font/font-awesome-4.7.0/css/font-awesome.css";
		String readPath=basePath+path;
		List<String>slist= FileUtil.matchList(readPath,"fa");
		for (int i = 0; i < slist.size(); i++) {
			BootstrapIconinfo bootstrapIconinfo=new BootstrapIconinfo();
			bootstrapIconinfo.setId(UUID.randomUUID().toString());
			bootstrapIconinfo.setClassname("fa "+slist.get(i));
			System.out.println(slist.get(i));
			bootstrapIconinfo.setCreatetime(new Date());
			bootstrapIconinfo.setDisplayname(slist.get(i));
			bootstrapIconinfo.setSourcetype("FontAwesome");
			bootstrapIconinfoService.insert(bootstrapIconinfo);
		}

	}
	@org.junit.Test
	public void test17()throws IOException{
		String basePath=System.getProperty("user.dir");
		String path="/src/main/webapp/assets/admin/plugin/font/simple-line-icons/css/simple-line-icons.css";
		String readPath=basePath+path;
		List<String>slist= FileUtil.matchList(readPath,"icon");
		for (int i = 0; i < slist.size(); i++) {
			BootstrapIconinfo bootstrapIconinfo=new BootstrapIconinfo();
			bootstrapIconinfo.setId(UUID.randomUUID().toString());
			bootstrapIconinfo.setClassname(slist.get(i));
			System.out.println(slist.get(i));
			bootstrapIconinfo.setCreatetime(new Date());
			bootstrapIconinfo.setDisplayname(slist.get(i));
			bootstrapIconinfo.setSourcetype("SimpleLine");
			bootstrapIconinfoService.insert(bootstrapIconinfo);
		}
	}

	@org.junit.Test
	public void test18(){
		String basePath=System.getProperty("user.dir");
		System.out.println(basePath.replace('\\','/'));
	}

	@org.junit.Test
	public void test19(){
		String str="D:\\workspace\\idea2017\\work1\\rbac\\target\\rbac\\doc\\file\\20170701\\ubutnu2.jpg";
		System.out.println(new SimpleDateFormat("yyyyMMdd").format(new Date()));
	}
	@org.junit.Test
	public void test20(){
		Integer[]ids={56,57};
		fileService.deleteBatch(ids);
	}
	@org.junit.Test
	public void test21(){
		String img="data:image/jpeg;base64,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";
				String str=img.replaceAll("data:image/jpeg;base64,","");
		System.out.println(str);
	}
}
