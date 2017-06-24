package cn.edu.dao;

import java.util.List;

import cn.edu.model.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

	int deleteBatch(Integer[] _ids);
    List<Role> selectByUserid(Integer userid);
	List<Role> findAll();
    List<Role> selectAll();
     Role getRoleByRolename(String rolename);
    List<Role>selectByParam(Role role);
    int save(Role role);
}