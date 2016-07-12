
truncate table cs110;
truncate table csgl_bmlinkinfo;
truncate table csgl_dxpfxxb;
delete csgl_dxkhxxb;
truncate table csgl_dxwh;
truncate table csgl_lbjxfxx;
truncate table csgl_sbmz;
truncate table csgl_zxjbxx;
truncate table csgl_zxjbxx;
truncate table dtj_ryinfo;
truncate table fxpg_zrzt;
truncate table gabm_hjxxxg;
truncate table gabm_xlldrk;
truncate table ggyj_center;
truncate table gsbm_xlldrk;
truncate table gsbm_ygryrk;
truncate table hmgc_jgbmxx;
truncate table jtbm_xlldrk;
truncate table mzbm_lhtb;
truncate table mzbm_mzbmtb;
truncate table mzbm_ylsy;
truncate table rlzy_xlldrk;
truncate table sys_jlrzdy;
truncate table wsbm_ldrkhy;
truncate table wsbm_ldrktb;
truncate table wsbm_xsetb;
truncate table wsbm_xsjyxxtb;
truncate table wsbm_zyxxtb;
truncate table xwxx_xzzbxx;
truncate table zfcj_czfldrkhyzm;
truncate table zfcj_fwzl;
truncate table zfcj_gdld;
truncate table zfcj_jzgd;
truncate table zfcj_ldrkgf;
truncate table zzww_bmlinkinfo;
truncate table zzww_dxpfxxb;
delete zzww_dxkhxxb;
truncate table zzww_dxwh;
truncate table zzww_lbjxfxx;
truncate table zzww_sbmz;
truncate table zzww_zxjbzfxx;
delete sys_deptinfo;

truncate table qyxx_jkxxjc;
truncate table qyxx_dbjz;
truncate table qyxx_lszn;
truncate table qyxx_wbry;
truncate table qyxx_dbry;
truncate table qyxx_sbxx;
truncate table xz_azbhz;
truncate table xz_lnhgry;
truncate table xz_lset;
truncate table xz_xsqsn;
truncate table wqww_fzxczyz;
truncate table wqww_flgry;
truncate table wqww_xsjjry;
truncate table qyxx_sjzdryxx;
truncate table qyxx_xdryxx;
truncate table qyxx_xdryxx;
truncate table qyxx_wxjsbryxx;
truncate table qyxx_zdqsnryxx;
truncate table qyxx_rmtjy;
truncate table qyxx_ldlzxxy;
truncate table qyxx_zjxyxx;
truncate table qyxx_xfzdry;
truncate table qyxx_xdryxx;
--生殖保健
truncate table qyxx_cyszbjxx;
--就业服务
truncate table qyxx_jyfwxx
--残疾人员
truncate table qyxx_cjry;
--低保人员
truncate table qyxx_djwbry;
--空巢信息
truncate table qyxx_kcxx;
--退休信息
truncate table qyxx_txxx;
--参战参试人员
truncate table qyxx_czcsry;
--医保社保
truncate table qyxx_ybsbxx;
truncate table qyxx_cxyljz;
truncate table qyxx_jjjzxx;
truncate table qyxx_scjrxx;
truncate table qyxx_tsrqxx;
truncate table qyxx_xytyry;
truncate table qyxx_bfwwxx;
truncate table qyxx_jyqkxx;
truncate table wqww_sqjzry;


truncate table sys_xqxxb;
truncate table sys_ldwhb;
truncate table qyxx_kpxxb;
truncate table qyxx_cpjtxx;
truncate table qyxx_kpryglb;
truncate table qyxx_kpryglbhjry;
--案件流程表 社区事务案件流程
truncate table ng_casecheckin;
truncate table ng_handle;
truncate table ng_fc;
truncate table ng_photograph;
truncate table ng_untread;
truncate table ng_yqsq;
--------------------------------


delete sys_userinfo t where t.loginname<>'admin' ;
delete sys_secuser s where s.userid <> (select userid from sys_userinfo where loginname='admin');

--党建相关表-----------------
truncate table sqdj_activity;
truncate table sqdj_dydfxx;
truncate table sqdj_dyjcqk;
truncate table sqdj_dyldxxb;
truncate table sqdj_dypyb;
truncate table sqdj_dyxxwh_imp;
truncate table sqdj_enterprise;
truncate table sqdj_gzrcap;
truncate table sqdj_importantactivity;
truncate table sqdj_workgoal;
truncate table sqdj_workplan;
truncate table sqdj_zzshap;
TRUNCATE TABLE sqdj_dyxxwh
DELETE FROM sqdj_sqdjxx;
COMMIT;
---------------------------------



delete from qyxx_cyszbjxx
delete from qyxx_cxyljz
delete from qyxx_tsrqxx
delete from qyxx_jkxxjc
delete from qyxx_dbjz
delete from qyxx_sjzdryxx
delete from qyxx_rmtjy
delete from qyxx_zjxyxx
delete from qyxx_xfzdry



