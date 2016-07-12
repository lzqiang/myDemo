truncate table csgl_daxxgl;
truncate table csgl_dxpfxxb;
truncate table csgl_jbdbxx;
truncate table csgl_sbmz;
truncate table csgl_sjcqinfo;
truncate table csgl_sqxxcldetail;
delete from  csgl_sqxxinfo;
commit;
truncate table csgl_yqdetail;
truncate table csgl_zxjbzfxx;
delete from  csgl_lbjxfxx;
delete from  csgl_zxjbxx;
commit;

truncate table zzww_daxxgl;
truncate table zzww_dxpfxxb;
truncate table zzww_jbdbxx;
truncate table zzww_sbmz;
truncate table zzww_yqdetail;
truncate table zzww_zxjbzfxx;
delete from  zzww_lbjxfxx;
delete from zzww_sfrxx;
delete from  zzww_zxjbxx;
commit;


truncate table jjly_symdcyrywh;
truncate table jjly_symdwh;
truncate table jjly_xmzyk;
truncate table jjly_xqjjlyfsxx;
truncate table jjly_xshs;
truncate table jjly_zddwfrxx;
truncate table jjly_zddwfsxx;
truncate table jjly_zddwrywh;
truncate table jjly_zsyzxm;
delete from jjly_zddwxx;
commit;

delete from zfcj_ldrkgf;
delete from zfcj_czfldrkhyzm;
delete from zfcj_fwzl;
delete from zfcj_gdld;
delete from zfcj_jzgd;
commit;

truncate table wqww_flgry;
truncate table sys_ldwhb;
delete from qyxx_cpjtxx;
commit;
delete from qyxx_kpxxb;
commit;
delete from qyxx_kpryglb;
commit;

truncate table qyxx_cjry;
truncate table qyxx_czcsry;
truncate table pda_dwhjxx;
truncate table pda_jhrxx;
truncate table pda_jhrxxwh;
truncate table pda_lrjhrxxb;
truncate table pda_smsin;
truncate table pda_smsout;
truncate table LOG_OPERATIONLOG;

delete from sys_userinfo where userid != 404;
commit;
update sys_secuser u set u.ylzd1='240' where u.secid=1;
commit;