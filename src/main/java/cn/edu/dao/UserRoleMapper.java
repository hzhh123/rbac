package cn.edu.dao;

import java.util.List;

import cn.edu.model.UserRole;

public interface UserRoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserRole record);

    int insertSelective(UserRole record);
    List<UserRole>selectByUserid(Integer userid);

    UserRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserRole record);

    int updateByPrimaryKey(UserRole record);

	int deleteByUserid(Integer userid);
	Integer[] getRoleids(Integer userid);
}