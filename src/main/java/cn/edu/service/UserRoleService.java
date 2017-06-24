package cn.edu.service;

import java.util.List;

import cn.edu.model.UserRole;

public interface UserRoleService {

	int deleteByUserid(Integer userid);

	int insert(UserRole ur);

	List<UserRole> selectByUserid(Integer userid);

	Integer[] getRoleids(Integer userid);

}
