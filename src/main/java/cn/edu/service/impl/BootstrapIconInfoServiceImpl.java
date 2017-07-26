package cn.edu.service.impl;

import cn.edu.dao.BootstrapIconInfoMapper;
import cn.edu.model.BootstrapIconInfo;
import cn.edu.service.BootstrapIconinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2017/7/26.
 */
@Service("bootstrapIconinfoService")
public class BootstrapIconInfoServiceImpl implements BootstrapIconinfoService {
    @Autowired
    private BootstrapIconInfoMapper bootstrapIconInfoMapper;
    @Override
    public void save(BootstrapIconInfo bootstrapIconInfo) {
        bootstrapIconInfoMapper.insert(bootstrapIconInfo);
    }

    @Override
    public List<BootstrapIconInfo> find(String sourceType) {
        return bootstrapIconInfoMapper.find(sourceType);
    }
}
