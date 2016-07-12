---------------------------------------
--drop定时维护任务
begin
  dbms_scheduler.drop_job(job_name => 'JOB_MAINTAIN_MV');
  dbms_scheduler.drop_job(job_name => 'JOB_TBYJ_DATA');
  dbms_scheduler.drop_job(job_name => 'JOB_PURGE_LOG');
end;
/

--drop维护脚本
drop procedure sys_maintain_mv;
drop procedure sys_tbyj_dataid;
---------------------------------------
---------------------------------------
--删除刷新组
begin
  --dbms_refresh.destroy(name => 'refgroup1');
  dbms_refresh.destroy(name => 'refgroup2');
end;
/
commit;
--------------------------------------
--Drop汇总视图
drop view tjxx_jbxxtj;
---------------------------------------
---Drop所有物化视图及物化视图日志
drop materialized view MV_JG_BFWWXX_AGG;
drop materialized view MV_JG_CJRY_AGG;
drop materialized view MV_JG_CSRK_AGG;
drop materialized view MV_JG_CXYLJZ_AGG;
drop materialized view MV_JG_CZCSRY_AGG;
drop materialized view MV_JG_CZRK_AGG;
drop materialized view MV_JG_DATAID;
drop materialized view MV_JG_DBH_AGG;
drop materialized view MV_JG_FLGRY_AGG;
drop materialized view MV_JG_FQYDW_AGG;
drop materialized view MV_JG_FXPGINFO_AGG;
drop materialized view MV_JG_FZXCZYZ_AGG;
drop materialized view MV_JG_GHRK_AGG;
drop materialized view MV_JG_HJRK_AGG;
drop materialized view MV_JG_INFO;
drop materialized view MV_JG_JBXX_AGG;
drop materialized view MV_JG_JJJZ_AGG;
drop materialized view MV_JG_JJLY_AGG;
drop materialized view MV_JG_JKXXJC_AGG;
drop materialized view MV_JG_JYFW_AGG;
drop materialized view MV_JG_JYQKXX_AGG;
drop materialized view MV_JG_KCH_AGG;
drop materialized view MV_JG_KP_AGG;
drop materialized view MV_JG_LDLZXXY_AGG;
drop materialized view MV_JG_LDRK_AGG;
drop materialized view MV_JG_LD_AGG;
drop materialized view MV_JG_LRRK_AGG;
drop materialized view MV_JG_RMTJY_AGG;
drop materialized view MV_JG_SCJR_AGG;
drop materialized view MV_JG_SHTT_AGG;
drop materialized view MV_JG_SJZDRY_AGG;
drop materialized view MV_JG_SQJZRY_AGG;
drop materialized view MV_JG_SZBJ_AGG;
drop materialized view MV_JG_TJHZINFO_AGG;
drop materialized view MV_JG_TJHZINFO_BASE;
drop materialized view MV_JG_TSRQ_AGG;
drop materialized view MV_JG_TXXX_AGG;
drop materialized view MV_JG_WXJSBRY_AGG;
drop materialized view MV_JG_WZXX_AGG;
drop materialized view MV_JG_XDRY_AGG;
drop materialized view MV_JG_XQ_AGG;
drop materialized view MV_JG_XSJJRY_AGG;
drop materialized view MV_JG_XYTYRY_AGG;
drop materialized view MV_JG_YBSB_AGG;
drop materialized view MV_JG_YFDXWH_AGG;
drop materialized view MV_JG_YJSJINFO_AGG;
drop materialized view MV_JG_YLFN_AGG;
drop materialized view MV_JG_ZDQSNRY_AGG;
drop materialized view MV_JG_ZHS_AGG;
drop materialized view MV_JG_ZHS_BASE;
drop materialized view MV_JG_ZJXY_AGG;
drop materialized view MV_JG_ZZRK_AGG;
drop materialized view MV_LD_BFWW_AGG;
drop materialized view MV_LD_CJRY_AGG;
drop materialized view MV_LD_CXYLJZ_AGG;
drop materialized view MV_LD_CZCSRY_AGG;
drop materialized view MV_LD_CZRK_AGG;
drop materialized view MV_LD_DATAID;
drop materialized view MV_LD_DBH_AGG;
drop materialized view MV_LD_FLGRY_AGG;
drop materialized view MV_LD_FZXCZYZ_AGG;
drop materialized view MV_LD_JJJZ_AGG;
drop materialized view MV_LD_JKXXJC_AGG;
drop materialized view MV_LD_JYFW_AGG;
drop materialized view MV_LD_JYQK_AGG;
drop materialized view MV_LD_KCH_AGG;
drop materialized view MV_LD_KP_AGG;
drop materialized view MV_LD_LDLZXXY_AGG;
drop materialized view MV_LD_LDRK_AGG;
drop materialized view MV_LD_LRRK_AGG;
drop materialized view MV_LD_LYFN_AGG;
drop materialized view MV_LD_RMTJY_AGG;
drop materialized view MV_LD_SCJR_AGG;
drop materialized view MV_LD_SJZDRY_AGG;
drop materialized view MV_LD_SQJZRY_AGG;
drop materialized view MV_LD_SZBJ_AGG;
drop materialized view MV_LD_TSRQ_AGG;
drop materialized view MV_LD_TXXX_AGG;
drop materialized view MV_LD_WXJSBRY_AGG;
drop materialized view MV_LD_XDRY_AGG;
drop materialized view MV_LD_XSJJRY_AGG;
drop materialized view MV_LD_XYTYRY_AGG;
drop materialized view MV_LD_YBSB_AGG;
drop materialized view MV_LD_YFDXWH_AGG;
drop materialized view MV_LD_ZDQSNRY_AGG;
drop materialized view MV_LD_ZJXY_AGG;
drop materialized view MV_LD_ZZRK_AGG;

--2014-07-22
drop materialized view MV_JG_xsqsn_AGG;
drop materialized view MV_LD_xsqsn_AGG;
drop materialized view MV_JG_azbhz_AGG;
drop materialized view MV_LD_azbhz_AGG;
drop materialized view MV_JG_xfzdry_AGG;
drop materialized view MV_LD_xfzdry_AGG;
drop materialized view MV_JG_zjxyxx_AGG;
drop materialized view MV_LD_zjxyxx_AGG;
drop materialized view MV_JG_lset_AGG;
drop materialized view MV_LD_lset_AGG;
drop materialized view MV_JG_lsfn_AGG;
drop materialized view MV_LD_lsfn_AGG;

--gaobin
drop materialized view  mv_jg_dy_agg;
drop materialized view  mv_zrr_dy_agg;

drop materialized VIEW MV_JG_FXRY_AGG;
drop materialized VIEW MV_JG_LXZZ_MBQYFDW_AGG;
drop materialized VIEW MV_JG_LXZZ_SHTT_AGG;
drop materialized VIEW MV_ZRR_FXRY_AGG;
drop materialized VIEW MV_ZRR_LXZZ_MBQYFDW_AGG;
drop materialized VIEW MV_ZRR_LXZZ_SHTT_AGG;


--drop materialized view MV_TBYJ_110_C;
--drop materialized view MV_TBYJ_DCJY_C;
--drop materialized view MV_TBYJ_DHJRY_C;
--drop materialized view MV_TBYJ_DYJRY_C;
--drop materialized view MV_TBYJ_GA_HJRK_C;
--drop materialized view MV_TBYJ_GA_LDRK_C;
--drop materialized view MV_TBYJ_GS_XLLDRK_C;
--drop materialized view MV_TBYJ_GS_YGRYRK_C;
--drop materialized view MV_TBYJ_HYWJG_C;
--drop materialized view MV_TBYJ_JT_XLLDRK_C;
--drop materialized view MV_TBYJ_MZ_JIEHUN_C;
--drop materialized view MV_TBYJ_MZ_LHTB_C;
--drop materialized view MV_TBYJ_MZ_LYSY_C;
--drop materialized view MV_TBYJ_NOID_C;
--drop materialized view MV_TBYJ_RLZY_XLLDRK_C;
--drop materialized view MV_TBYJ_SCJY_C;
--drop materialized view MV_TBYJ_SZBJ_C;
--drop materialized view MV_TBYJ_ZZWW_JGDAB1_C;
--drop materialized view MV_TBYJ_ZZWW_JGDAB2_C;
--drop materialized view MV_TBYJ_ZZWW_JGDAB3_C;
--drop materialized view MV_TBYJ_ZZWW_JGDB1_C;
--drop materialized view MV_TBYJ_ZZWW_JGDB2_C;
--drop materialized view MV_TBYJ_ZZWW_JGDB3_C;
drop materialized view MV_ZRR_BFWW_AGG;
drop materialized view MV_ZRR_CJRY_AGG;
drop materialized view MV_ZRR_CSRK_AGG;
drop materialized view MV_ZRR_CXYLJZ_AGG;
drop materialized view MV_ZRR_CZCSRY_AGG;
drop materialized view MV_ZRR_CZRK_AGG;
drop materialized view MV_ZRR_DATAID;
drop materialized view MV_ZRR_DBH_AGG;
drop materialized view MV_ZRR_FLGRY_AGG;
drop materialized view MV_ZRR_FZXCZYZ_AGG;
drop materialized view MV_ZRR_GHRK_AGG;
drop materialized view MV_ZRR_HJRK_AGG;
drop materialized view MV_ZRR_INFO;
drop materialized view MV_ZRR_JBXX_AGG;
drop materialized view MV_ZRR_JJJZ_AGG;
drop materialized view MV_ZRR_JJLY_AGG;
drop materialized view MV_ZRR_JKXXJC_AGG;
drop materialized view MV_ZRR_JYFW_AGG;
drop materialized view MV_ZRR_JYQK_AGG;
drop materialized view MV_ZRR_KCH_AGG;
drop materialized view MV_ZRR_KP_AGG;
drop materialized view MV_ZRR_LDLZXXY_AGG;
drop materialized view MV_ZRR_LDRK_AGG;
drop materialized view MV_ZRR_LD_AGG;
drop materialized view MV_ZRR_LRRK_AGG;
drop materialized view MV_ZRR_RMTJY_AGG;
drop materialized view MV_ZRR_SCJR_AGG;
drop materialized view MV_ZRR_SJZDRY_AGG;
drop materialized view MV_ZRR_SQJZRY_AGG;
drop materialized view MV_ZRR_SZBJ_AGG;
drop materialized view MV_ZRR_TSRQ_AGG;
drop materialized view MV_ZRR_TXXX_AGG;
drop materialized view MV_ZRR_WXJSBRY_AGG;
drop materialized view MV_ZRR_XDRY_AGG;
drop materialized view MV_ZRR_XQ_AGG;
drop materialized view MV_ZRR_XQ_BASE;
drop materialized view MV_ZRR_XSJJRY_AGG;
drop materialized view MV_ZRR_XYTYRY_AGG;
drop materialized view MV_ZRR_YBSB_AGG;
drop materialized view MV_ZRR_YFDXWH_AGG;
drop materialized view MV_ZRR_YLFN_AGG;
drop materialized view MV_ZRR_ZDQSNRY_AGG;
drop materialized view MV_ZRR_ZHS_AGG;
drop materialized view MV_ZRR_ZHS_BASE;
drop materialized view MV_ZRR_ZJXY_AGG;
drop materialized view MV_ZRR_ZZRK_AGG;
drop materialized view MV_ZRR_gys_AGG;
------------------------------------------------
--drop base table materialized view logs
drop materialized view log on DTJ_TJHZINFO;
drop materialized view log on FXPG_INFO;
drop materialized view log on GGYJ_CKINFO;
drop materialized view log on GGYJ_YJSJINFO;
drop materialized view log on QYXX_BFWWXX;
drop materialized view log on QYXX_CJRY;
drop materialized view log on QYXX_CPJTXX;
drop materialized view log on QYXX_CXYLJZ;
drop materialized view log on QYXX_CYSZBJXX;
drop materialized view log on QYXX_CZCSRY;
drop materialized view log on QYXX_DJWBRY;
drop materialized view log on QYXX_JJJZXX;
drop materialized view log on QYXX_JKXXJC;
drop materialized view log on QYXX_JYFWXX;
drop materialized view log on QYXX_JYQKXX;
drop materialized view log on QYXX_KCXX;
drop materialized view log on QYXX_KPRYGLB;
drop materialized view log on QYXX_KPRYGLBHJRY;
drop materialized view log on QYXX_KPXXB;
drop materialized view log on QYXX_LDLZXXY;
drop materialized view log on QYXX_RMTJY;
drop materialized view log on QYXX_SCJRXX;
drop materialized view log on QYXX_SJZDRYXX;
drop materialized view log on QYXX_TSRQXX;
drop materialized view log on QYXX_TXXX;
drop materialized view log on QYXX_WXJSBRYXX;
drop materialized view log on QYXX_XDRYXX;
drop materialized view log on QYXX_XYTYRY;
drop materialized view log on QYXX_YBSBXX;
drop materialized view log on QYXX_YFDXWH;
drop materialized view log on QYXX_ZDQSNRYXX;
--drop materialized view log on QYXX_ZJXYXX;
drop materialized view log on SYS_DEPTINFO;
drop materialized view log on SYS_JGXXB;
drop materialized view log on SYS_LDWHB;
drop materialized view log on SYS_USERINFO;
drop materialized view log on SYS_XQXXB;
drop materialized view log on SZMZ_MBFQYDW;
drop materialized view log on SZMZ_SHTT;
drop materialized view log on WQWW_FLGRY;
drop materialized view log on WQWW_FZXCZYZ;
drop materialized view log on WQWW_SQJZRY;
drop materialized view log on WQWW_XSJJRY;
drop materialized view log on YLFN_YLFNJBXX;
drop materialized view log on ZZWW_ZXJBXX;

drop materialized view log on xz_xsqsn;
drop materialized view log on xz_azbhz;
drop materialized view log on qyxx_xfzdry;
drop materialized view log on qyxx_zjxyxx;
drop materialized view log on xz_lset;
drop materialized view log on qyxx_lsfn;

drop materialized view log on  XT_ORG;
drop materialized view log on  QYXX_FXRY;
----------------------------------------------
--drop update sys_time schedule job
begin
  dbms_scheduler.drop_job(job_name => 'JOB_UPDATE_CUR_YEAR');
end;
/
--drop sys_time table
drop table sys_time purge;
drop table tjxx_tbyj_dataid purge;
drop table temp_tbyj_dataid;
