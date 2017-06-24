package cn.edu.test;

import cn.edu.dao.RoleMapper;
import cn.edu.dao.UserMapper;
import cn.edu.dao.UserRoleMapper;
import cn.edu.model.*;
import cn.edu.service.*;
import cn.edu.util.page.PageResult;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.List;

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
    
}
