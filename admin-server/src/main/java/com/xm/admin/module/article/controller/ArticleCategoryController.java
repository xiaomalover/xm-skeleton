package com.xm.admin.module.article.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xm.admin.common.constant.CommonConstant;
import com.xm.admin.module.article.entity.ArticleCategory;
import com.xm.admin.module.article.entity.ArticleInfo;
import com.xm.admin.module.article.service.IArticleCategoryService;
import com.xm.admin.module.article.service.IArticleInfoService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-04-05
 */
@SuppressWarnings("SpringJavaAutowiredFieldsWarningInspection")
@RestController
@RequestMapping("/skeleton/article/category")
@CacheConfig(cacheNames = "articleCategory")
public class ArticleCategoryController {

    @Autowired
    IArticleCategoryService articleCategoryService;

    @Autowired
    IArticleInfoService articleInfoService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @GetMapping("/getByParentId/{parentId}")
    @Cacheable(key = "#parentId")
    public Result<List<ArticleCategory>> getByParentId(@PathVariable String parentId) {

        QueryWrapper<ArticleCategory> articleCategoryQueryWrapper = new QueryWrapper<>();
        articleCategoryQueryWrapper.eq("parent_id", parentId).orderByAsc("sort_no");
        List<ArticleCategory> list = articleCategoryService.list(articleCategoryQueryWrapper);
        // lambda表达式
        list.forEach(item -> {
            if (!CommonConstant.PARENT_ID.equals(item.getParentId())) {
                ArticleCategory parent = articleCategoryService.getById(item.getParentId());
                if (!ObjectUtils.isEmpty(parent)) {
                    item.setParentTitle(parent.getTitle());
                }
            } else {
                item.setParentTitle("一级分类");
            }
        });
        return new ResultUtil<List<ArticleCategory>>().setData(list);
    }

    @PostMapping("/add")
    @CacheEvict(key = "#articleCategory.parentId")
    public Result<ArticleCategory> add(@ModelAttribute ArticleCategory articleCategory) {

        articleCategoryService.save(articleCategory);

        // 如果不是添加的一级 判断设置上级为父节点标识
        if (!CommonConstant.PARENT_ID.equals(articleCategory.getParentId())) {
            ArticleCategory parent = articleCategoryService.getById(articleCategory.getParentId());
            if (!ObjectUtils.isEmpty(parent)) {
                if (parent.getIsParent() == null || !parent.getIsParent()) {
                    parent.setIsParent(true);
                    articleCategoryService.updateById(parent);
                    // 更新上级节点的缓存
                    redisTemplate.delete("articleCategory::" + parent.getParentId());
                }
                articleCategory.setRelations(parent.getRelations() + "," + articleCategory.getId());
            }
        } else {
            articleCategory.setRelations(articleCategory.getId());
        }
        articleCategoryService.updateById(articleCategory);

        return new ResultUtil<ArticleCategory>().setData(articleCategory);
    }

    @PostMapping("/edit")
    public Result<ArticleCategory> edit(@ModelAttribute ArticleCategory articleCategory) {

        String parentId = articleCategory.getParentId();
        if (CommonConstant.PARENT_ID.equals(parentId)) {
            articleCategory.setRelations(articleCategory.getId());
        } else {
            ArticleCategory parent = articleCategoryService.getById(parentId);
            articleCategory.setRelations(parent.getId() + "," + articleCategory.getId());
        }
        articleCategoryService.updateById(articleCategory);
        // 手动删除所有部门缓存
        Set<String> keys = redisTemplate.keys("articleCategory:" + "*");
        if (!ObjectUtils.isEmpty(keys)) {
            redisTemplate.delete(keys);
        }
        return new ResultUtil<ArticleCategory>().setData(articleCategory);
    }

    @DeleteMapping("/delByIds/{ids}")
    public Result<Object> delByIds(@PathVariable String[] ids) {

        for (String id : ids) {
            ArticleInfo articleInfo = articleInfoService.getOne(new QueryWrapper<ArticleInfo>().eq("category_id", id));
            if (!ObjectUtils.isEmpty(articleInfo)) {
                return new ResultUtil<>().setErrorMsg("删除失败，包含正被文章使用关联的分类");
            }
        }
        for (String id : ids) {
            articleCategoryService.removeById(id);
        }
        // 手动删除所有部门缓存
        Set<String> keys = redisTemplate.keys("articleCategory:" + "*");
        if (!ObjectUtils.isEmpty(keys)) {
            redisTemplate.delete(keys);
        }
        return new ResultUtil<>().setSuccessMsg("批量通过id删除数据成功");
    }
}
