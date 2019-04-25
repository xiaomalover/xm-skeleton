package com.xm.admin.module.article.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.xm.admin.module.article.entity.ArticleCategory;
import com.xm.admin.module.article.entity.ArticleInfo;
import com.xm.admin.module.article.service.IArticleCategoryService;
import com.xm.admin.module.article.service.IArticleInfoService;
import com.xm.common.enums.CommonStatus;
import com.xm.common.utils.CommonPageUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.ExtraVo;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 文章表 前端控制器
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-04-05
 */
@RestController
@RequestMapping("/skeleton/article")
public class ArticleInfoController {

    @Autowired
    private IArticleInfoService articleInfoService;

    @Autowired
    private IArticleCategoryService articleCategoryService;

    @GetMapping("/getByCondition")
    public Result getByCondition(
            @ModelAttribute ArticleInfo articleInfo,
            @ModelAttribute ExtraVo extraVo
    ) {
        IPage<ArticleInfo> page = new CommonPageUtil<ArticleInfo>().initIPage(extraVo);
        IPage<ArticleInfo> articleInfoList = articleInfoService.getArticleList(page, articleInfo, extraVo);
        return new ResultUtil<IPage<ArticleInfo>>().setData(articleInfoList);
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

    @PostMapping("/disable/{id}")
    public Result<Object> disable(@PathVariable String id) {
        ArticleInfo articleInfo = articleInfoService.getById(id);
        articleInfo.setStatus(CommonStatus.STATUS_DISABLED.getStatus());
        if (articleInfoService.updateById(articleInfo)) {
            return new ResultUtil<>().setSuccessMsg("禁用文章成功");
        } else {
            return new ResultUtil<>().setErrorMsg("禁用文章失败");
        }
    }

    @PostMapping("/enable/{id}")
    public Result<Object> enable(@PathVariable String id) {
        ArticleInfo articleInfo = articleInfoService.getById(id);
        articleInfo.setStatus(CommonStatus.STATUS_ENABLED.getStatus());
        if (articleInfoService.updateById(articleInfo)) {
            return new ResultUtil<>().setSuccessMsg("启用文章成功");
        } else {
            return new ResultUtil<>().setErrorMsg("启用文章失败");
        }
    }

    @DeleteMapping("/delByIds/{ids}")
    public Result<Object> delAllByIds(@PathVariable String[] ids) {
        for (String id : ids) {
            articleInfoService.removeById(id);
        }
        return new ResultUtil<>().setSuccessMsg("批量通过id删除数据成功");
    }

    @PostMapping("/add")
    public Result add(@ModelAttribute ArticleInfo articleInfo) {
        if (articleInfoService.save(articleInfo)) {
            return new ResultUtil<>().setSuccessMsg("添加文章成功");
        } else {
            return new ResultUtil<>().setErrorMsg("添加文章失败");
        }
    }

    @PostMapping("/edit")
    public Result edit(@ModelAttribute ArticleInfo articleInfo) {
        if (articleInfoService.updateById(articleInfo)) {
            return new ResultUtil<>().setSuccessMsg("编辑文章成功");
        } else {
            return new ResultUtil<>().setErrorMsg("编辑文章失败");
        }
    }
}
