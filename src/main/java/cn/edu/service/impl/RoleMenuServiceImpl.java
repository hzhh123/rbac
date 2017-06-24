package cn.edu.service.impl;

import cn.edu.dao.RoleMenuMapper;
import cn.edu.model.RoleMenu;
import cn.edu.service.RoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2017/6/23.
 */
@Service("roleMenuService")
public class RoleMenuServiceImpl implements RoleMenuService {
    @Autowired
    private RoleMenuMapper roleMenuMapper;
    @Override
    public int insert(RoleMenu rm) {
        return roleMenuMapper.insert(rm);
    }

    @Override
    public int delete(Integer roleid) {
        return roleMenuMapper.delete(roleid);
    }

    @Override
    public List<RoleMenu> selectByRoleid(Integer roleid) {
        return roleMenuMapper.selectByRoleid(roleid);
    }
}
