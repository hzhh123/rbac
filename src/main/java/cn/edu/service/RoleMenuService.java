package cn.edu.service;

import cn.edu.model.RoleMenu;

import java.util.List;

/**
 * Created by Administrator on 2017/6/23.
 */
public interface RoleMenuService {
    int insert(RoleMenu rm);
    int  delete(Integer roleid);
    List<RoleMenu> selectByRoleid(Integer roleid);
}
