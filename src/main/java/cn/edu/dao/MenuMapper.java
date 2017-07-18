package cn.edu.dao;

import java.util.List;

import cn.edu.model.Menu;

public interface MenuMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);
    List<Menu>findByRoleid(Integer roleid);
    List<Menu>findAll();
    List<Menu>findParentMenu();
}