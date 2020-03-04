package com.xm.admin.module.article.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xm.admin.module.article.entity.ArticleInfo;
import com.xm.admin.module.article.mapper.ArticleInfoMapper;
import com.xm.admin.module.article.service.IArticleInfoService;
import com.xm.common.vo.ExtraVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 文章表 服务实现类
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-04-05
 */
@Service
public class ArticleInfoServiceImpl extends ServiceImpl<ArticleInfoMapper, ArticleInfo> implements IArticleInfoService {

    @Autowired
    ArticleInfoMapper articleInfoMapper;

    @Override
    public IPage<ArticleInfo> getArticleList(IPage page, ArticleInfo articleInfo, ExtraVo extraVo) {
        return articleInfoMapper.selectArticleList(page, articleInfo, extraVo);
    }

}
