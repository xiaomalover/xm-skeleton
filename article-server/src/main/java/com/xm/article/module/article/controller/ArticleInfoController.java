package com.xm.article.module.article.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xm.article.module.article.entity.ArticleCategory;
import com.xm.article.module.article.entity.ArticleInfo;
import com.xm.article.module.article.service.IArticleCategoryService;
import com.xm.article.module.article.service.IArticleInfoService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 * 文章表 前端控制器
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2020-03-01
 */
@RestController
@RequestMapping("/article/articleInfo")
public class ArticleInfoController {

    @Autowired
    IArticleInfoService articleInfoService;

    @Autowired
    IArticleCategoryService articleCategoryService;

    @GetMapping("/list")
    public Result<List<ArticleInfo>> getByParentId() {

        QueryWrapper<ArticleInfo> articleInfoQueryWrapper = new QueryWrapper<>();
        articleInfoQueryWrapper.eq("status", 1).orderByDesc("created_at");
        List<ArticleInfo> list = articleInfoService.list(articleInfoQueryWrapper);
        // lambda表达式
        list.forEach(item -> {
        });
        return new ResultUtil<List<ArticleInfo>>().setData(list);
    }

    @GetMapping("/detail/{id}")
    public Result getArticle(@PathVariable String id) {
        ArticleInfo articleInfo = articleInfoService.getById(id);
        if (!ObjectUtils.isEmpty(articleInfo) && !ObjectUtils.isEmpty(articleInfo.getCategoryId())) {
            ArticleCategory articleCategory = articleCategoryService.getById(articleInfo.getCategoryId());
            if (!ObjectUtils.isEmpty(articleCategory)) {
                articleInfo.setCategoryTitle(articleCategory.getTitle());
            }
        }
        return new ResultUtil<>().setData(articleInfo);
    }
}
