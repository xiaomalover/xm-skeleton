package com.xm.common.utils;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.xm.common.vo.ExtraVo;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public class CommonPageUtil<T> {

    /**
     * 初始化分页抽象类
     *
     * @param pageNumber 页数
     * @param pageSize   每页条数
     * @return 分页抽象类
     */
    public IPage<T> initIPage(Integer pageNumber, Integer pageSize) {
        IPage<T> iPage = new Page<>();
        if (pageNumber == null || pageNumber < 1) {
            pageNumber = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }
        iPage.setCurrent(pageNumber);
        iPage.setSize(pageSize);
        return iPage;
    }

    public IPage<T> initIPage(ExtraVo extraVo) {

        IPage<T> iPage = new Page<>();
        int pageNumber = extraVo.getPageNumber();
        int pageSize = extraVo.getPageSize();

        if (pageNumber < 1) {
            pageNumber = 1;
        }
        if (pageSize < 1) {
            pageSize = 10;
        }
        iPage.setCurrent(pageNumber);
        iPage.setSize(pageSize);
        return iPage;
    }
}
