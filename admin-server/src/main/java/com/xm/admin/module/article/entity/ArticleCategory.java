package com.xm.admin.module.article.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

/**
 * <p>
 *
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-04-05
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class ArticleCategory extends BaseEntity {

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
    private Integer status;

    @TableField(exist = false)
    private String parentTitle;

}
