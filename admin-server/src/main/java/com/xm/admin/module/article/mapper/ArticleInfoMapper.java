package com.xm.admin.module.article.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.xm.admin.module.article.entity.ArticleInfo;
import com.xm.common.vo.ExtraVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * 文章表 Mapper 接口
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-04-05
 */
@Repository
public interface ArticleInfoMapper extends BaseMapper<ArticleInfo> {

    /**
     * 获取文章列表
     *
     * @param page        分页
     * @param articleInfo 搜索参数
     * @param extraVo     额外参数
     * @return 文章列表
     */
    IPage<ArticleInfo> selectArticleList(
            IPage page, @Param("articleInfo") ArticleInfo articleInfo, @Param("extraVo") ExtraVo extraVo);
}
