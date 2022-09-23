import {
  httpRequestUrl
} from "@/api/baseUrl";
import {
  requestServer,
  httpRequest
} from "@/api/baseApi";

/**
 * 用户登录
 * @param username  账号
 * @param password  密码
 * @param type  类型
 */
export const loginIn = (username, password) => {
  let params = {
    username: username,
    password: password,
    type: 2  //2为后台管理
  }
  return httpRequest(`${httpRequestUrl}` + "/sysUser/login", "post", params)
}

/**
 * 用户退出
 */
 export const logout = () => {
  return requestServer(`${httpRequestUrl}` + "/sysUser/logout", "POST", null)
}




/** 查询数据表*/
export const sysGeneratorlistByPage = (page,limit,search) => {
  let params = {page,limit,search}
  return requestServer(`${httpRequestUrl}` + "/sysGenerator/listByPage", "POST", params)
}


/** 代码生成 */
export const addGen = (tableName) => {
  let params = {tableName}
  return requestServer(`${httpRequestUrl}` + "/sysGenerator/add", "POST", params)
}




/** 查询任务调度分页*/
export const jobListByPage = (page,limit) => {
  let params = {page,limit}
  return requestServer(`${httpRequestUrl}` + "/job/listByPage", "POST", params)
}

/** 修改任务信息*/
export const editJob = (id, jobName, jobGroup, methodName, cronExpression, status, remark) => {
  let params = {id, jobName, jobGroup, methodName, cronExpression, status, remark}
  return requestServer(`${httpRequestUrl}` + "/job/edit", "PUT",params)
}


/** 执行任务*/
export const addJob = (jobName, jobGroup, methodName, cronExpression, status, remark) => {
  let params = {jobName, jobGroup, methodName, cronExpression, status, remark}
  return requestServer(`${httpRequestUrl}` + "/job/add", "POST", params)
}

/** 执行任务*/
export const triggerTask = (ids) => {
  let params = {ids}
  return requestServer(`${httpRequestUrl}` + "/job/trigger", "POST", ids)
}

/** 停止任务*/
export const pauseTask = (ids) => {
  let params = {ids}
  return requestServer(`${httpRequestUrl}` + "/job/pause", "POST", ids)
}

/** 恢复任务*/
export const resumeTask = (ids) => {
  let params = {ids}
  return requestServer(`${httpRequestUrl}` + "/job/resume", "POST", ids)
}

/** 删除任务*/
export const deleteTask = (ids) => {
  let params = {ids}
  return requestServer(`${httpRequestUrl}` + "/job/deleted", "DELETE", ids)
}


/** 操作日志*/
export const listSysLogPage = (page,limit,operation) => {
  let params = {page,limit,operation}
  return requestServer(`${httpRequestUrl}` + "/sysLog/logs", "POST", params)
}

/** 删除日志*/
export const deleteLogs = (logIds) => {
  return requestServer(`${httpRequestUrl}` + "/sysLog/logs", "DELETE", logIds)
}


/** 查询菜单数据*/
export const sysMenuslistByPage = (page,limit) => {
  let params = {page,limit}
  return requestServer(`${httpRequestUrl}` + "/sysPermission/listByPage", "POST", params)
}


/** 查权限list数据*/
export const getFirstMenus = (type,id,pid) => {
  let params = {type,id,pid}
  return requestServer(`${httpRequestUrl}` + "/sysPermission/listByCondition", "POST", params)
}

/** 新增菜单*/
export const addMenus = (name, pid, urlWeb, orderNum, status,type) => {
  let params = {name, pid, urlWeb, orderNum, status,type}
  return requestServer(`${httpRequestUrl}` + "/sysPermission/add", "POST", params)
}

/** 修改菜单*/
export const updateMenus = (id,name, pid, urlWeb, orderNum, status,type) => {
  let params = {id,name, pid, urlWeb, orderNum, status,type}
  return requestServer(`${httpRequestUrl}` + "/sysPermission/update", "PUT", params)
}



/** 删除菜单*/
export const deleteMenus = (id) => {
  return requestServer(`${httpRequestUrl}` + "/sysPermission/delete?id="+id, "DELETE")
}



/** 拦截异常日志*/
export const listSysInterceptLogPage = (page,limit,ip) => {
  let params = {page,limit,ip}
  return requestServer(`${httpRequestUrl}` + "/sysInterceptLog/listByPage", "POST", params)
}

/** 删除拦截异常日志*/
export const deleteSysInterceptLogs  = (logIds) => {
  return requestServer(`${httpRequestUrl}` + "/sysInterceptLog/delete", "DELETE", logIds)
}



/** 查询数据字典类型数据*/
export const dictTypeByPage = (page,limit,dictName) => {
  let params = {page,limit,dictName}
  return requestServer(`${httpRequestUrl}` + "/sysDictType/listByPage", "POST", params)
}

/** 查询数字字典数据*/
export const dictDataByPage = (page,limit,typeId,dictLabel) => {
  let params = {page,limit,typeId,dictLabel}
  return requestServer(`${httpRequestUrl}` + "/sysDictData/listByPage", "POST", params)
}


/** 新增数据字典类型数据*/
export const addDictType = (dictName, dictType, remark, status) => {
  let params = {dictName, dictType, remark, status}
  return requestServer(`${httpRequestUrl}` + "/sysDictType/add", "POST", params)
}


/** 更新数据字典类型数据*/
export const editDictType = (id,dictName, dictType, remark, status) => {
  let params = {id,dictName, dictType, remark, status}
  return requestServer(`${httpRequestUrl}` + "/sysDictType/update", "PUT", params)
}

/** 删除数据字典类型数据*/
export const deleteDictType = (ids) => {
  return requestServer(`${httpRequestUrl}` + "/sysDictType/delete", "DELETE", ids)
}


/** 增加字典标签数据*/
export const addDictData = (dictLabel, dictValue, remark, status,typeId,dictType) => {
  let params = {dictLabel, dictValue, remark, status,typeId,dictType}
  return requestServer(`${httpRequestUrl}` + "/sysDictData/add", "POST", params)
}


/** 修改字典标签数据*/
export const editDictData = (id,dictLabel, dictValue, remark, status,typeId) => {
  let params = {id,dictLabel, dictValue, remark, status,typeId}
  return requestServer(`${httpRequestUrl}` + "/sysDictData/update", "PUT", params)
}

/** 删除字典标签数据*/
export const deleteDictData = (ids) => {
  return requestServer(`${httpRequestUrl}` + "/sysDictData/delete", "DELETE", ids)
}





/** 角色分页 */
export const listRoleByPage = (page,limit,name) => {
  let params = {page,limit,name}
  return requestServer(`${httpRequestUrl}` + "/sysRole/listByPage", "POST", params)
}

/** 删除角色 */
export const deleteRole = (ids) => {
  return requestServer(`${httpRequestUrl}` + "/sysRole/delete", "DELETE", ids)
}

/** 树结构菜单数据 */
export const menusListByTree = () => {
  let params = {type:1}
  return requestServer(`${httpRequestUrl}` + "/sysPermission/listByTree", "POST", params)
}

/** 树结构权限数据 */
export const permissionListByTree = () => {
  let params = {type:3}
  return requestServer(`${httpRequestUrl}` + "/sysPermission/listByTree", "POST", params)
}

/** 查询已选择的菜单和按钮权限 */
export const permissionAndMenusList = (roleId) => {
  let params = {roleId}
  return requestServer(`${httpRequestUrl}` + "/sysRolePermission/listByCondition", "POST", params)
}

/** 新增角色 */
export const addRole = (name, description, status, permissionList) => {
  let params = {name, description, status, permissionList}
  return requestServer(`${httpRequestUrl}` + "/sysRole/add", "POST", params)
}

/** 修改角色 */
export const editRole = (id,name, description, status, permissionList) => {
  let params = {id,name, description, status, permissionList}
  return requestServer(`${httpRequestUrl}` + "/sysRole/update", "PUT", params)
}



/* 获取所有树数据 */
export const getTreeALL = () => {
  let params = {}
  return requestServer(`${httpRequestUrl}` + "/sysTreeData/listByCondition", "POST", params)
}

/* 获取所有树分页数据 */
export const getTreePage = (page,limit,sdPid,sdName) => {
  let params = {page,limit,sdPid,sdName}
  return requestServer(`${httpRequestUrl}` + "/sysTreeData/listByPage", "POST", params)
}

/* 新增树数据 */
export const addTree = (sdName, sdCode, bz, sdPid) => {
  let params = {sdName, sdCode, bz, sdPid}
  return requestServer(`${httpRequestUrl}` + "/sysTreeData/add", "POST", params)
}
/* 修改树数据 */
export const editTree = (id,sdName, sdCode, bz, sdPid) => {
  let params = {id,sdName, sdCode, bz, sdPid}
  return requestServer(`${httpRequestUrl}` + "/sysTreeData/update", "PUT", params)
}

/* 删除树数据 */
export const deleteTree = (ids) => {
  // let params = {id}
  return requestServer(`${httpRequestUrl}` + "/sysTreeData/delete", "DELETE", ids)
}



/* 获取用户分页数据 */
export const sysUserlistByPage = (page,limit,search,sdCode) => {
  let params = {page,limit,search,sdCode}
  return requestServer(`${httpRequestUrl}` + "/sysUserLogin/listByPage", "POST", params)
}


/* 获取角色List数据 */
export const sysRolelist = () => {
  let params = {}
  return requestServer(`${httpRequestUrl}` + "/sysRole/listByCondition", "POST", params)
}



/* 新增用户 */
export const addUser = (realName, zjhm, jh, password, roleIdList, sdCode) => {
  let params = {realName, zjhm, jh, password, roleIdList, sdCode}
  return requestServer(`${httpRequestUrl}` + "/sysUser/add", "POST", params)
}

/* 编辑用户 */
export const editUser = (id, realName, zjhm, jh, password, roleId, sdCode,relateId) => {
  let params = {id, realName, zjhm, jh, password, roleId, sdCode,relateId}
  return requestServer(`${httpRequestUrl}` + "/sysUser/update", "PUT", params)
}


/* 删除用户 */
export const deleteUser = (ids) => {
  // let params = {id}
  return requestServer(`${httpRequestUrl}` + "/sysUser/delete", "DELETE", ids)
}



/* 获取所有盘空间 */
export const diskInfo = () => {
  return requestServer(`${httpRequestUrl}` + "/sysUser/diskInfo", "POST", null)
}


/* sql注入 */
export const sqlInjection = (sql) => {
  return requestServer(`${httpRequestUrl}` + "/sqlInjection/sqlInjection?sql="+sql, "POST", null)
}


/* 查询所有表 */
export const selectAllTable = () => {
  return requestServer(`${httpRequestUrl}` + "/sqlInjection/selectAllTable", "POST", null)
}



/* 锁定用户 */
export const lockUser = (id,time) => {
  let params = {id,time}
  return requestServer(`${httpRequestUrl}` + "/sysUserLogin/lockUser", "POST", params)
}


/* 解锁用户 */
export const untieUser = (id) => {
  return requestServer(`${httpRequestUrl}` + "/sysUserLogin/untieUser?id="+id, "POST", null)
}


/* 导入附件 */
export const addAttachement = (fjdl, fjlx, tempPath, ysmc) => {
  let params = {fjdl, fjlx, tempPath, ysmc}
  return requestServer(`${httpRequestUrl}` + "/publicAttachement/add", "POST", params)
}
/* 导入附件 */
export const editAttachement = (id,fjdl, fjlx, tempPath, ysmc) => {
  let params = {id,fjdl, fjlx, tempPath, ysmc}
  return requestServer(`${httpRequestUrl}` + "/publicAttachement/update", "PUT", params)
}


/* 附件分页数据 */
export const publicAttachementListByPage =(page,limit,search) => {
  let params = {page,limit,search}
  return requestServer(`${httpRequestUrl}` + "/publicAttachement/listByPage", "POST", params)
}

/* 删除附件 */
export const deleteFile=(ids)=>{
  return requestServer(`${httpRequestUrl}` + "/publicAttachement/delete", "DELETE", ids)
}


/* 获取字典 */
export const getDict = (dictType) => {
  let params = {dictType}
  return requestServer(`${httpRequestUrl}` + "/sysDictType/listByCondition", "POST", params)
}


/* ip黑名单分页 */
export const backIpListByPage=(page,limit,ip)=>{
  let params = {page,limit,ip}
  return requestServer(`${httpRequestUrl}` + "/ipBlacklistInfo/listByPage", "POST", params)
}

/* 新增黑名单ip */
export const addBackIp=(ip, mapping, effectiveTime, type)=>{
  let params = {ip, mapping, effectiveTime, type}
  return requestServer(`${httpRequestUrl}` + "/ipBlacklistInfo/add", "POST", params)
}


/* 删除黑名单ip */
export const deleteBackIp=(ids)=>{
  return requestServer(`${httpRequestUrl}` + "/ipBlacklistInfo/delete", "DELETE", ids)
}



/* 地区白名单分页 */
export const whiteRegionByPage=(page,limit,city)=>{
  let params = {page,limit,city}
  return requestServer(`${httpRequestUrl}` + "/whiteRegionInfo/listByPage", "POST", params)
}


/* 新增地区白名单 */
export const addWhiteRegion=(city,region)=>{
  let params = {city,region}
  return requestServer(`${httpRequestUrl}` + "/whiteRegionInfo/add", "POST", params)
}

/* 删除黑名单ip */
export const deleteRegion=(ids)=>{
  return requestServer(`${httpRequestUrl}` + "/whiteRegionInfo/delete", "DELETE", ids)
}

