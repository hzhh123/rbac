package cn.edu.service;

import java.util.List;

import cn.edu.model.User;
import cn.edu.util.page.PageResult;

public interface UserService {
	public User getUserByUsernameAndPassword(String username, String password);

	public User getUserByUsername(String username);

	public int update(User user);

	public int save(User user);

	public int deleteBatch(Integer[] ids);
	public int delete(Integer id);

	public User selectByPrimary(Integer id);

	public List<User> findAll();

	public PageResult<User> find(Integer pageSize, Integer pageNo, User user);

	public PageResult<User> find(Integer pageSize, Integer pageNo);
}
