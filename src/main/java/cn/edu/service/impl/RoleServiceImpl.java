package cn.edu.service.impl;

import cn.edu.dao.RoleMapper;
import cn.edu.model.Role;
import cn.edu.service.RoleService;
import cn.edu.util.page.BeanUtil;
import cn.edu.util.page.PageResult;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("roleService")
public class RoleServiceImpl implements RoleService{

	@Autowired
	private RoleMapper roleMapper;
	@Override
	public Role selectByPrimary(Integer id) {
		// TODO Auto-generated method stub
		return roleMapper.selectByPrimaryKey(id);
	}

	@Override
	public int deleteBatch(Integer[] _ids) {
		// TODO Auto-generated method stub
		return roleMapper.deleteBatch(_ids);
	}

	@Override
	public int save(Role role) {
		// TODO Auto-generated method stub
		return roleMapper.save(role);
	}

	@Override
	public int update(Role role) {
		// TODO Auto-generated method stub
		return roleMapper.updateByPrimaryKey(role);
	}

	@Override
	public List<Role> findAll() {
		// TODO Auto-generated method stub
		return roleMapper.findAll();
	}
	@Override
	public List<Role> selectByUserid(Integer userid) {
		return roleMapper.selectByUserid(userid);
	}

	public List<Role> selectAll() {
		return roleMapper.selectAll();
	}

	public Role getRoleByRolename(String rolename) {
		return roleMapper.getRoleByRolename(rolename);
	}
	@Override
	public PageResult<Role> find(Integer pageSize, Integer pageNo, Role role) {
		PageHelper.startPage(pageNo, pageSize);
		return BeanUtil.toPagedResult((List<Role>)roleMapper.selectByParam(role));
	}
//	@Override
	public PageResult<Role> find(Integer pageSize, Integer pageNo) {
		// TODO Auto-generated method stub
		PageHelper.startPage(pageNo, pageSize);
		return BeanUtil.toPagedResult(findAll());
	}
}
