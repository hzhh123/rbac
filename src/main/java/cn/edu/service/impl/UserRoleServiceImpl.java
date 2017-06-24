package cn.edu.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.dao.UserRoleMapper;
import cn.edu.model.UserRole;
import cn.edu.service.UserRoleService;
@Service("userRoleService")
public class UserRoleServiceImpl implements UserRoleService {

	@Autowired
	private UserRoleMapper userRoleMapper;
	@Override
	public int deleteByUserid(Integer userid) {
		// TODO Auto-generated method stub
		return userRoleMapper.deleteByUserid(userid);
	}

	@Override
	public int insert(UserRole ur) {
		// TODO Auto-generated method stub
		return userRoleMapper.insert(ur);
	}

	@Override
	public List<UserRole> selectByUserid(Integer userid) {
		// TODO Auto-generated method stub
		return userRoleMapper.selectByUserid(userid);
	}

	@Override
	public Integer[] getRoleids(Integer userid) {
		// TODO Auto-generated method stub
		return userRoleMapper.getRoleids(userid);
	}


}
