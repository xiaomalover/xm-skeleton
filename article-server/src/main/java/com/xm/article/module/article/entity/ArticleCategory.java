package com.xm.article.module.article.entity;

import java.math.BigDecimal;

import com.xm.common.entity.BaseCommonEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2020-03-01
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class ArticleCategory extends BaseCommonEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 是否父类
     */
    private Boolean isParent;

    /**
     * 父类ID
     */
    private String parentId;

    /**
     * 排序
     */
    private BigDecimal sortNo;

    /**
     * 标题
     */
    private String title;

    /**
     * 短标题
     */
    private String shortTitle;

    /**
     * 完整关系
     */
    private String relations;

    /**
     * 状态
     */
    private Boolean status;

}
