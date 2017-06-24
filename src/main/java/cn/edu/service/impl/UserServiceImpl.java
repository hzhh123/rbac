package cn.edu.service.impl;

import cn.edu.dao.UserMapper;
import cn.edu.model.User;
import cn.edu.service.UserService;
import cn.edu.util.page.BeanUtil;
import cn.edu.util.page.PageResult;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
  private UserMapper userMapper;
	@Override
	public User getUserByUsernameAndPassword(String username,String password) {
		// TODO Auto-generated method stub
		return userMapper.getUserByUsernameAndPassword(username,password);
	}
	@Override
	public User getUserByUsername(String username) {
		// TODO Auto-generated method stub
		return userMapper.getUserByUsername(username);
	}
	@Override
	public int update(User user) {
		// TODO Auto-generated method stub
		return userMapper.updateByPrimaryKey(user);
	}
	@Override
	public int save(User user) {
		// TODO Auto-generated method stub
		return userMapper.insert(user);
	}
	@Override
	public int deleteBatch(Integer[] ids) {
		// TODO Auto-generated method stub
		return userMapper.deleteBatch(ids);
	}
	@Override
	public int delete(Integer id) {
		// TODO Auto-generated method stub
		return userMapper.deleteByPrimaryKey(id);
	}
	@Override
	public User selectByPrimary(Integer id) {
		// TODO Auto-generated method stub
		return userMapper.selectByPrimaryKey(id);
	}
	@Override
	public List<User> findAll() {
		// TODO Auto-generated method stub
		return userMapper.findAll();
	}
	@Override
	public PageResult<User> find(Integer pageSize, Integer pageNo,User user) {
		PageHelper.startPage(pageNo, pageSize);
		return BeanUtil.toPagedResult((List<User>)userMapper.selectByParam(user));
	}
	@Override
	public PageResult<User> find(Integer pageSize, Integer pageNo) {
		// TODO Auto-generated method stub
		PageHelper.startPage(pageNo, pageSize);
		return BeanUtil.toPagedResult(findAll());
	}

}
