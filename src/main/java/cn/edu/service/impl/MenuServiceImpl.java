package cn.edu.service.impl;

import cn.edu.dao.MenuMapper;
import cn.edu.model.Menu;
import cn.edu.service.MenuService;
import cn.edu.util.CollectionUtil;
import cn.edu.util.page.BeanUtil;
import cn.edu.util.page.PageResult;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service("menuService")
public class MenuServiceImpl implements MenuService {
	@Autowired
   private MenuMapper menuMapper;
	@Override
	public List<Menu> findByRoleid(Integer roleid) {
		// TODO Auto-generated method stub
		return menuMapper.findByRoleid(roleid);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Menu> findByRoleids(Integer[] roleids) {
		List<Menu>menus=new ArrayList<Menu>();
		for(Integer roleid:roleids){
			List<Menu>mList=findByRoleid(roleid);
			menus.addAll(mList);
		}
		menus=(List<Menu>) CollectionUtil.removeDuplicate(menus);
		return menus;
	}

	@Override
	public List<Menu> findAll() {
		return menuMapper.findAll();
	}
	public List<Menu> findParentMenu() {
		return menuMapper.findParentMenu();
	}

	public PageResult<Menu> find(Integer pageSize, Integer pageNo) {
		PageHelper.startPage(pageNo, pageSize);
		return BeanUtil.toPagedResult(findAll());
	}

	public int update(Menu menu) {
		return menuMapper.updateByPrimaryKey(menu);
	}

	public int save(Menu menu) {
		return menuMapper.insert(menu);
	}

	public int delete(Integer id) {
		return menuMapper.deleteByPrimaryKey(id);
	}

	@Override
	public Menu selectById(Integer id) {
		return menuMapper.selectByPrimaryKey(id);
	}
}
