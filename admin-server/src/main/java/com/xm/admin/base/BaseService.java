package com.xm.admin.base;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import java.io.Serializable;
import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
// JDK8函数式接口注解 仅能包含一个抽象方法
@FunctionalInterface
public interface BaseService<E, ID extends Serializable> {

    BaseDao<E, ID> getRepository();

    /**
     * 根据ID获取
     *
     * @param id 主键
     * @return 数据
     */
    default E get(ID id) {
        return getRepository().getOne(id);
    }

    /**
     * 获取所有列表
     *
     * @return 数据列表
     */
    default List<E> getAll() {
        return getRepository().findAll();
    }

    /**
     * 获取总数
     *
     * @return 数据总条数
     */
    default Long getTotalCount() {
        return getRepository().count();
    }

    /**
     * 保存
     *
     * @param entity 实体
     * @return 保存后的实例
     */
    default E save(E entity) {

        return getRepository().save(entity);
    }

    /**
     * 修改
     *
     * @param entity 实体
     * @return 修改后的实体
     */
    default E update(E entity) {
        return getRepository().saveAndFlush(entity);
    }

    /**
     * 批量保存与修改
     *
     * @param entities 实体集合
     * @return 保存后的实体集合
     */
    default Iterable<E> saveOrUpdateAll(Iterable<E> entities) {
        return getRepository().saveAll(entities);
    }

    /**
     * 删除
     *
     * @param entity 实例
     */
    default void delete(E entity) {
        getRepository().delete(entity);
    }

    /**
     * 根据Id删除
     *
     * @param id 主键
     */
    default void delete(ID id) {
        getRepository().deleteById(id);
    }

    /**
     * 批量删除
     *
     * @param entities 实体列表
     */
    default void delete(Iterable<E> entities) {
        getRepository().deleteAll(entities);
    }

    /**
     * 清空缓存，提交持久化
     */
    default void flush() {
        getRepository().flush();
    }

    /**
     * 根据条件查询获取
     *
     * @param spec 条件
     * @return 实体列表
     */
    default List<E> findAll(Specification<E> spec) {
        return getRepository().findAll(spec);
    }

    /**
     * 分页获取
     *
     * @param pageable 分页接口
     * @return 分页后的数据
     */
    default Page<E> findAll(Pageable pageable) {
        return getRepository().findAll(pageable);
    }

    /**
     * 根据查询条件分页获取
     *
     * @param spec     条件
     * @param pageable 分页接口
     * @return 分页后的实例列表
     */
    default Page<E> findAll(Specification<E> spec, Pageable pageable) {
        return getRepository().findAll(spec, pageable);
    }

    /**
     * 获取查询条件的结果数
     *
     * @param spec 查询条件
     * @return 总条数
     */
    default long count(Specification<E> spec) {
        return getRepository().count(spec);
    }
}
