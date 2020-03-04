package com.xm.article.module.article.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xm.article.module.article.entity.ArticleCategory;
import com.xm.article.module.article.service.IArticleCategoryService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2020-03-01
 */
@RestController
@RequestMapping("/article/articleCategory")
public class ArticleCategoryController {

    @Autowired
    IArticleCategoryService articleCategoryService;

    @GetMapping("/list")
    public Result<List<ArticleCategory>> getByParentId() {

        QueryWrapper<ArticleCategory> articleCategoryQueryWrapper = new QueryWrapper<>();
        articleCategoryQueryWrapper.eq("status", 1).orderByAsc("sort_no");
        List<ArticleCategory> list = articleCategoryService.list(articleCategoryQueryWrapper);
        // lambda表达式
        list.forEach(item -> {
        });
        return new ResultUtil<List<ArticleCategory>>().setData(list);
    }
}
