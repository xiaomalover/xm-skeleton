package com.xm.admin.modules.base.service;


import com.xm.admin.base.BaseService;
import com.xm.admin.common.vo.SearchVo;
import com.xm.admin.modules.base.entity.Log;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * 日志接口
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface LogService extends BaseService<Log,String> {

    /**
     * 日志搜索
     * @param key
     * @param searchVo
     * @param pageable
     * @return
     */
    Page<Log> searchLog(String key, SearchVo searchVo, Pageable pageable);

    /**
     * 删除所有
     */
    void deleteAll();
}
