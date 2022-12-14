package com.example.frame.common.utils;

public class Constant {

  public static final String PERMISSIONS_KEY = "permissions_key";
  public static final String USERID_KEY = "userid_key";
  public static final String USERNAME_KEY = "username_key";
  public static final String ROLES_KEY = "roles_key";

  /** 正常token */
  public static final String ACCESS_TOKEN = "authorization";
  /** 刷新token */
  public static final String REFRESH_TOKEN = "refresh_token";

  /** 组织机构编码key */
  public static final String DEPT_CODE_KEY = "dept-code-key_";

  /** 该角色拥有所有权限-不能删除 */
  public static final String SUPER_ROLE_ID = "11b3b80c-4a0b-4a92-96ea-fdd4f7a4a7e9";

  /** 权限key */
  public static final String JWT_PERMISSIONS_KEY = "jwt-permissions-key";

  /** 用户名称 key */
  public static final String JWT_USER_NAME = "jwt-user-name-key";
  /** 用户名称 key */
  public static final String JWT_USER_ACCOUNT = "jwt-user-account-key";
  /** 角色key */
  public static final String JWT_ROLES_KEY = "jwt-roles-key_";

  /** 主动去刷新 token key(适用场景 比如修改了用户的角色/权限去刷新token) */
  public static final String JWT_REFRESH_KEY = "jwt-refresh-key_";

  /** 刷新状态(适用场景如：一个功能点要一次性请求多个接口，当第一个请求刷新接口时候 加入一个节点下一个接口请求进来的时候直接放行) */
  public static final String JWT_REFRESH_STATUS = "jwt-refresh-status_";

  /** 标记新的access_token */
  public static final String JWT_REFRESH_IDENTIFICATION = "jwt-refresh-identification_";

  /** access_token 主动退出后加入黑名单 key */
  public static final String JWT_ACCESS_TOKEN_BLACKLIST = "jwt-access-token-blacklist_";

  /** refresh_token 主动退出后加入黑名单 key */
  public static final String JWT_REFRESH_TOKEN_BLACKLIST = "jwt-refresh-token-blacklist_";

  /** 菜单权限编码key */
  public static final String PERMISSION_CODE_KEY = "permission-code-key_";

  /** 标记用户是否已经删除 */
  public static final String DELETED_USER_KEY = "deleted-user-key_";

  /** 标记用户是否已经被锁定 */
  public static final String ACCOUNT_LOCK_KEY = "account-lock-key_";

  /** 用户权鉴缓存 key */
  public static final String IDENTIFY_CACHE_KEY =
      "shiro-cache:com.dk.common.shiro.CustomRealm.authorizationCache:";
}
