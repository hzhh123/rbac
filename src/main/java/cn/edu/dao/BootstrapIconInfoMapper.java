package cn.edu.dao;

import cn.edu.model.BootstrapIconInfo;

import java.util.List;

public interface BootstrapIconInfoMapper {
    int deleteByPrimaryKey(String id);

    int insert(BootstrapIconInfo record);

    int insertSelective(BootstrapIconInfo record);

    BootstrapIconInfo selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(BootstrapIconInfo record);

    int updateByPrimaryKey(BootstrapIconInfo record);
    List<BootstrapIconInfo> find(String sourceType);
}