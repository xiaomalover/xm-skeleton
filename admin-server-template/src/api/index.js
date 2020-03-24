// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, deleteRequest, uploadFileRequest } from '@/libs/axios';

//获取验证码id
export const initCaptcha = (params) => {
    return getRequest('/common/captcha/init')
};

//获取验证码
export const getCaptcha = (id, params) => {
    return getRequest(`/common/captcha/draw/${id}`)
};

// 登陆
export const login = (params) => {
    return postRequest('/login', params)
};

// 获取用户登录信息
export const userInfo = (params) => {
    return getRequest('/user/info', params)
};

// 个人中心编辑
export const userInfoEdit = (params) => {
    return postRequest('/user/edit', params)
};

// 个人中心修改密码
export const changePass = (params) => {
    return postRequest('/user/modifyPass', params)
};

// 解锁
export const unlock = (params) => {
    return postRequest('/user/unlock', params)
};

// 获取用户数据 多条件
export const getUserListData = (params) => {
    return getRequest('/user/getByCondition', params)
};

// 添加用户
export const addUser = (params) => {
    return postRequest('/user/admin/add', params)
};

// 编辑用户
export const editUser = (params) => {
    return postRequest('/user/admin/edit', params)
};

// 启用用户
export const enableUser = (id, params) => {
    return postRequest(`/user/admin/enable/${id}`, params)
};

// 禁用用户
export const disableUser = (id, params) => {
    return postRequest(`/user/admin/disable/${id}`, params)
};

// 删除用户
export const deleteUser = (ids, params) => {
    return deleteRequest(`/user/delByIds/${ids}`, params)
};

// 修改密码
export const updateAdminPassword = (params) => {
    return postRequest('/user/admin/updatePassword', params)
};

// 获取一级部门
export const initDepartment = (params) => {
    return getRequest('/department/getByParentId/0', params)
};

// 加载部门子级数据
export const loadDepartment = (id, params) => {
    return getRequest(`/department/getByParentId/${id}`, params)
};
// 添加部门
export const addDepartment = (params) => {
    return postRequest('/department/add', params)
};

// 编辑部门
export const editDepartment = (params) => {
    return postRequest('/department/edit', params)
};

// 删除部门
export const deleteDepartment = (ids, params) => {
    return deleteRequest(`/department/delByIds/${ids}`, params)
};

// 获取全部角色数据
export const getAllRoleList = (params) => {
    return getRequest('/role/getAllList', params)
};

// 分页获取角色数据
export const getRoleList = (params) => {
    return getRequest('/role/getAllByPage', params)
};

// 添加角色
export const addRole = (params) => {
    return postRequest('/role/save', params)
};

// 编辑角色
export const editRole = (params) => {
    return postRequest('/role/edit', params)
};
// 设为或取消注册角色
export const setDefaultRole = (params) => {
    return postRequest('/role/setDefault', params)
};

// 分配角色权限
export const editRolePerm = (id, params) => {
    return postRequest(`/role/editRolePerm/${id}`, params)
};

// 删除角色
export const deleteRole = (ids, params) => {
    return deleteRequest(`/role/delAllByIds/${ids}`, params)
};

// 获取全部权限数据
export const getAllPermissionList = (params) => {
    return getRequest('/permission/getAllList', params)
};

// 添加权限
export const addPermission = (params) => {
    return postRequest('/permission/add', params)
};

// 编辑权限
export const editPermission = (params) => {
    return postRequest('/permission/edit', params)
};

// 删除权限
export const deletePermission = (ids, params) => {
    return deleteRequest(`/permission/delByIds/${ids}`, params)
};

// 分页获取日志数据
export const getLogListData = (params) => {
    return getRequest('/log/getAllByPage', params)
};

// 搜索获取日志数据
export const getSearchLogData = (params) => {
    return getRequest('/log/search', params)
};

// 删除日志
export const deleteLog = (ids, params) => {
    return deleteRequest(`/log/delByIds/${ids}`, params)
};

// 清空日志
export const deleteAllLog = (params) => {
    return deleteRequest('/log/delAll', params)
};

//首页数据，主要是统计
export const getDashboardData = () => {
    return getRequest('/home/statistics')
};

// 分页获取定时任务数据
export const getQuartzListData = (params) => {
    return getRequest('/quartzJob/getAllByPage', params)
};

// 添加定时任务
export const addQuartz = (params) => {
    return postRequest('/quartzJob/add', params)
};

// 编辑定时任务
export const editQuartz = (params) => {
    return postRequest('/quartzJob/edit', params)
};

// 暂停定时任务
export const pauseQuartz = (params) => {
    return postRequest('/quartzJob/pause', params)
};

// 恢复定时任务
export const resumeQuartz = (params) => {
    return postRequest('/quartzJob/resume', params)
};

// 删除定时任务
export const deleteQuartz = (ids, params) => {
    return deleteRequest(`/quartzJob/delByIds/${ids}`, params)
};

// 获取文章一级分类
export const initArticleCategory = (params) => {
    return getRequest('/article/category/getByParentId/0', params)
};

// 加载文章分类子级数据
export const loadArticleCategory = (id, params) => {
    return getRequest(`/article/category/getByParentId/${id}`, params)
};

// 添加文章分类
export const addArticleCategory = (params) => {
    return postRequest('/article/category/add', params)
};

// 编辑文章分类
export const editArticleCategory = (params) => {
    return postRequest('/article/category/edit', params)
};

// 删除文章分类
export const deleteArticleCategory = (ids, params) => {
    return deleteRequest(`/article/category/delByIds/${ids}`, params)
};

// 获取文章数据 多条件
export const getArticleListData = (params) => {
    return getRequest('/article/getByCondition', params)
};

// 获取文章详情
export const getArticle = (id) => {
    return getRequest(`/article/detail/${id}`)
};

// 添加文章
export const addArticle = (params) => {
    return postRequest('/article/add', params)
};

// 编辑文章
export const editArticle = (params) => {
    return postRequest('/article/edit', params)
};

export const uploadArticleThumb = "/skeleton/upload/articleThumb";

// 启用文章
export const enableArticle = (id, params) => {
    return postRequest(`/article/enable/${id}`, params)
};

// 禁用文章
export const disableArticle = (id, params) => {
    return postRequest(`/article/disable/${id}`, params)
};

// 删除文章
export const deleteArticle = (ids, params) => {
    return deleteRequest(`/article/delByIds/${ids}`, params)
};

//上传图片
export const uploadCommon = (params) => {
    return uploadFileRequest('/upload/common', params)
};

//获取上传文件访问域名
export const getUploadDomain = () => {
    return getRequest('/upload/getDomain');
};

// 获取用户数据 多条件
export const getUserInfoListData = (params) => {
    return getRequest('/userInfo/getByCondition', params)
};

// 添加用户
export const addUserInfo = (params) => {
    return postRequest('/userInfo/add', params)
};

// 删除用户
export const deleteUserInfo = (ids, params) => {
    return deleteRequest(`/userInfo/delByIds/${ids}`, params)
};

// 编辑用户
export const editUserInfo = (params) => {
    return postRequest('/userInfo/edit', params)
};

// 启用用户
export const enableUserInfo = (id, params) => {
    return postRequest(`/userInfo/enable/${id}`, params)
};

// 禁用用户
export const disableUserInfo = (id, params) => {
    return postRequest(`/userInfo/disable/${id}`, params)
};

// 修改用户密码
export const updateUserPassword = (params) => {
    return postRequest('/userInfo/updatePassword', params)
};
