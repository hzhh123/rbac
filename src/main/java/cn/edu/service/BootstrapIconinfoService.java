package cn.edu.service;

import cn.edu.model.BootstrapIconInfo;

import java.util.List;

/**
 * Created by Administrator on 2017/7/26.
 */
public interface BootstrapIconinfoService {
    void save(BootstrapIconInfo bootstrapIconInfo);
    List<BootstrapIconInfo>find(String sourceType);
}
