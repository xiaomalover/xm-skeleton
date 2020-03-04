package com.xm.admin.module.sys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xm.admin.module.sys.entity.AdminLog;
import com.xm.admin.module.sys.mapper.AdminLogMapper;
import com.xm.admin.module.sys.service.IAdminLogService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-03-06
 */
@Service
public class AdminLogServiceImpl extends ServiceImpl<AdminLogMapper, AdminLog> implements IAdminLogService {

}
