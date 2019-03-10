package com.xm.admin.module.base.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xm.admin.module.base.entity.Department;
import com.xm.admin.module.base.mapper.DepartmentMapper;
import com.xm.admin.module.base.service.IDepartmentService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author xiaomalover
 * @since 2019-03-06
 */
@Service
public class DepartmentServiceImpl extends ServiceImpl<DepartmentMapper, Department> implements IDepartmentService {

}
