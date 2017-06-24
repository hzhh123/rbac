package cn.edu.service;

import cn.edu.model.Role;
import cn.edu.util.page.PageResult;

import java.util.List;

public interface RoleService {


	Role selectByPrimary(Integer id);

	int deleteBatch(Integer[] _ids);

	int save(Role role);

	int update(Role role);
	List<Role>selectByUserid(Integer userid);

	List<Role> findAll();
	List<Role> selectAll();
	Role getRoleByRolename(String rolename);
	public PageResult<Role> find(Integer pageSize, Integer pageNo, Role role);

	public PageResult<Role> find(Integer pageSize, Integer pageNo);

}
