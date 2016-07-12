delete sys_userinfo t where t.loginname<>'admin' ;
delete sys_secuser s where s.userid <> (select userid from sys_userinfo where loginname='admin');


truncate table sys_xqxxb;
truncate table sys_ldwhb;
truncate table qyxx_kpxxb;
truncate table qyxx_cpjtxx;
truncate table qyxx_kpryglb;
truncate table qyxx_kpryglbhjry;
