package cn.edu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.edu.model.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

	User getUserByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

	User getUserByUsername(String username);

	//返回删除记录数
	int deleteBatch(Integer[] ids);

	List<User> findAll();

	List<User> selectByParam(User user);
}