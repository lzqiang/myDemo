--配置表
create table sys_time (cur_year varchar2(4));
create materialized view log on sys_time nologging with rowid,sequence (cur_year) including new values;
insert into sys_time(cur_year) select to_char(sysdate,'yyyy') from dual;
commit;

begin
  sys.dbms_scheduler.create_job(job_name            => 'QYRK.JOB_UPDATE_CUR_YEAR',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin update sys_time set cur_year=to_char(sysdate,''yyyy''); commit; end;',
                                start_date          => sysdate,
                                repeat_interval     => 'Freq=Yearly;Interval=1;ByMonth=1;ByMonthDay=1;ByHour=00;ByMinute=00;BySecond=00',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'update sys_time table''s cur_year colum to current year');
end;
/
begin
  dbms_scheduler.run_job(job_name => 'QYRK.JOB_UPDATE_CUR_YEAR');
end;
/
/*
基表物化视图日志创建
*/
create materialized view log on sys_userinfo nologging with  rowid,sequence (userid,ssjg,qwzt) including new values;
create materialized view log on sys_jgxxb nologging with  rowid,sequence (jgid,jgbm) including new values;
create materialized view log on sys_xqxxb nologging with  rowid,sequence (xqid,ssdept) including new values;
create materialized view log on sys_ldwhb nologging with  rowid,sequence (ldid,jgid,ldlx,xqid,zrruserid) including new values;

create materialized view log on qyxx_kpryglb nologging with  rowid,sequence (kpxxid,cyid,rklx,sfczr,guanliid,jgid,ldid,hm) including new values;
create materialized view log on qyxx_kpxxb nologging with  rowid,sequence (kpxxid,ldhm) including new values;
create materialized view log on qyxx_cpjtxx nologging with  rowid,sequence (cyid,csny,hjxxdz,zzmm) including new values;

create materialized view log on ylfn_ylfnjbxx nologging with  rowid,sequence (ylzd4) including new values;
create materialized view log on qyxx_kpryglbhjry nologging with  rowid,sequence (kpxxid) including new values;
create materialized view log on qyxx_djwbry nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_kcxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_cyszbjxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_jyfwxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_cjry nologging with  rowid,sequence (cyid) including new values;
create materialized view log on wqww_flgry nologging with  rowid,sequence (cyid) including new values;
create materialized view log on wqww_xsjjry nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_txxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_czcsry nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_ybsbxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_cxyljz nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_jjjzxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_scjrxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_tsrqxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_xytyry nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_jkxxjc nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_bfwwxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_jyqkxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on wqww_fzxczyz nologging with  rowid,sequence (cyid) including new values;
create materialized view log on wqww_sqjzry nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_sjzdryxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_xdryxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_wxjsbryxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_zdqsnryxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_rmtjy nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_ldlzxxy nologging with  rowid,sequence (cyid) including new values;
--create materialized view log on qyxx_zjxyxx nologging with  rowid,sequence (cyid) including new values;
create materialized view log on qyxx_yfdxwh nologging with  rowid,sequence (cyid) including new values;

create materialized view log on ggyj_ckinfo nologging with  rowid,sequence (ckinfoid,ssjg) including new values;
create materialized view log on zzww_zxjbxx nologging with  rowid,sequence (jbid,clsysjgxx,shjg,zrruserid) including new values;
create materialized view log on ggyj_yjsjinfo nologging with  rowid,sequence (yjsjinfoid,ssjg) including new values;
create materialized view log on fxpg_info nologging with  rowid,sequence (infoid,ssjg) including new values;
create materialized view log on dtj_tjhzinfo nologging with  rowid,sequence (tjbaseinfoid,tjbm,sfdqky) including new values;
create materialized view log on sys_deptinfo nologging with  rowid,sequence (deptid,ssjgid) including new values;
create materialized view log on szmz_mbfqydw nologging with  rowid,sequence (mbfqyid,ssdq) including new values;
create materialized view log on szmz_shtt nologging with  rowid,sequence (shttid,ssdq) including new values;

--2014
create materialized view log on xz_xsqsn nologging with  rowid,sequence (CYID) including new values;
create materialized view log on xz_azbhz nologging with  rowid,sequence (CYID) including new values;
create materialized view log on qyxx_xfzdry nologging with  rowid,sequence (CYID) including new values;
create materialized view log on qyxx_zjxyxx nologging with  rowid,sequence (CYID) including new values;
create materialized view log on xz_lset nologging with  rowid,sequence (CYID) including new values;
create materialized view log on qyxx_lsfn nologging with  rowid,sequence (CYID) including new values;

/*
基础物化视图创建
*/
create materialized view mv_jg_info nologging
build immediate
refresh fast on commit
disable query rewrite
as
--全机构列表
select b.jgid, b.jgbm,count(*) cnt
  from sys_userinfo a, sys_jgxxb b
 where a.ssjg = b.jgid
 group by b.jgid, b.jgbm;

create materialized view mv_zrr_info nologging
build immediate
refresh fast on commit
disable query rewrite
as
--全责任人列表
select a.userid, b.jgbm,a.rowid user_rid,b.rowid jg_rid
  from sys_userinfo a, sys_jgxxb b
 where a.ssjg = b.jgid(+)
   and qwzt = 1;

create materialized view log on mv_jg_info nologging with  rowid,sequence (jgid,jgbm) including new values;
create materialized view log on mv_zrr_info nologging with  rowid,sequence (userid,jgbm) including new values; 
-----------------------------------------------------------------------------------------------
--机构类统计指标物化视图 Begin
-----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
                    --户况图统计指标物化视图 Begin
----------------------------------------------------------------------------------------
create materialized view mv_jg_dy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--30919  党员信息数据字典中添加的id
select f.jgbm, count(*) num
  from QYXX_KPRYGLB a, QYXX_CPJTXX e, SYS_JGXXB f
 where a.CYID = e.CYID
   and a.jgid = f.jgid
   and e.zzmm = 43
 group by f.jgbm;

create materialized view mv_jg_xq_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6148  小区数量
select b.jgbm,count(a.xqid) num,count(*) cnt
  from sys_xqxxb a, sys_jgxxb b
 where a.ssdept = b.jgid
 group by b.jgbm;
 
create materialized view mv_jg_ld_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6149  楼栋数量
select b.jgbm,count(a.ldid) num,count(*) cnt
  from SYS_LDWHB a, sys_jgxxb b
 where a.jgid = b.jgid
   and a.ldlx = 282
 group by b.jgbm;

create materialized view mv_jg_jjly_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6150  经济楼宇数量
select b.jgbm, count(a.ldid) num,count(*) cnt
  from SYS_LDWHB a, sys_jgxxb b
 where a.jgid = b.jgid
   and a.ldlx <> 282
 group by b.jgbm;

create materialized view mv_jg_ldrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6151  流动人口数量
select f.jgbm, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and a.RKLX in (20, 21)
 group by f.jgbm;
/*
select f.jgbm, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       SYS_JGXXB    f
 where a.jgid=f.jgid
   and a.RKLX in (20, 21)
 group by f.jgbm;
*/
create materialized view mv_jg_kp_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6152  卡片数
select d.jgbm, count(a.KPXXID) num,count(*) cnt
  from QYXX_KPXXB a, SYS_LDWHB b, SYS_XQXXB c, SYS_JGXXB d, SYS_USERINFO e
 where a.LDHM = b.ldid
   and b.JGID = d.jgid
   and b.XQID = c.xqid
   and b.ZRRUSERID = e.userid
 group by d.jgbm;
/*
select d.jgbm, count(a.KPXXID) num,count(*) cnt
  from QYXX_KPXXB a, SYS_LDWHB b, SYS_JGXXB d
 where a.LDHM = b.ldid
   and b.JGID = d.jgid
   and b.ZRRUSERID is not null
 group by d.jgbm;
*/
 
create materialized view mv_jg_zzrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6153  在住人口数
select e.jgbm, count(*) num
  from qyxx_kpryglb a, qyxx_kpxxb b, sys_ldwhb c, sys_jgxxb e
 where a.kpxxid = b.kpxxid
   and b.ldhm = c.ldid
   and c.jgid = e.jgid
   and a.sfczr = 'N'
 group by e.jgbm;
/*
select e.jgbm, count(*) num
  from qyxx_kpryglb a, sys_jgxxb e
 where a.jgid = e.jgid
   and a.sfczr = 'N'
 group by e.jgbm;
*/
create materialized view mv_jg_ylfn_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6154  育龄妇女数
select b.jgbm, count(*) num
  from YLFN_YLFNJBXX q,
       QYXX_KPRYGLB  a,
       SYS_JGXXB     b,
       SYS_LDWHB     c,
       QYXX_KPXXB    f,
       QYXX_CPJTXX   g
 where a.KPXXID = f.KPXXID
   and f.LDHM = c.LDID
   and b.jgid = c.jgid
   and a.CYID = g.CYID
   and q.YLZD4 = a.GUANLIID
 group by b.jgbm;
/*
select b.jgbm, count(*) num
  from YLFN_YLFNJBXX q,
       QYXX_KPRYGLB  a,
       SYS_JGXXB     b
 where b.jgid = a.jgid
   and q.YLZD4 = a.GUANLIID
 group by b.jgbm;
*/
create materialized view mv_jg_czrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6155  常住人口数
select e.jgbm, count(*) num
  from qyxx_kpryglb a, qyxx_kpxxb b, sys_ldwhb c, sys_jgxxb e
 where a.kpxxid = b.kpxxid
   and b.ldhm = c.ldid
   and c.jgid = e.jgid
   and a.sfczr = 'N'
   and a.rklx = 19
 group by e.jgbm;
/*
select e.jgbm, count(*) num
  from qyxx_kpryglb a, sys_jgxxb e
 where a.jgid = e.jgid
   and a.sfczr = 'N'
   and a.rklx = 19
 group by e.jgbm;
*/
create materialized view mv_jg_lrrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6156  流入人口数
select e.jgbm, count(*) num
  from qyxx_kpryglb a, qyxx_kpxxb b, sys_ldwhb c, sys_jgxxb e
 where a.kpxxid = b.kpxxid
   and b.ldhm = c.ldid
   and c.jgid = e.jgid
   and a.sfczr = 'N'
   and a.rklx = 21
 group by e.jgbm;
/*
select e.jgbm, count(*) num
  from qyxx_kpryglb a, sys_jgxxb e
 where a.jgid = e.jgid
   and a.sfczr = 'N'
   and a.rklx = 21
 group by e.jgbm;
*/
create materialized view mv_jg_hjrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6157  户籍人口数
select e.jgbm, count(*) num
  from Qyxx_Kpryglbhjry a, qyxx_kpxxb b, sys_ldwhb c, sys_jgxxb e
 where a.kpxxid = b.kpxxid
   and b.ldhm = c.ldid
   and c.jgid = e.jgid
 group by e.jgbm;
/*
select e.jgbm, count(*) num
  from Qyxx_Kpryglbhjry a, sys_jgxxb e
 where a.jgid = e.jgid
 group by e.jgbm;
*/
create materialized view mv_jg_csrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6158  出生人口数
select f.jgbm, count(*) num
  from QYXX_KPRYGLB a, QYXX_CPJTXX e, SYS_JGXXB f,sys_time t
 where a.CYID = e.CYID
   and a.jgid = f.jgid
   and to_char(e.CSNY, 'yyyy') = t.cur_year
 group by f.jgbm;

create materialized view mv_jg_dbh_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6159  低保户
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,QYXX_DJWBRY r
 where a.JGID = f.jgid and a.CYID = r.CYID
 group by f.jgbm;
 
create materialized view mv_jg_kch_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6160  空巢户 空巢老人
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,QYXX_KCXX r
 where a.JGID = f.jgid and a.CYID = r.CYID
 group by f.jgbm;
 
create materialized view mv_jg_szbj_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6168  生殖保健
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_cyszbjxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;
 
create materialized view mv_jg_jyfw_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6169  就业服务
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f, qyxx_jyfwxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;
 

create materialized view mv_jg_cjry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6170  残疾人员
select f.jgbm, count(a.cyid) num, count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f, qyxx_cjry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;
 

create materialized view mv_jg_flgry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6171  法轮功人员信息
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,wqww_flgry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;
 
create materialized view mv_jg_xsjjry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6172  刑释解教人员信息
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,wqww_xsjjry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_txxx_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as 
--6173  退休信息
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_txxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_czcsry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6174  参战参试
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_czcsry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_ybsb_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as 
--6175  医保社保
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_ybsbxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_cxyljz_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as 
--6176  城乡医疗
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_cxyljz r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_jjjz_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as 
--6177  救灾救济
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_jjjzxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_scjr_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as 
--6178  伤残军人
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_scjrxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_tsrq_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as 
--6179  特殊人群
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_tsrqxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_xytyry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6180  现役退役
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_xytyry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_jkxxjc_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as 
--6181  健康检查
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_jkxxjc r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_bfwwxx_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as 
--6182  帮扶慰问
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_bfwwxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_jyqkxx_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6183  教育情况
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_jyqkxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_fzxczyz_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as 
--6184  法制宣传志愿者
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,wqww_fzxczyz r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_sqjzry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6185  社区矫正人员
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,wqww_sqjzry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;
 
create materialized view mv_jg_sjzdry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6186  涉军重点人员
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_sjzdryxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;
 
create materialized view mv_jg_xdry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6187  吸毒人员
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_xdryxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_wxjsbry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6188  危险精神病人员
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_wxjsbryxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;
 
create materialized view mv_jg_zdqsnry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6189  重点青少年人员
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_zdqsnryxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_rmtjy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6190  人民调解员
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_rmtjy r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_ldlzxxy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6191  楼栋长信息员
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_ldlzxxy r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_zjxy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6192  宗教信仰信息
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_zjxyxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

create materialized view mv_jg_yfdxwh_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6193  优抚对象信息
select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_yfdxwh r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;
----------------------------------------------------------------------------------------
                    --户况图统计指标物化视图 End
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
                    --新统计指标物化视图 Begin
----------------------------------------------------------------------------------------
create materialized view mv_jg_wzxx_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--16248  物资信息
select t.jgbm,count(q.CKINFOID) num,count(*) cnt
  from GGYJ_CKINFO q, sys_jgxxb t
 where q.ssjg = t.jgid
 group by t.jgbm;

create materialized view mv_jg_jbxx_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--16249  信访事件
select t.jgbm,count(q.JBID) num,count(*) cnt
  from ZZWW_ZXJBXX q, sys_jgxxb t
 where q.CLSYSJGXX = t.jgid
   and q.SHJG = 0
 group by t.jgbm;

create materialized view mv_jg_yjsjinfo_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--16250  公共应急事件
select t.jgbm, count(q.YJSJINFOID) num, count(*) cnt
  from GGYJ_YJSJINFO q, sys_jgxxb t
 where q.SSJG = t.jgid
 group by t.jgbm;

create materialized view mv_jg_fxpginfo_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--16251  风险评估事件
select t.jgbm, count(q.INFOID) num, count(*) cnt
  from FXPG_INFO q, sys_jgxxb t
 where q.SSJG = t.jgid
 group by t.jgbm;

----------------
create materialized view mv_jg_tjhzinfo_base nologging
build immediate
refresh fast on demand
disable query rewrite
as
select t.jgbm, q.TJBASEINFOID, count(*) cnt
  from DTJ_TJHZINFO q, SYS_DEPTINFO d, sys_jgxxb t
 where q.TJBM = d.DEPTID
   and d.SSJGID = t.jgid
   and q.SFDQKY = 'Y'
 group by t.jgbm, q.TJBASEINFOID;
create materialized view log on mv_jg_tjhzinfo_base nologging with  rowid,sequence (jgbm,TJBASEINFOID) including new values;

create materialized view mv_jg_tjhzinfo_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--16252  大调解事件
select jgbm, count(TJBASEINFOID) num, count(*) cnt
  from mv_jg_tjhzinfo_base
 group by jgbm;
----------------

create materialized view mv_jg_shtt_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--16268  社会团体
select t.jgbm, count(q.SHTTID) num, count(*) cnt
  from SZMZ_SHTT q, sys_jgxxb t
 where q.SSDQ = t.jgid
 group by t.jgbm;

create materialized view mv_jg_fqydw_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--16269  非企业单位
select t.jgbm, count(q.MBFQYID) num, count(*) cnt
  from SZMZ_MBFQYDW q, sys_jgxxb t
 where q.SSDQ = t.jgid
 group by t.jgbm;

-------------------
create materialized view mv_jg_zhs_base nologging
build immediate
refresh fast on demand
disable query rewrite
as
select b.jgbm, a.kpxxid, nvl(a.hm, 1) hm,count(*) cnt
  from qyxx_kpryglb a, sys_jgxxb b
 where a.jgid = b.jgid
 group by b.jgbm, a.kpxxid,nvl(a.hm, 1);
create materialized view log on mv_jg_zhs_base nologging with  rowid,sequence (jgbm,kpxxid,hm) including new values; 

create materialized view mv_jg_zhs_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--16288  总户数
select jgbm, count(hm) num,count(*) cnt
  from mv_jg_zhs_base
 group by jgbm;
-------------------------

create materialized view mv_jg_ghrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--40008 挂户人口数
select f.jgbm, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and a.RKLX = 621
 group by f.jgbm;
 
 
--2014
--闲散青少年
create materialized view MV_JG_xsqsn_AGG nologging
build immediate
refresh fast on demand
disable query rewrite
as
 select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,xz_xsqsn r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

-- 艾滋病患者
create materialized view MV_JG_azbhz_AGG nologging
build immediate
refresh fast on demand
disable query rewrite
as
 select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,xz_azbhz r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

--信访重点人员 
create materialized view MV_JG_xfzdry_AGG nologging
build immediate
refresh fast on demand
disable query rewrite
AS
 select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_xfzdry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;
 
--宗教信仰信息 
create materialized view MV_JG_zjxyxx_AGG  nologging
build immediate
refresh fast on demand
disable query rewrite
as
select f.jgbm, count(a.cyid) num,count(*) cnt
from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_zjxyxx r
where a.JGID = f.jgid
and a.CYID = r.CYID
group by f.jgbm;

--留守儿童
create materialized view MV_JG_lset_AGG nologging
build immediate
refresh fast on demand
disable query rewrite
AS
 select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,xz_lset r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

--留守妇女 
create materialized view MV_JG_lsfn_AGG  nologging
build immediate
refresh fast on demand
disable query rewrite
AS
 select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_lsfn r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;

--两新组织中  的社会团体 2014 lzqiang  添加
create materialized view MV_JG_lxzz_shtt_AGG  nologging
build immediate
refresh fast on demand
disable query rewrite
AS
 select f.jgbm, count(r.org_id) num,count(*) cnt
  FROM XT_ORG r,SYS_JGXXB f
 WHERE r.reseau = f.jgid
 AND r.Lb = 200021 --社会团体
 group by f.jgbm; 
 
--两新组织中  民办企业非单位 2014 lzqiang  添加
create materialized view MV_JG_lxzz_mbqyfdw_AGG  nologging
build immediate
refresh fast on demand
disable query rewrite
AS
 select f.jgbm, count(r.org_id) num,count(*) cnt
  FROM XT_ORG r,SYS_JGXXB f
 WHERE r.reseau = f.jgid
 AND r.Lb = 200023 --民办企业非单位
 group by f.jgbm; 

--lzqiang 20140825 服刑人员
create materialized view MV_JG_fxry_AGG  nologging
build immediate
refresh fast on demand
disable query rewrite
AS
 select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_fxry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm;
/*
select f.jgbm, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       SYS_JGXXB    f
 where a.JGID = f.jgid
   and a.RKLX = 621
 group by f.jgbm;
*/
----------------------------------------------------------------------------------------
                    --新统计指标物化视图 End
----------------------------------------------------------------------------------------
/*
level0物化视图的日志创建
*/

create materialized view log on mv_jg_xq_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_ld_agg  nologging with  rowid,sequence (jgbm,num) including new values; 
create materialized view log on mv_jg_jjly_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_ldrk_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_kp_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_zzrk_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_ylfn_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_czrk_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_lrrk_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_hjrk_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_csrk_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_dbh_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_kch_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_szbj_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_jyfw_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_cjry_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_flgry_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_xsjjry_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_txxx_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_czcsry_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_ybsb_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_cxyljz_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_jjjz_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_scjr_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_tsrq_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_xytyry_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_jkxxjc_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_bfwwxx_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_jyqkxx_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_fzxczyz_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_sqjzry_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_sjzdry_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_xdry_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_wxjsbry_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_zdqsnry_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_rmtjy_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_ldlzxxy_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_zjxy_agg  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_yfdxwh_agg  nologging with  rowid,sequence (jgbm,num) including new values;

create materialized view log on mv_jg_zhs_agg nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_fqydw_agg nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_shtt_agg nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_tjhzinfo_agg nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_fxpginfo_agg nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_yjsjinfo_agg nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_jbxx_agg nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_wzxx_agg nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on mv_jg_ghrk_agg nologging with  rowid,sequence (jgbm,num) including new values;

--2014
create materialized view log on MV_JG_xsqsn_AGG  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on MV_JG_azbhz_AGG  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on MV_JG_xfzdry_AGG  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on MV_JG_zjxyxx_AGG  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on MV_JG_lset_AGG  nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on MV_JG_lsfn_AGG  nologging with  rowid,sequence (jgbm,num) including new values;
--gaobin 20140812
create materialized view log on mv_jg_dy_agg nologging with  rowid,sequence (jgbm,num) including new values;
--lzqiang 20140825
create materialized view log on MV_JG_lxzz_shtt_AGG nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on MV_JG_lxzz_mbqyfdw_AGG nologging with  rowid,sequence (jgbm,num) including new values;
create materialized view log on MV_JG_fxry_AGG nologging with  rowid,sequence (jgbm,num) including new values;
/*
创建机构汇总物化视图
*/
create materialized view mv_jg_dataid nologging
build immediate
refresh fast on demand
disable query rewrite
as
(--6148  小区数量
select b.jgid,b.jgbm,6148 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_xq_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6149  楼栋数量
select b.jgid,b.jgbm,6149 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_ld_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all 
--6150  经济楼宇数量
select b.jgid,b.jgbm,6150 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_jjly_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all 
--6151  流动人口数量
select b.jgid,b.jgbm,6151 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_ldrk_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6152  卡片数
select b.jgid,b.jgbm,6152 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_kp_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6153  在住人口数
select b.jgid,b.jgbm,6153 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_zzrk_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all 
--6154  育龄妇女数
select b.jgid,b.jgbm,6154 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_ylfn_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6155  常住人口数
select b.jgid,b.jgbm,6155 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_czrk_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6156  流入人口数
select b.jgid,b.jgbm,6156 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_lrrk_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all 
--6157  户籍人口数
select b.jgid,b.jgbm,6157 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_hjrk_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6158  出生人口数
select b.jgid,b.jgbm,6158 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_csrk_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6159  低保户
select b.jgid,b.jgbm,6159 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_dbh_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6160  空巢户
select b.jgid,b.jgbm,6160 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_kch_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6168  生殖保健
select b.jgid,b.jgbm,6168 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_szbj_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6169  就业服务
select b.jgid,b.jgbm,6169 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_jyfw_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6170  残疾人员
select b.jgid,b.jgbm,6170 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_cjry_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6171  法轮功人员信息
select b.jgid,b.jgbm,6171 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_flgry_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6172  刑释解教人员信息
select b.jgid,b.jgbm,6172 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_xsjjry_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6173  退休信息
select b.jgid,b.jgbm,6173 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_txxx_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6174  参战参试
select b.jgid,b.jgbm,6174 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_czcsry_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6175  医保社保
select b.jgid,b.jgbm,6175 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_ybsb_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6176  城乡医疗
select b.jgid,b.jgbm,6176 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_cxyljz_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6177  救灾救济
select b.jgid,b.jgbm,6177 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_jjjz_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6178  伤残军人
select b.jgid,b.jgbm,6178 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_scjr_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6179  特殊人群
select b.jgid,b.jgbm,6179 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_tsrq_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6180  现役退役
select b.jgid,b.jgbm,6180 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_xytyry_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6181  健康检查
select b.jgid,b.jgbm,6181 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_jkxxjc_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6182  帮扶慰问
select b.jgid,b.jgbm,6182 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_bfwwxx_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6183  教育情况
select b.jgid,b.jgbm,6183 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_jyqkxx_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6184  法制宣传志愿者
select b.jgid,b.jgbm,6184 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_fzxczyz_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6185  社区矫正人员
select b.jgid,b.jgbm,6185 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_sqjzry_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6186  涉军重点人员
select b.jgid,b.jgbm,6186 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_sjzdry_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6187  吸毒人员
select b.jgid,b.jgbm,6187 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_xdry_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6188  危险精神病人员
select b.jgid,b.jgbm,6188 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_wxjsbry_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6189  重点青少年人员
select b.jgid,b.jgbm,6189 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_zdqsnry_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6190  人民调解员
select b.jgid,b.jgbm,6190 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_rmtjy_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6191  楼栋长信息员
select b.jgid,b.jgbm,6191 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_ldlzxxy_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6192  宗教信仰信息
select b.jgid,b.jgbm,6192 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_zjxy_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--6193  优抚对象信息
select b.jgid,b.jgbm,6193 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_yfdxwh_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--16248  物资信息
select b.jgid,b.jgbm,16248 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_wzxx_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--16249  信访事件
select b.jgid,b.jgbm,16249 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_jbxx_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--16250  公共应急事件
select b.jgid,b.jgbm,16250 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_yjsjinfo_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--16251  风险评估事件
select b.jgid,b.jgbm,16251 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_fxpginfo_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--16252  大调解事件
select b.jgid,b.jgbm,16252 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_tjhzinfo_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--16268  社会团体
select b.jgid,b.jgbm,16268 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_shtt_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--16269  非企业单位
select b.jgid,b.jgbm,16269 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_fqydw_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--16288  总户数
select b.jgid,b.jgbm,16288 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_zhs_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--40008 挂户人口数
select b.jgid,b.jgbm,40008 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_ghrk_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--60000 闲散青少年
select b.jgid,b.jgbm,60000 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from MV_JG_xsqsn_AGG a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--60001 艾滋病患者
select b.jgid,b.jgbm,60001 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from MV_JG_azbhz_AGG a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--60002 信访重点人员
select b.jgid,b.jgbm,60002 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from MV_JG_xfzdry_AGG a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--60003 宗教信仰人员
select b.jgid,b.jgbm,60003 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from MV_JG_zjxyxx_AGG a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--60004 
select b.jgid,b.jgbm,60004 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from MV_JG_lset_AGG a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--60005 留守妇女
select b.jgid,b.jgbm,60005 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from MV_JG_lsfn_AGG a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--30919  党员信息
select b.jgid,b.jgbm,30919 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_dy_agg a,mv_jg_info b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--30939  社会团体(两新组织)
select b.jgid,b.jgbm,30939 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_dy_agg a,MV_JG_lxzz_shtt_AGG b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--30940  民办企业非单位(两新组织)
select b.jgid,b.jgbm,30940 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_dy_agg a,MV_JG_lxzz_mbqyfdw_AGG b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
union all
--30941  服刑人员
select b.jgid,b.jgbm,30941 dataid,sum(num) num,2 bs,count(num) cntn,count(*) cnt from mv_jg_dy_agg a,MV_JG_fxry_AGG b where regexp_like(a.jgbm,b.jgbm) group by b.jgid,b.jgbm
);
----------------------------------------------------------------------------------------
--机构类统计指标物化视图 End
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--责任人类统计指标物化视图 Begin
----------------------------------------------------------------------------------------
-------------------
create materialized view mv_zrr_dy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--30919  党员信息
select f.ZRRUSERID, count(*) num
  from QYXX_KPRYGLB a, QYXX_CPJTXX e, sys_ldwhb f,SYS_USERINFO g
 where a.cyid=e.cyid
       and a.ldid=f.ldid
       and f.ZRRUSERID = g.userid
       and e.zzmm = 43
   group by f.ZRRUSERID;


create materialized view mv_zrr_xq_base nologging
build immediate
refresh fast on demand
disable query rewrite
as
select p.zrruserid, t.xqid,count(*) cnt
  from sys_ldwhb p, sys_xqxxb t
 where p.xqid = t.xqid
 group by p.zrruserid, t.xqid;
create materialized view log on mv_zrr_xq_base nologging with  rowid,sequence (zrruserid,xqid) including new values;

create materialized view mv_zrr_xq_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6148  小区数量
select a.zrruserid, count(a.xqid) num,count(*) cnt
  from mv_zrr_xq_base a 
 group by a.zrruserid;

-------------------------

create materialized view mv_zrr_ld_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6149  楼栋数量
select z.zrruserid, count(z.ldid) num, count(*) cnt
  from SYS_LDWHB z
 where z.ldlx = 282
 group by z.zrruserid;

 
create materialized view mv_zrr_jjly_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6150  经济楼宇数量
select z.zrruserid, count(z.ldid) num, count(*) cnt
  from SYS_LDWHB z
 where z.ldlx <> 282
 group by z.zrruserid;

create materialized view mv_zrr_ldrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6151  流动人口数量
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and a.RKLX in (20, 21)
 group by c.ZRRUSERID;
/*
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       SYS_LDWHB    c
 where a.LDID = c.LDID
   and a.RKLX in (20, 21)
 group by c.ZRRUSERID;
*/
create materialized view mv_zrr_kp_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6152  卡片数
select b.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPXXB a, SYS_LDWHB b, SYS_XQXXB c, SYS_JGXXB d, SYS_USERINFO e
 where a.LDHM = b.ldid
   and b.JGID = d.jgid
   and b.XQID = c.xqid
   and b.ZRRUSERID = e.userid
 group by b.ZRRUSERID;
/*
select b.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPXXB a, SYS_LDWHB b
 where a.LDHM = b.ldid
 group by b.ZRRUSERID;
*/
create materialized view mv_zrr_zzrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6153  在住人口数
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and a.KPXXID is not null
 group by c.ZRRUSERID;
/*
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       SYS_LDWHB    c
 where a.LDID = c.LDID
   and a.KPXXID is not null
 group by c.ZRRUSERID;
*/
create materialized view mv_zrr_ylfn_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6154  育龄妇女数
select c.ZRRUSERID, count(*) num
  from YLFN_YLFNJBXX q,
       QYXX_KPRYGLB  a,
       SYS_JGXXB     b,
       SYS_LDWHB     c,
       QYXX_KPXXB    f,
       QYXX_CPJTXX   g
 where a.KPXXID = f.KPXXID
   and f.LDHM = c.LDID
   and b.jgid = c.jgid
   and a.CYID = g.CYID
   and q.YLZD4 = a.GUANLIID
 group by c.ZRRUSERID;
/*
select c.ZRRUSERID, count(*) num
  from YLFN_YLFNJBXX q,
       QYXX_KPRYGLB  a,
       SYS_LDWHB     c
 where a.LDID = c.LDID
   and q.YLZD4 = a.GUANLIID
 group by c.ZRRUSERID;
*/
create materialized view mv_zrr_czrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6155  常住人口数
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and a.RKLX = 19
 group by c.ZRRUSERID;
/*
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       SYS_LDWHB    c
 where a.LDID = c.LDID
   and a.RKLX = 19
 group by c.ZRRUSERID;
*/
create materialized view mv_zrr_lrrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6156  流入人口数
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and a.RKLX = 21
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_hjrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6157  户籍人口数
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and e.HJXXDZ = c.JGID
 group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_csrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6158  出生人口数
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g,
       sys_time t
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and to_char(e.CSNY, 'yyyy') = t.cur_year
 group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_dbh_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6159  低保户
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               QYXX_DJWBRY  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_kch_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6160  空巢户
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               QYXX_KCXX  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_szbj_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6168  生殖保健
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_cyszbjxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_jyfw_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6169  就业服务
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_jyfwxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_cjry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6170  残疾人员
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_cjry  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_flgry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6171  法轮功人员信息
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               wqww_flgry  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_xsjjry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6172  刑释解教人员信息
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               wqww_xsjjry  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_txxx_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6173  退休信息
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_txxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_czcsry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6174  参战参试
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_czcsry  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_ybsb_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6175  医保社保
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_ybsbxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_cxyljz_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6176  城乡医疗
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_cxyljz  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_jjjz_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6177  救灾救济
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_jjjzxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_scjr_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6178  伤残军人
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_scjrxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_tsrq_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6179  特殊人群
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g,
       qyxx_tsrqxx  r
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and e.CYID = r.CYID
 group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_xytyry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6180  现役退役
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g,
       qyxx_xytyry  r
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and e.CYID = r.CYID
 group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_jkxxjc_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6181  健康检查
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_jkxxjc  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_bfww_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6182  帮扶慰问
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_bfwwxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_jyqk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6183  教育情况
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_jyqkxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_fzxczyz_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6184  法制宣传志愿者
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               wqww_fzxczyz  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_sqjzry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6185  社区矫正人员
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               wqww_sqjzry  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_sjzdry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6186  涉军重点人员
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_sjzdryxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_xdry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6187  吸毒人员
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_xdryxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_wxjsbry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6188  危险精神病人员
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_wxjsbryxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_zdqsnry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6189  重点青少年人员
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_zdqsnryxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_rmtjy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6190  人民调解员
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_rmtjy  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_ldlzxxy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6191  楼栋长信息员
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_ldlzxxy  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_zjxy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6192  宗教信仰信息
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_zjxyxx  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;
/*

*/
create materialized view mv_zrr_yfdxwh_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6193  优抚对象信息
select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
          from QYXX_KPRYGLB a,
               QYXX_KPXXB   b,
               SYS_LDWHB    c,
               SYS_XQXXB    d,
               QYXX_CPJTXX  e,
               SYS_JGXXB    f,
               SYS_USERINFO g,
               qyxx_yfdxwh  r
         where a.CYID = e.CYID
           and a.KPXXID = b.KPXXID
           and b.LDHM = c.LDID
           and c.XQID = d.xqid
           and c.JGID = f.jgid
           and c.ZRRUSERID = g.userid
           and e.CYID = r.CYID
         group by c.ZRRUSERID;

create materialized view MV_ZRR_GYS_AGG nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6194 党员数
select c.zrruserid,count(a.KPXXID) num,count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and e.zzmm = 43
 group by c.zrruserid;
----------------------------------------------------------------------------------------
                    --新统计指标物化视图 Begin
----------------------------------------------------------------------------------------
create materialized view mv_zrr_jbxx_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--16249 信访事件
select ZRRUSERID, count(JBID) num,count(*) cnt
  from ZZWW_ZXJBXX
 where SHJG = 0
 group by ZRRUSERID;
 
------------------------------------
create materialized view mv_zrr_zhs_base nologging
build immediate
refresh fast on demand
disable query rewrite
as
select b.zrruserid, a.kpxxid, nvl(a.hm, 1) hm,count(*) cnt
  from qyxx_kpryglb a, sys_ldwhb b
 where a.ldid = b.ldid
   and b.zrruserid is not null
 group by b.zrruserid, a.kpxxid,nvl(a.hm, 1);
create materialized view log on mv_zrr_zhs_base nologging with  rowid,sequence (zrruserid,kpxxid,hm) including new values;

create materialized view mv_zrr_zhs_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--16288 总户数
select zrruserid, count(hm) num,count(*) cnt
  from mv_zrr_zhs_base
 group by zrruserid;
 
--------------------------------------

create materialized view mv_zrr_ghrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--40008 挂户人口数 
select c.ZRRUSERID, count(a.KPXXID) num,count(*) cnt
  from QYXX_KPRYGLB a,
       QYXX_KPXXB   b,
       SYS_LDWHB    c,
       SYS_XQXXB    d,
       QYXX_CPJTXX  e,
       SYS_JGXXB    f,
       SYS_USERINFO g
 where a.CYID = e.CYID
   and a.KPXXID = b.KPXXID
   and b.LDHM = c.LDID
   and c.XQID = d.xqid
   and c.JGID = f.jgid
   and c.ZRRUSERID = g.userid
   and a.RKLX = 621
 group by c.ZRRUSERID;
/*

*/
----------------------------------------------------------------------------------------
                    --新统计指标物化视图 End
----------------------------------------------------------------------------------------

/*
agg物化视图视图日志创建
*/
create materialized view log on mv_zrr_xq_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_ld_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_jjly_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_ldrk_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_kp_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_zzrk_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_ylfn_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_czrk_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_lrrk_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_hjrk_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_csrk_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_dbh_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_kch_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_szbj_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_jyfw_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_cjry_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_flgry_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_xsjjry_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_txxx_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_czcsry_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_ybsb_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_cxyljz_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_jjjz_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_scjr_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_tsrq_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_xytyry_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_jkxxjc_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_bfww_agg nologging with  rowid,sequence (zrruserid,num) including new values;         
create materialized view log on mv_zrr_jyqk_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_fzxczyz_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_sqjzry_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_sjzdry_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_xdry_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_wxjsbry_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_zdqsnry_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_rmtjy_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_ldlzxxy_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_zjxy_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_yfdxwh_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_jbxx_agg nologging with  rowid,sequence (ZRRUSERID,num) including new values;
create materialized view log on mv_zrr_zhs_agg nologging with  rowid,sequence (ZRRUSERID,num) including new values;
create materialized view log on mv_zrr_ghrk_agg nologging with  rowid,sequence (zrruserid,num) including new values;
create materialized view log on mv_zrr_gys_agg nologging with  rowid,sequence (zrruserid,num) including new values;

--gaobin
create materialized view log on mv_zrr_dy_agg nologging with  rowid,sequence (ZRRUSERID,num) including new values;

alter table MV_ZRR_GHRK_AGG add constraint UN_ZRR_GHRK unique(zrruserid) using index nologging;
alter table MV_ZRR_ZHS_AGG add constraint UN_ZRR_ZHS unique(zrruserid) using index nologging;
alter table MV_ZRR_JBXX_AGG add constraint UN_ZRR_JBXX unique(zrruserid) using index nologging;
alter table MV_ZRR_YFDXWH_AGG add constraint UN_ZRR_YFDXWH unique(zrruserid) using index nologging;
alter table MV_ZRR_ZJXY_AGG add constraint UN_ZRR_ZJXY unique(zrruserid) using index nologging;
alter table MV_ZRR_LDLZXXY_AGG add constraint UN_ZRR_LDLZXXY unique(zrruserid) using index nologging;
alter table MV_ZRR_RMTJY_AGG add constraint UN_ZRR_RMTJY unique(zrruserid)  using index nologging;
alter table MV_ZRR_ZDQSNRY_AGG add constraint UN_ZRR_ZDQSNRY unique(zrruserid)  using index nologging;
alter table MV_ZRR_WXJSBRY_AGG add constraint UN_ZRR_WXJSBRY unique(zrruserid)  using index nologging;
alter table MV_ZRR_XDRY_AGG add constraint UN_ZRR_XDRY unique(zrruserid)  using index nologging;
alter table MV_ZRR_SJZDRY_AGG add constraint UN_ZRR_SJZDRY unique(zrruserid)  using index nologging;
alter table MV_ZRR_SQJZRY_AGG add constraint UN_ZRR_SQJZRY unique(zrruserid)  using index nologging;
alter table MV_ZRR_FZXCZYZ_AGG add constraint UN_ZRR_FZXCZYZ unique(zrruserid)  using index nologging;
alter table MV_ZRR_JYQK_AGG add constraint UN_ZRR_JYQK unique(zrruserid)  using index nologging;
alter table MV_ZRR_BFWW_AGG add constraint UN_ZRR_BFWW unique(zrruserid)  using index nologging;
alter table MV_ZRR_JKXXJC_AGG add constraint UN_ZRR_JKXXJC unique(zrruserid)  using index nologging;
alter table MV_ZRR_XYTYRY_AGG add constraint UN_ZRR_XYTYRY unique(zrruserid)  using index nologging;
alter table MV_ZRR_TSRQ_AGG add constraint UN_ZRR_TSRQ unique(zrruserid)  using index nologging;
alter table MV_ZRR_JJJZ_AGG add constraint UN_ZRR_JJJZ unique(zrruserid)  using index nologging;
alter table MV_ZRR_CXYLJZ_AGG add constraint UN_ZRR_CXYLJZ unique(zrruserid)  using index nologging;
alter table MV_ZRR_SCJR_AGG add constraint UN_ZRR_SCJR unique(zrruserid)  using index nologging;
alter table MV_ZRR_YBSB_AGG add constraint UN_ZRR_YBSB unique(zrruserid)  using index nologging;
alter table MV_ZRR_CZCSRY_AGG add constraint UN_ZRR_CZCSRY unique(zrruserid)  using index nologging;
alter table MV_ZRR_TXXX_AGG add constraint UN_ZRR_TXXX unique(zrruserid)  using index nologging;
alter table MV_ZRR_XSJJRY_AGG add constraint UN_ZRR_XSJJRY unique(zrruserid)  using index nologging;
alter table MV_ZRR_FLGRY_AGG add constraint UN_ZRR_FLGRY unique(zrruserid)  using index nologging;
alter table MV_ZRR_CJRY_AGG add constraint UN_ZRR_CJRY unique(zrruserid)  using index nologging;
alter table MV_ZRR_JYFW_AGG add constraint UN_ZRR_JYFW unique(zrruserid)  using index nologging;
alter table MV_ZRR_SZBJ_AGG add constraint UN_ZRR_SZBJ unique(zrruserid)  using index nologging;
alter table MV_ZRR_KCH_AGG add constraint UN_ZRR_KCH unique(zrruserid)  using index nologging;
alter table MV_ZRR_DBH_AGG add constraint UN_ZRR_DBH unique(zrruserid)  using index nologging;
alter table MV_ZRR_CSRK_AGG add constraint UN_ZRR_CSRK unique(zrruserid)  using index nologging;
alter table MV_ZRR_HJRK_AGG add constraint UN_ZRR_HJRK unique(zrruserid)  using index nologging;
alter table MV_ZRR_LRRK_AGG add constraint UN_ZRR_LRRK unique(zrruserid)  using index nologging;
alter table MV_ZRR_CZRK_AGG add constraint UN_ZRR_CZRK unique(zrruserid)  using index nologging;
alter table MV_ZRR_YLFN_AGG add constraint UN_ZRR_YLFN unique(zrruserid)  using index nologging;
alter table MV_ZRR_ZZRK_AGG add constraint UN_ZRR_ZZRK unique(zrruserid)  using index nologging;
alter table MV_ZRR_KP_AGG add constraint UN_ZRR_KP unique(zrruserid)  using index nologging;
alter table MV_ZRR_LDRK_AGG add constraint UN_ZRR_LDRK unique(zrruserid)  using index nologging;
alter table MV_ZRR_JJLY_AGG add constraint UN_ZRR_JJLY unique(zrruserid)  using index nologging;
alter table MV_ZRR_LD_AGG add constraint UN_ZRR_LD unique(zrruserid)  using index nologging;
alter table MV_ZRR_XQ_AGG add constraint UN_ZRR_XQ unique(zrruserid)  using index nologging;
alter table MV_ZRR_GYS_AGG add constraint UN_ZRR_GYS unique(zrruserid)  using index nologging;

--gaobin
alter table mv_zrr_dy_agg add constraint un_zrr_dy unique(ZRRUSERID)  using index nologging;

/*
创建责任人汇总物化视图
*/
create materialized view mv_zrr_dataid nologging
build immediate
refresh fast on demand
disable query rewrite
as
(--6148  小区数量
select a.userid,6148 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_xq_agg b where a.userid = b.zrruserid(+)
union all
--6149  楼栋数量
select a.userid,6149 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_ld_agg b where a.userid = b.zrruserid(+)
union all 
--6150  经济楼宇数量
select a.userid,6150 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_jjly_agg b where a.userid = b.zrruserid(+)
union all 
--6151  流动人口数量
select a.userid,6151 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_ldrk_agg b where a.userid = b.zrruserid(+)
union all
--6152  卡片数
select a.userid,6152 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_kp_agg b where a.userid = b.zrruserid(+)
union all
--6153  在住人口数
select a.userid,6153 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_zzrk_agg b where a.userid = b.zrruserid(+)
union all 
--6154  育龄妇女数
select a.userid,6154 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_ylfn_agg b where a.userid = b.zrruserid(+)
union all
--6155  常住人口数
select a.userid,6155 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_czrk_agg b where a.userid = b.zrruserid(+)
union all
--6156  流入人口数
select a.userid,6156 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_lrrk_agg b where a.userid = b.zrruserid(+)
union all 
--6157  户籍人口数
select a.userid,6157 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_hjrk_agg b where a.userid = b.zrruserid(+)
union all
--6158  出生人口数
select a.userid,6158 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_csrk_agg b where a.userid = b.zrruserid(+)
union all
--6159  低保户
select a.userid,6159 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_dbh_agg b where a.userid = b.zrruserid(+)
union all
--6160  空巢户
select a.userid,6160 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_kch_agg b where a.userid = b.zrruserid(+)
union all
--6168  生殖保健
select a.userid,6168 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_szbj_agg b where a.userid = b.zrruserid(+)
union all
--6169  就业服务
select a.userid,6169 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_jyfw_agg b where a.userid = b.zrruserid(+)
union all
--6170  残疾人员
select a.userid,6170 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_cjry_agg b where a.userid = b.zrruserid(+)
union all
--6171  法轮功人员信息
select a.userid,6171 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_flgry_agg b where a.userid = b.zrruserid(+)
union all
--6172  刑释解教人员信息
select a.userid,6172 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_xsjjry_agg b where a.userid = b.zrruserid(+)
union all
--6173  退休信息
select a.userid,6173 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_txxx_agg b where a.userid = b.zrruserid(+)
union all
--6174  参战参试
select a.userid,6174 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_czcsry_agg b where a.userid = b.zrruserid(+)
union all
--6175  医保社保
select a.userid,6175 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_ybsb_agg b where a.userid = b.zrruserid(+)
union all
--6176  城乡医疗
select a.userid,6176 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_cxyljz_agg b where a.userid = b.zrruserid(+)
union all
--6177  救灾救济
select a.userid,6177 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_jjjz_agg b where a.userid = b.zrruserid(+)
union all
--6178  伤残军人
select a.userid,6178 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_scjr_agg b where a.userid = b.zrruserid(+)
union all
--6179  特殊人群
select a.userid,6179 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_tsrq_agg b where a.userid = b.zrruserid(+)
union all
--6180  现役退役
select a.userid,6180 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_xytyry_agg b where a.userid = b.zrruserid(+)
union all
--6181  健康检查
select a.userid,6181 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_jkxxjc_agg b where a.userid = b.zrruserid(+)
union all
--6182  帮扶慰问
select a.userid,6182 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_bfww_agg b where a.userid = b.zrruserid(+)
union all
--6183  教育情况
select a.userid,6183 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_jyqk_agg b where a.userid = b.zrruserid(+)
union all
--6184  法制宣传志愿者
select a.userid,6184 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_fzxczyz_agg b where a.userid = b.zrruserid(+)
union all
--6185  社区矫正人员
select a.userid,6185 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_sqjzry_agg b where a.userid = b.zrruserid(+)
union all
--6186  涉军重点人员
select a.userid,6186 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_sjzdry_agg b where a.userid = b.zrruserid(+)
union all
--6187  吸毒人员
select a.userid,6187 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_xdry_agg b where a.userid = b.zrruserid(+)
union all
--6188  危险精神病人员
select a.userid,6188 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_wxjsbry_agg b where a.userid = b.zrruserid(+)
union all
--6189  重点青少年人员
select a.userid,6189 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_zdqsnry_agg b where a.userid = b.zrruserid(+)
union all
--6190  人民调解员
select a.userid,6190 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_rmtjy_agg b where a.userid = b.zrruserid(+)
union all
--6191  楼栋长信息员
select a.userid,6191 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_ldlzxxy_agg b where a.userid = b.zrruserid(+)
union all
--6192  宗教信仰信息
select a.userid,6192 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_zjxy_agg b where a.userid = b.zrruserid(+)
union all
--6193  优抚对象信息
select a.userid,6193 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_yfdxwh_agg b where a.userid = b.zrruserid(+)
union all
--6194  党员数
select a.userid,6194 dataid, nvl(b.num,0) num,1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_gys_agg b where a.userid = b.zrruserid(+)
union all
--16249 信访事件
select a.userid, 16249 dataid, nvl(b.num,0) num, 1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_jbxx_agg b where a.userid = b.zrruserid(+)
union all
--16288 总户数
select a.userid, 16288 dataid, nvl(b.num,0) num, 1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_zhs_agg b where a.userid = b.zrruserid(+)
union all
--40008 挂户人口数 
select a.userid, 40008 dataid, nvl(b.num,0) num, 1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_ghrk_agg b where a.userid = b.zrruserid(+)
union all
--30919党员数 
select a.userid, 30919 dataid, nvl(b.num,0) num, 1 bs, a.rowid zrr_rid, b.rowid ld_rid from mv_zrr_info a, mv_zrr_dy_agg b where a.userid = b.zrruserid(+)

);
----------------------------------------------------------------------------------------
--责任人类统计指标物化视图 End
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--楼栋类统计指标物化视图 Begin
----------------------------------------------------------------------------------------
--6148  小区数量
--6149  楼栋数量
--6150  经济楼宇数量

create materialized view mv_ld_ldrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6151  流动人口数量
select a.ldid, count(a.kpxxid) num,count(*) cnt
  from qyxx_kpryglb a
 where a.RKLX in (20, 21)
 group by a.ldid;

create materialized view mv_ld_kp_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6152  卡片数
select b.ldid, count(KPXXID) num,count(*) cnt
  from QYXX_KPXXB a, SYS_LDWHB b
 where a.LDHM = b.ldid
 group by b.ldid;

create materialized view mv_ld_zzrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6153  在住人口数
select a.ldid, count(a.kpxxid) num,count(*) cnt
  from qyxx_kpryglb a
 group by a.ldid;
 
create materialized view mv_ld_lyfn_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6154  育龄妇女数
select a.ldid, count(*) num,count(*) cnt
  from YLFN_YLFNJBXX q, QYXX_KPRYGLB a
 where q.YLZD4 = a.GUANLIID
 group by a.ldid;

create materialized view mv_ld_czrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6155  常住人口数
select a.ldid, count(a.KPXXID) num,count(*) cnt
  from QYXX_KPRYGLB a
 where a.RKLX = 19
 group by a.ldid;
 
create materialized view mv_ld_lrrk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6156  流入人口数
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a
 where a.RKLX = 21
 group by a.ldid;
 
--6157  户籍人口数
--6158  出生人口数

create materialized view mv_ld_dbh_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6159  低保户
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,QYXX_DJWBRY r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_kch_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6160  空巢户
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,QYXX_KCXX r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_szbj_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6168  生殖保健
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_cyszbjxx r
 where a.CYID = r.CYID
 group by a.ldid;
 
create materialized view mv_ld_jyfw_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6169  就业服务
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_jyfwxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_cjry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6170  残疾人员
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_cjry r
 where a.CYID = r.CYID
 group by a.ldid;
 
create materialized view mv_ld_flgry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6171  法轮功人员信息
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,wqww_flgry r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_xsjjry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6172  刑释解教人员信息
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,wqww_xsjjry r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_txxx_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6173  退休信息
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_txxx r
 where a.CYID = r.CYID
 group by a.ldid;
 
create materialized view mv_ld_czcsry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6174  参战参试
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_czcsry r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_ybsb_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6175  医保社保
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_ybsbxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_cxyljz_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6176  城乡医疗
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_cxyljz r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_jjjz_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6177  救灾救济
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_jjjzxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_scjr_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6178  伤残军人
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_scjrxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_tsrq_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6179  特殊人群
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_tsrqxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_xytyry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6180  现役退役
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_xytyry r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_jkxxjc_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6181  健康检查
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_jkxxjc r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_bfww_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6182  帮扶慰问
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_bfwwxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_jyqk_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6183  教育情况
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_jyqkxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_fzxczyz_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6184  法制宣传志愿者
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,wqww_fzxczyz r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_sqjzry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6185  社区矫正人员
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,wqww_sqjzry r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_sjzdry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6186  涉军重点人员
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_sjzdryxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_xdry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6187  吸毒人员
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_xdryxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_wxjsbry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6188  危险精神病人员
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_wxjsbryxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_zdqsnry_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6189  重点青少年人员
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_zdqsnryxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_rmtjy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6190  人民调解员
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_rmtjy r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_ldlzxxy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6191  楼栋长信息员
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_ldlzxxy r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_zjxy_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6192  宗教信仰信息
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_zjxyxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view mv_ld_yfdxwh_agg nologging
build immediate
refresh fast on demand
disable query rewrite
as
--6193  优抚对象信息
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_yfdxwh r
 where a.CYID = r.CYID
 group by a.ldid;

 --2014
create materialized view MV_LD_xsqsn_AGG nologging
build immediate
refresh fast on demand
disable query rewrite
as
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,xz_xsqsn  r
 where a.CYID = r.CYID
 group by a.ldid;
 
create materialized view MV_LD_azbhz_AGG nologging
build immediate
refresh fast on demand
disable query rewrite
as
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,xz_azbhz   r
 where a.CYID = r.CYID
 group by a.ldid;
 
create materialized view MV_LD_xfzdry_AGG nologging
build immediate
refresh fast on demand
disable query rewrite
as
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_xfzdry    r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view MV_LD_zjxyxx_AGG nologging
build immediate
refresh fast on demand
disable query rewrite
as
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_zjxyxx r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view MV_LD_lset_AGG  nologging
build immediate
refresh fast on demand
disable query rewrite
as
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,xz_lset  r
 where a.CYID = r.CYID
 group by a.ldid;

create materialized view MV_LD_lsfn_AGG nologging
build immediate
refresh fast on demand
disable query rewrite
as
select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_lsfn   r
 where a.CYID = r.CYID
 group by a.ldid;

/*
agg物化视图视图日志创建
*/
create materialized view log on mv_ld_ldrk_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_kp_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_zzrk_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_lyfn_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_czrk_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_lrrk_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_dbh_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_kch_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_szbj_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_jyfw_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_cjry_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_flgry_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_xsjjry_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_txxx_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_czcsry_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_ybsb_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_cxyljz_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_jjjz_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_scjr_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_tsrq_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_xytyry_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_jkxxjc_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_bfww_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_jyqk_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_fzxczyz_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_sqjzry_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_sjzdry_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_xdry_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_wxjsbry_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_zdqsnry_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_rmtjy_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_ldlzxxy_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_zjxy_agg nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on mv_ld_yfdxwh_agg nologging with  rowid,sequence (ldid,num) including new values;

--2014
create materialized view log on MV_LD_xsqsn_AGG nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on MV_LD_azbhz_AGG nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on MV_LD_xfzdry_AGG nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on MV_LD_zjxyxx_AGG nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on MV_LD_lset_AGG nologging with  rowid,sequence (ldid,num) including new values;
create materialized view log on MV_LD_lsfn_AGG nologging with  rowid,sequence (ldid,num) including new values;

/*
创建楼栋汇总物化视图
*/
create materialized view mv_ld_dataid nologging
build immediate
refresh fast on demand
disable query rewrite
as
(--6151  流动人口数量
select ldid userid,6151 dataid,num,3 bs,rowid rid from mv_ld_ldrk_agg
union all
--6152  卡片数
select ldid userid,6152 dataid,num,3 bs,rowid rid from mv_ld_kp_agg
union all
--6153  在住人口数
select ldid userid,6153 dataid,num,3 bs,rowid rid from mv_ld_zzrk_agg
union all
--6154  育龄妇女数
select ldid userid,6154 dataid,num,3 bs,rowid rid from mv_ld_lyfn_agg
union all
--6155  常住人口数
select ldid userid,6155 dataid,num,3 bs,rowid rid from mv_ld_czrk_agg
union all
--6156  流入人口数
select ldid userid,6156 dataid,num,3 bs,rowid rid from mv_ld_lrrk_agg
union all
--6159  低保户
select ldid userid,6159 dataid,num,3 bs,rowid rid from mv_ld_dbh_agg
union all
--6160  空巢户
select ldid userid,6160 dataid,num,3 bs,rowid rid from mv_ld_kch_agg
union all
--6168  生殖保健
select ldid userid,6168 dataid,num,3 bs,rowid rid from mv_ld_szbj_agg
union all
--6169  就业服务
select ldid userid,6169 dataid,num,3 bs,rowid rid from mv_ld_jyfw_agg
union all
--6170  残疾人员
select ldid userid,6170 dataid,num,3 bs,rowid rid from mv_ld_cjry_agg
union all
--6171  法轮功人员信息
select ldid userid,6171 dataid,num,3 bs,rowid rid from mv_ld_flgry_agg
union all
--6172  刑释解教人员信息
select ldid userid,6172 dataid,num,3 bs,rowid rid from mv_ld_xsjjry_agg
union all
--6173  退休信息
select ldid userid,6173 dataid,num,3 bs,rowid rid from mv_ld_txxx_agg
union all
--6174  参战参试
select ldid userid,6174 dataid,num,3 bs,rowid rid from mv_ld_czcsry_agg
union all
--6175  医保社保
select ldid userid,6175 dataid,num,3 bs,rowid rid from mv_ld_ybsb_agg
union all
--6176  城乡医疗
select ldid userid,6176 dataid,num,3 bs,rowid rid from mv_ld_cxyljz_agg
union all
--6177  救灾救济
select ldid userid,6177 dataid,num,3 bs,rowid rid from mv_ld_jjjz_agg
union all
--6178  伤残军人
select ldid userid,6178 dataid,num,3 bs,rowid rid from mv_ld_scjr_agg
union all
--6179  特殊人群
select ldid userid,6179 dataid,num,3 bs,rowid rid from mv_ld_tsrq_agg
union all
--6180  现役退役
select ldid userid,6180 dataid,num,3 bs,rowid rid from mv_ld_xytyry_agg
union all
--6181  健康检查
select ldid userid,6181 dataid,num,3 bs,rowid rid from mv_ld_jkxxjc_agg
union all
--6182  帮扶慰问
select ldid userid,6182 dataid,num,3 bs,rowid rid from mv_ld_bfww_agg
union all
--6183  教育情况
select ldid userid,6183 dataid,num,3 bs,rowid rid from mv_ld_jyqk_agg
union all
--6184  法制宣传志愿者
select ldid userid,6184 dataid,num,3 bs,rowid rid from mv_ld_fzxczyz_agg
union all
--6185  社区矫正人员
select ldid userid,6185 dataid,num,3 bs,rowid rid from mv_ld_sqjzry_agg
union all
--6186  涉军重点人员
select ldid userid,6186 dataid,num,3 bs,rowid rid from mv_ld_sjzdry_agg
union all
--6187  吸毒人员
select ldid userid,6187 dataid,num,3 bs,rowid rid from mv_ld_xdry_agg
union all
--6188  危险精神病人员
select ldid userid,6188 dataid,num,3 bs,rowid rid from mv_ld_wxjsbry_agg
union all
--6189  重点青少年人员
select ldid userid,6189 dataid,num,3 bs,rowid rid from mv_ld_zdqsnry_agg
union all
--6190  人民调解员
select ldid userid,6190 dataid,num,3 bs,rowid rid from mv_ld_rmtjy_agg
union all
--6191  楼栋长信息员
select ldid userid,6191 dataid,num,3 bs,rowid rid from mv_ld_ldlzxxy_agg
union all
--6192  宗教信仰信息
select ldid userid,6192 dataid,num,3 bs,rowid rid from mv_ld_zjxy_agg
union all
--6193  优抚对象信息
select ldid userid,6193 dataid,num,3 bs,rowid rid from mv_ld_yfdxwh_agg
union all
--60000 闲散青少年
select ldid userid,60000 dataid,num,3 bs,rowid rid from MV_LD_xsqsn_AGG
union all
--60001 艾滋病患者
select ldid userid,60001 dataid,num,3 bs,rowid rid from MV_LD_azbhz_AGG
union all
--60002 信访重点人员
select ldid userid,60002 dataid,num,3 bs,rowid rid from MV_LD_xfzdry_AGG
union all
--60003 宗教信仰人员
select ldid userid,60003 dataid,num,3 bs,rowid rid from MV_LD_zjxyxx_AGG
union all
--60004 留守儿童
select ldid userid,60004 dataid,num,3 bs,rowid rid from MV_LD_lset_AGG
union all
--60005 留守妇女
select ldid userid,60005 dataid,num,3 bs,rowid rid from MV_LD_lsfn_AGG
);
----------------------------------------------------------------------------------------
--楼栋类统计指标物化视图 End
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--预警和通报类统计指标物化视图 Begin
----------------------------------------------------------------------------------------
--创建临时表
create global temporary table temp_tbyj_dataid
(jgid number,
 jgbm varchar2(25),
 dataid number,
 num number,
 bs number,
 refresh_time date)
on commit preserve rows;
--创建结果表
create table tjxx_tbyj_dataid
(
  userid number,
  jgbm   varchar2(25),
  dataid number,
  num    number,
  bs     number,
  refresh_time date
);
/*
create materialized view mv_tbyj_110_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6208  城市110
select jg.jgid, jg.jgbm, 6208 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(cs110id) num
               from cs110 a, sys_jgxxb b
              where a.jbjgid = b.jgid
                and shr is null
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_noid_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6209  无身份证(预警提示)
select jg.jgid, jg.jgbm, 6209 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(g.cyid) num
          from qyxx_kpryglb a, sys_jgxxb b, qyxx_cpjtxx g
         where a.jgid = b.jgid
           and a.cyid = g.cyid
           and a.sfczr = 'N'
           and g.sfzh is null
         group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_szbj_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6210  生殖保健(预警提示)
select jg.jgid, jg.jgbm, 6210 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(guanliid) num
               from qyxx_kpryglb a,
                    sys_jgxxb    b,
                    sys_ldwhb    c,
                    sys_xqxxb    d,
                    sys_userinfo e,
                    qyxx_kpxxb   f,
                    qyxx_cpjtxx  g
              where a.kpxxid = f.kpxxid
                and f.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.zrruserid = e.userid
                and b.jgid = c.jgid
                and a.cyid = g.cyid
                and a.cyid in
                    (select p.cyid
                       from qyxx_cyszbjxx p
                      where 1 = 1
                        and ((p.syzlx = 265 and p.syzjhm is null and
                            months_between(sysdate, p.syzfzsj) > 4) or
                            (p.syzlx = 264 and sysj is null and
                            months_between(sysdate, p.syzfzsj) > 4)))
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_hywjg_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6211  怀孕无结果(预警提示)
select jg.jgid, jg.jgbm, 6211 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select f.jgbm, count(a.kpxxid) num
               from qyxx_kpryglb a,
                    qyxx_kpxxb   b,
                    sys_ldwhb    c,
                    sys_ldwhb    d,
                    qyxx_cpjtxx  e,
                    sys_jgxxb    f,
                    sys_userinfo g
              where a.cyid = e.cyid
                and a.kpxxid = b.kpxxid
                and b.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.jgid = f.jgid
                and c.zrruserid = g.userid
                and e.cyid in
                    (select cyid
                       from qyxx_cyszbjxx
                      where 1 = 1
                        and syjssj is null
                        and hyjg is null
                        and (sysdate - to_date(to_char(sysj, 'yyyy-MM-dd'),
                                               'yyyy-MM-dd')) > 300
                        and (sysdate - to_date(to_char(sysj, 'yyyy-MM-dd'),
                                               'yyyy-MM-dd')) < 720)
              group by f.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_dcjy_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6212  待产节育(预警提示)
select jg.jgid, jg.jgbm, 6212 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select f.jgbm, count(a.kpxxid) num
               from qyxx_kpryglb a,
                    qyxx_kpxxb   b,
                    sys_ldwhb    c,
                    sys_ldwhb    d,
                    qyxx_cpjtxx  e,
                    sys_jgxxb    f,
                    sys_userinfo g
              where a.cyid = e.cyid
                and a.kpxxid = b.kpxxid
                and b.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.jgid = f.jgid
                and c.zrruserid = g.userid
                and e.cyid in
                    (select cyid
                       from qyxx_cyszbjxx
                      where 1 = 1
                        and (syjssj is null and
                            (sysdate - to_date(to_char(sysj, 'yyyy-MM-dd'),
                                                'yyyy-MM-dd')) > 265 and
                            (sysdate - to_date(to_char(sysj, 'yyyy-MM-dd'),
                                                'yyyy-MM-dd')) < 720)
                         or (hyjg is null and syjssj is not null and
                            (sysdate - to_date(to_char(syjssj, 'yyyy-MM-dd'),
                                                'yyyy-MM-dd')) > 42 and
                            (sysdate - to_date(to_char(syjssj, 'yyyy-MM-dd'),
                                                'yyyy-MM-dd')) < 720))
              group by f.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_scjy_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6213  生产待节育(预警提示)
select jg.jgid, jg.jgbm, 6213 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select f.jgbm, count(a.kpxxid) num
               from qyxx_kpryglb a,
                    qyxx_kpxxb   b,
                    sys_ldwhb    c,
                    sys_ldwhb    d,
                    qyxx_cpjtxx  e,
                    sys_jgxxb    f,
                    sys_userinfo g
              where a.cyid = e.cyid
                and a.kpxxid = b.kpxxid
                and b.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.jgid = f.jgid
                and c.zrruserid = g.userid
                and e.cyid in
                    (select q.cyid
                       from qyxx_cyszbjxx q
                      where 1 = 1
                        and q.hyjg = 130
                        and (q.jylx is null or q.jysj is null))
              group by f.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_dyjry_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6214  待孕检人员(预警提示)
select jg.jgid, jg.jgbm, 6214 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select f.jgbm, count(a.kpxxid) num
               from qyxx_kpryglb a,
                    qyxx_kpxxb   b,
                    sys_ldwhb    c,
                    sys_ldwhb    d,
                    qyxx_cpjtxx  e,
                    sys_jgxxb    f,
                    sys_userinfo g
              where a.cyid = e.cyid
                and a.kpxxid = b.kpxxid
                and b.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.jgid = f.jgid
                and c.zrruserid = g.userid
                and e.xb = '女'
                and e.nl >= 14
                and e.nl <= 41
                and e.cyid not in (select cyid
                                     from qyxx_jkxxjc
                                    where jclx = 211
                                      and to_char(jcrq, 'yyyy-MM-dd') >= (case
                                            when extract(month from sysdate) between 3 and 8 then
                                             to_char(sysdate, 'yyyy') || '-03'
                                            else
                                             to_char(sysdate, 'yyyy') || '-09'
                                          end)
                                      and to_char(jcrq, 'yyyy-MM-dd') <= (case
                                            when extract(month from sysdate) between 3 and 8 then
                                             to_char(sysdate, 'yyyy') || '-09'
                                            else
                                             to_char(sysdate, 'yyyy') || '-12'
                                          end))
              group by f.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_dhjry_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6215  待环检人员(预警提示)
select jg.jgid, jg.jgbm, 6215 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select f.jgbm, count(a.kpxxid) num
               from qyxx_kpryglb a,
                    qyxx_kpxxb   b,
                    sys_ldwhb    c,
                    sys_ldwhb    d,
                    qyxx_cpjtxx  e,
                    sys_jgxxb    f,
                    sys_userinfo g
              where a.cyid = e.cyid
                and a.kpxxid = b.kpxxid
                and b.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.jgid = f.jgid
                and c.zrruserid = g.userid
                and e.xb = '女'
                and e.nl >= 14
                and e.nl <= 41
                and e.cyid not in
                    (select cyid
                       from qyxx_jkxxjc
                      where jclx = 212
                        and to_char(jcrq, 'yyyy-MM-dd') >= (case
                              when extract(month from sysdate) between 3 and 8 then
                               to_char(sysdate, 'yyyy') || '-06'
                              else
                               to_char(sysdate, 'yyyy') || '-12'
                            end)
                        and to_char(jcrq, 'yyyy-MM-dd') <= (case
                              when extract(month from sysdate) between 3 and 8 then
                               to_char(sysdate, 'yyyy') || '-12'
                              else
                               to_char(sysdate, 'yyyy') + 1 || '-06'
                            end))
              group by f.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

--6216  督办(综治维稳)
create materialized view mv_tbyj_zzww_jgdb1_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6216  督办(综治维稳) 部门为null
select jg.jgid, jg.jgbm, 6216 dataid, nvl(sum(num), 0) num, -1 bs
  from mv_jg_info jg
 inner join (select clsysjgxx, count(*) num
               from zzww_zxjbxx a
              where 1 = 1
                and sfdeptview = 1
                and deptid is null and (shjg in (0, 4) and
                    jbid not in (select jbid
                                    from zzww_lbjxfxx
                                   where lbbm is null
                                     and sljg in (0))
                 or jbid in (select jbid
                               from zzww_lbjxfxx
                              where lbbm is null
                                and sljg = 0))
                and ylzd2 = 1
              group by clsysjgxx) o
    on jg.jgid = o.clsysjgxx
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_zzww_jgdb2_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6216  督办(综治维稳) 部门不为null
select jg.jgid, jg.jgbm, 6216 dataid, nvl(sum(num), 0) num, o.deptid bs
  from tmp_org jg
 inner join (select clsysjgxx, deptid, count(*) num
               from zzww_zxjbxx
              where 1 = 1
                and sfdeptview = 1
                and deptid is not null and (shjg in (0, 4) and
                    jbid not in (select jbid
                                    from zzww_lbjxfxx
                                   where lbbm is not null
                                     and sljg in (0))
                 or jbid in (select jbid
                               from zzww_lbjxfxx
                              where lbbm is not null
                                and sljg = 0))
                and ylzd2 = 1
              group by clsysjgxx, deptid) o
    on jg.jgid = o.clsysjgxx
 group by jg.jgid, jg.jgbm, o.deptid;

create materialized view mv_tbyj_zzww_jgdb3_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6216  督办(综治维稳) 责任人
select z.userid, z.jgbm, 6216 dataid, nvl(num, 0) num, 1 bs
  from mv_zrr_info z
 inner join (select zrruserid, count(*) num
               from zzww_zxjbxx
              where 1 = 1
                and sfdeptview = 1
                and ylzd2 = 1
              group by zrruserid) o
    on z.userid = o.zrruserid;

--6217  待办(综治维稳)
create materialized view mv_tbyj_zzww_jgdab1_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6217  待办(综治维稳) 部门为null
select jg.jgid, jg.jgbm, 6217 dataid, nvl(sum(num), 0) num, -1 bs
  from mv_jg_info jg
 inner join (select clsysjgxx, count(*) num
               from zzww_zxjbxx a
              where 1 = 1
                and sfdeptview = 1
                and deptid is null and (shjg in (0, 4) and
                    jbid not in (select jbid
                                    from zzww_lbjxfxx
                                   where lbbm is null
                                     and sljg in (0))
                 or jbid in (select jbid
                               from zzww_lbjxfxx
                              where lbbm is null
                                and sljg = 0))
              group by clsysjgxx) o
    on jg.jgid = o.clsysjgxx
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_zzww_jgdab2_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6217  待办(综治维稳) 部门不为null
select jg.jgid, jg.jgbm, 6217 dataid, nvl(sum(num), 0) num, o.deptid bs
  from mv_jg_info jg
 inner join (select clsysjgxx, deptid, count(*) num
               from zzww_zxjbxx
              where 1 = 1
                and sfdeptview = 1
                and deptid is not null and (shjg in (0, 4) and
                    jbid not in (select jbid
                                    from zzww_lbjxfxx
                                   where lbbm is not null
                                     and sljg in (0))
                 or jbid in (select jbid
                               from zzww_lbjxfxx
                              where lbbm is not null
                                and sljg = 0))
              group by clsysjgxx, deptid) o
    on jg.jgid = o.clsysjgxx
 group by jg.jgid, jg.jgbm, o.deptid;

create materialized view mv_tbyj_zzww_jgdab3_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6217  待办(综治维稳) 责任人
select z.userid, z.jgbm, 6217 dataid, nvl(num, 0) num, 1 bs
  from mv_zrr_info z
 inner join (select zrruserid, count(*) num
               from zzww_zxjbxx
              where 1 = 1
                and sfdeptview = 1
              group by zrruserid) o
    on z.userid = o.zrruserid;

create materialized view mv_tbyj_ga_ldrk_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6218  流动人口(公安)
select jg.jgid, jg.jgbm, 6218 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from gabm_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_ga_hjrk_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6219  户籍(公安)
select jg.jgid, jg.jgbm, 6219 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(hjxgid) num
               from gabm_hjxxxg a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_mz_jiehun_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6220  结婚(民政)
select jg.jgid, jg.jgbm, 6220 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(mztbid) num
               from mzbm_mzbmtb a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_mz_lysy_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6221  收养(民政)
select jg.jgid, jg.jgbm, 6221 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(syylid) num
               from mzbm_ylsy a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_mz_lhtb_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6222  离婚(民政)
select jg.jgid, jg.jgbm, 6222 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(tbid) num
               from mzbm_lhtb a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_gs_xlldrk_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6223  营业人员(工商)
select jg.jgid, jg.jgbm, 6223 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from gsbm_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_gs_ygryrk_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6224  佣工人员(工商)
select jg.jgid, jg.jgbm, 6224 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from gsbm_ygryrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_rlzy_xlldrk_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6225  流动人员(人力资源)
select jg.jgid, jg.jgbm, 6225 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from rlzy_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

create materialized view mv_tbyj_jt_xlldrk_c nologging
build immediate
refresh complete on demand
disable query rewrite
as
--6226  流动人员(交通部门)
select jg.jgid, jg.jgbm, 6226 dataid, nvl(sum(num),0) num, 2 bs
  from mv_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from jtbm_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;
*/
--创建通报预警类指标统计存储过程
create or replace procedure sys_tbyj_dataid as
begin
  
insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6208  城市110
select jg.jgid, jg.jgbm, 6208 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(cs110id) num
               from cs110 a, sys_jgxxb b
              where a.jbjgid = b.jgid
                and shr is null
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6209  无身份证(预警提示)
select jg.jgid, jg.jgbm, 6209 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(g.cyid) num
          from qyxx_kpryglb a, sys_jgxxb b, qyxx_cpjtxx g
         where a.jgid = b.jgid
           and a.cyid = g.cyid
           and a.sfczr = 'N'
           and g.sfzh is null
         group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6210  生殖保健(预警提示)
select jg.jgid, jg.jgbm, 6210 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(guanliid) num
               from qyxx_kpryglb a,
                    sys_jgxxb    b,
                    sys_ldwhb    c,
                    sys_xqxxb    d,
                    sys_userinfo e,
                    qyxx_kpxxb   f,
                    qyxx_cpjtxx  g
              where a.kpxxid = f.kpxxid
                and f.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.zrruserid = e.userid
                and b.jgid = c.jgid
                and a.cyid = g.cyid
                and a.cyid in
                    (select p.cyid
                       from qyxx_cyszbjxx p
                      where 1 = 1
                        and ((p.syzlx = 265 and p.syzjhm is null and
                            months_between(sysdate, p.syzfzsj) > 4) or
                            (p.syzlx = 264 and sysj is null and
                            months_between(sysdate, p.syzfzsj) > 4)))
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6211  怀孕无结果(预警提示)
select jg.jgid, jg.jgbm, 6211 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select f.jgbm, count(a.kpxxid) num
               from qyxx_kpryglb a,
                    qyxx_kpxxb   b,
                    sys_ldwhb    c,
                    sys_ldwhb    d,
                    qyxx_cpjtxx  e,
                    sys_jgxxb    f,
                    sys_userinfo g
              where a.cyid = e.cyid
                and a.kpxxid = b.kpxxid
                and b.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.jgid = f.jgid
                and c.zrruserid = g.userid
                and e.cyid in
                    (select cyid
                       from qyxx_cyszbjxx
                      where 1 = 1
                        and syjssj is null
                        and hyjg is null
                        and (sysdate - to_date(to_char(sysj, 'yyyy-MM-dd'),
                                               'yyyy-MM-dd')) > 300
                        and (sysdate - to_date(to_char(sysj, 'yyyy-MM-dd'),
                                               'yyyy-MM-dd')) < 720)
              group by f.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6212  待产节育(预警提示)
select jg.jgid, jg.jgbm, 6212 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select f.jgbm, count(a.kpxxid) num
               from qyxx_kpryglb a,
                    qyxx_kpxxb   b,
                    sys_ldwhb    c,
                    sys_ldwhb    d,
                    qyxx_cpjtxx  e,
                    sys_jgxxb    f,
                    sys_userinfo g
              where a.cyid = e.cyid
                and a.kpxxid = b.kpxxid
                and b.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.jgid = f.jgid
                and c.zrruserid = g.userid
                and e.cyid in
                    (select cyid
                       from qyxx_cyszbjxx
                      where 1 = 1
                        and (syjssj is null and
                            (sysdate - to_date(to_char(sysj, 'yyyy-MM-dd'),
                                                'yyyy-MM-dd')) > 265 and
                            (sysdate - to_date(to_char(sysj, 'yyyy-MM-dd'),
                                                'yyyy-MM-dd')) < 720)
                         or (hyjg is null and syjssj is not null and
                            (sysdate - to_date(to_char(syjssj, 'yyyy-MM-dd'),
                                                'yyyy-MM-dd')) > 42 and
                            (sysdate - to_date(to_char(syjssj, 'yyyy-MM-dd'),
                                                'yyyy-MM-dd')) < 720))
              group by f.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6213  生产待节育(预警提示)
select jg.jgid, jg.jgbm, 6213 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select f.jgbm, count(a.kpxxid) num
               from qyxx_kpryglb a,
                    qyxx_kpxxb   b,
                    sys_ldwhb    c,
                    sys_ldwhb    d,
                    qyxx_cpjtxx  e,
                    sys_jgxxb    f,
                    sys_userinfo g
              where a.cyid = e.cyid
                and a.kpxxid = b.kpxxid
                and b.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.jgid = f.jgid
                and c.zrruserid = g.userid
                and e.cyid in
                    (select q.cyid
                       from qyxx_cyszbjxx q
                      where 1 = 1
                        and q.hyjg = 130
                        and (q.jylx is null or q.jysj is null))
              group by f.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6214  待孕检人员(预警提示)
select jg.jgid, jg.jgbm, 6214 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select f.jgbm, count(a.kpxxid) num
               from qyxx_kpryglb a,
                    qyxx_kpxxb   b,
                    sys_ldwhb    c,
                    sys_ldwhb    d,
                    qyxx_cpjtxx  e,
                    sys_jgxxb    f,
                    sys_userinfo g
              where a.cyid = e.cyid
                and a.kpxxid = b.kpxxid
                and b.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.jgid = f.jgid
                and c.zrruserid = g.userid
                and e.xb = '女'
                and e.nl >= 14
                and e.nl <= 41
                and e.cyid not in (select cyid
                                     from qyxx_jkxxjc
                                    where jclx = 211
                                      and to_char(jcrq, 'yyyy-MM-dd') >= (case
                                            when extract(month from sysdate) between 3 and 8 then
                                             to_char(sysdate, 'yyyy') || '-03'
                                            else
                                             to_char(sysdate, 'yyyy') || '-09'
                                          end)
                                      and to_char(jcrq, 'yyyy-MM-dd') <= (case
                                            when extract(month from sysdate) between 3 and 8 then
                                             to_char(sysdate, 'yyyy') || '-09'
                                            else
                                             to_char(sysdate, 'yyyy') || '-12'
                                          end))
              group by f.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6215  待环检人员(预警提示)
select jg.jgid, jg.jgbm, 6215 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select f.jgbm, count(a.kpxxid) num
               from qyxx_kpryglb a,
                    qyxx_kpxxb   b,
                    sys_ldwhb    c,
                    sys_ldwhb    d,
                    qyxx_cpjtxx  e,
                    sys_jgxxb    f,
                    sys_userinfo g
              where a.cyid = e.cyid
                and a.kpxxid = b.kpxxid
                and b.ldhm = c.ldid
                and c.xqid = d.xqid
                and c.jgid = f.jgid
                and c.zrruserid = g.userid
                and e.xb = '女'
                and e.nl >= 14
                and e.nl <= 41
                and e.cyid not in
                    (select cyid
                       from qyxx_jkxxjc
                      where jclx = 212
                        and to_char(jcrq, 'yyyy-MM-dd') >= (case
                              when extract(month from sysdate) between 3 and 8 then
                               to_char(sysdate, 'yyyy') || '-06'
                              else
                               to_char(sysdate, 'yyyy') || '-12'
                            end)
                        and to_char(jcrq, 'yyyy-MM-dd') <= (case
                              when extract(month from sysdate) between 3 and 8 then
                               to_char(sysdate, 'yyyy') || '-12'
                              else
                               to_char(sysdate, 'yyyy') + 1 || '-06'
                            end))
              group by f.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

--6216  督办(综治维稳)
insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6216  督办(综治维稳) 部门为null
select jg.jgid, jg.jgbm, 6216 dataid, nvl(sum(num), 0) num, -1 bs,sysdate
  from mv_jg_info jg
 inner join (select clsysjgxx, count(*) num
               from zzww_zxjbxx a
              where 1 = 1
                and sfdeptview = 1
                and deptid is null and (shjg in (0, 4) and
                    jbid not in (select jbid
                                    from zzww_lbjxfxx
                                   where lbbm is null
                                     and sljg in (0))
                 or jbid in (select jbid
                               from zzww_lbjxfxx
                              where lbbm is null
                                and sljg = 0))
                and ylzd2 = 1
              group by clsysjgxx) o
    on jg.jgid = o.clsysjgxx
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6216  督办(综治维稳) 部门不为null
select jg.jgid, jg.jgbm, 6216 dataid, nvl(sum(num), 0) num, o.deptid bs,sysdate
  from tmp_org jg
 inner join (select clsysjgxx, deptid, count(*) num
               from zzww_zxjbxx
              where 1 = 1
                and sfdeptview = 1
                and deptid is not null and (shjg in (0, 4) and
                    jbid not in (select jbid
                                    from zzww_lbjxfxx
                                   where lbbm is not null
                                     and sljg in (0))
                 or jbid in (select jbid
                               from zzww_lbjxfxx
                              where lbbm is not null
                                and sljg = 0))
                and ylzd2 = 1
              group by clsysjgxx, deptid) o
    on jg.jgid = o.clsysjgxx
 group by jg.jgid, jg.jgbm, o.deptid;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6216  督办(综治维稳) 责任人
select z.userid, z.jgbm, 6216 dataid, nvl(num, 0) num, 1 bs,sysdate
  from mv_zrr_info z
 inner join (select zrruserid, count(*) num
               from zzww_zxjbxx
              where 1 = 1
                and sfdeptview = 1
                and ylzd2 = 1
              group by zrruserid) o
    on z.userid = o.zrruserid;

--6217  待办(综治维稳)
insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6217  待办(综治维稳) 部门为null
select jg.jgid, jg.jgbm, 6217 dataid, nvl(sum(num), 0) num, -1 bs,sysdate
  from mv_jg_info jg
 inner join (select clsysjgxx, count(*) num
               from zzww_zxjbxx a
              where 1 = 1
                and sfdeptview = 1
                and deptid is null and (shjg in (0, 4) and
                    jbid not in (select jbid
                                    from zzww_lbjxfxx
                                   where lbbm is null
                                     and sljg in (0))
                 or jbid in (select jbid
                               from zzww_lbjxfxx
                              where lbbm is null
                                and sljg = 0))
              group by clsysjgxx) o
    on jg.jgid = o.clsysjgxx
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6217  待办(综治维稳) 部门不为null
select jg.jgid, jg.jgbm, 6217 dataid, nvl(sum(num), 0) num, o.deptid bs,sysdate
  from mv_jg_info jg
 inner join (select clsysjgxx, deptid, count(*) num
               from zzww_zxjbxx
              where 1 = 1
                and sfdeptview = 1
                and deptid is not null and (shjg in (0, 4) and
                    jbid not in (select jbid
                                    from zzww_lbjxfxx
                                   where lbbm is not null
                                     and sljg in (0))
                 or jbid in (select jbid
                               from zzww_lbjxfxx
                              where lbbm is not null
                                and sljg = 0))
              group by clsysjgxx, deptid) o
    on jg.jgid = o.clsysjgxx
 group by jg.jgid, jg.jgbm, o.deptid;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6217  待办(综治维稳) 责任人
select z.userid, z.jgbm, 6217 dataid, nvl(num, 0) num, 1 bs,sysdate
  from mv_zrr_info z
 inner join (select zrruserid, count(*) num
               from zzww_zxjbxx
              where 1 = 1
                and sfdeptview = 1
              group by zrruserid) o
    on z.userid = o.zrruserid;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6218  流动人口(公安)
select jg.jgid, jg.jgbm, 6218 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from gabm_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6219  户籍(公安)
select jg.jgid, jg.jgbm, 6219 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(hjxgid) num
               from gabm_hjxxxg a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6220  结婚(民政)
select jg.jgid, jg.jgbm, 6220 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(mztbid) num
               from mzbm_mzbmtb a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6221  收养(民政)
select jg.jgid, jg.jgbm, 6221 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(syylid) num
               from mzbm_ylsy a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6222  离婚(民政)
select jg.jgid, jg.jgbm, 6222 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(tbid) num
               from mzbm_lhtb a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6223  营业人员(工商)
select jg.jgid, jg.jgbm, 6223 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from gsbm_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6224  佣工人员(工商)
select jg.jgid, jg.jgbm, 6224 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from gsbm_ygryrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6225  流动人员(人力资源)
select jg.jgid, jg.jgbm, 6225 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from rlzy_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6226  流动人员(交通部门)
select jg.jgid, jg.jgbm, 6226 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from mv_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from jtbm_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

------插入目标表
execute immediate 'truncate table tjxx_tbyj_dataid';

insert /*+ APPEND */ into tjxx_tbyj_dataid
select * from temp_tbyj_dataid;
commit;
end sys_tbyj_dataid;
/

begin
  sys.dbms_scheduler.create_job(job_name            => 'QYRK.JOB_TBYJ_DATA',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'sys_tbyj_dataid',
                                start_date          => sysdate,
                                repeat_interval     => 'Freq=Minutely;Interval=10',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => '生成通报预警类指标数据.');
end;
/

--begin
--  dbms_scheduler.run_job(job_name => 'QYRK.JOB_TBYJ_DATA');
--end;
--/
----------------------------------------------------------------------------------------
--预警和通报类统计指标物化视图 End
----------------------------------------------------------------------------------------

/*************************************************************/
--总视图
/*************************************************************/
create or replace view tjxx_jbxxtj as
select null tjid,jgid userid,jgbm,dataid,num,bs from mv_jg_dataid --户况图信息(机构)
union all
--户况图信息(责任人)
select null tjid,userid,null,dataid,num,bs from mv_zrr_dataid
union all
--户况图信息(楼栋)
select null tjid,userid,null,dataid,num,bs from mv_ld_dataid
union all
--通报预警类指示
select null tjid,userid,jgbm,dataid,num,bs from tjxx_tbyj_dataid;
/*
--6208  城市110
select jgid,jgbm,dataid,num,bs from mv_tbyj_110_c
union all
--6209  无身份证(预警提示)
select jgid,jgbm,dataid,num,bs from mv_tbyj_noid_c
union all
--6210  生殖保健(预警提示)
select jgid,jgbm,dataid,num,bs from mv_tbyj_szbj_c
union all
--6211  怀孕无结果(预警提示)
select jgid,jgbm,dataid,num,bs from mv_tbyj_hywjg_c
union all
--6212  待产节育(预警提示)
select jgid,jgbm,dataid,num,bs from mv_tbyj_dcjy_c
union all
--6213  生产待节育(预警提示)
select jgid,jgbm,dataid,num,bs from mv_tbyj_scjy_c
union all
--6214  待孕检人员(预警提示)
select jgid,jgbm,dataid,num,bs from mv_tbyj_dyjry_c
union all
--6215  待环检人员(预警提示)
select jgid,jgbm,dataid,num,bs from mv_tbyj_dhjry_c
union all
--6216  督办(综治维稳) 部门为null
select jgid,jgbm,dataid,num,bs from mv_tbyj_zzww_jgdb1_c
union all
--6216  督办(综治维稳) 部门不为null
select jgid,jgbm,dataid,num,bs from mv_tbyj_zzww_jgdb2_c
union all
--6216  督办(综治维稳) 责任人
select userid,jgbm,dataid,num,bs from mv_tbyj_zzww_jgdb3_c
union all
--6217  待办(综治维稳) 部门为null
select jgid,jgbm,dataid,num,bs from mv_tbyj_zzww_jgdab1_c
union all
--6217  待办(综治维稳) 部门不为null
select jgid,jgbm,dataid,num,bs from mv_tbyj_zzww_jgdab2_c
union all
--6217  待办(综治维稳) 责任人
select userid,jgbm,dataid,num,bs from mv_tbyj_zzww_jgdab3_c
union all
--6218  流动人口(公安)
select jgid,jgbm,dataid,num,bs from mv_tbyj_ga_ldrk_c
union all
--6219  户籍(公安)
select jgid,jgbm,dataid,num,bs from mv_tbyj_ga_hjrk_c
union all
--6220  结婚(民政)
select jgid,jgbm,dataid,num,bs from mv_tbyj_mz_jiehun_c
union all
--6221  收养(民政)
select jgid,jgbm,dataid,num,bs from mv_tbyj_mz_lysy_c
union all
--6222  离婚(民政)
select jgid,jgbm,dataid,num,bs from mv_tbyj_mz_lhtb_c
union all
--6223  营业人员(工商)
select jgid,jgbm,dataid,num,bs from mv_tbyj_gs_xlldrk_c
union all
--6224  佣工人员(工商)
select jgid,jgbm,dataid,num,bs from mv_tbyj_gs_ygryrk_c
union all
--6225  流动人员(人力资源)
select jgid,jgbm,dataid,num,bs from mv_tbyj_rlzy_xlldrk_c
union all
--6226  流动人员(交通部门)
select jgid,jgbm,dataid,num,bs from mv_tbyj_jt_xlldrk_c;
*/
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
--创建完全刷新组
--begin
--  dbms_refresh.make(name      => 'refgroup1',
--                    list      => 'MV_TBYJ_110_C,
--                                  MV_TBYJ_NOID_C,
--                                  MV_TBYJ_SZBJ_C,
--                                  MV_TBYJ_HYWJG_C,
--                                  MV_TBYJ_DCJY_C,
--                                  MV_TBYJ_SCJY_C,
--                                  MV_TBYJ_DYJRY_C,
--                                  MV_TBYJ_DHJRY_C,
--                                  MV_TBYJ_ZZWW_JGDAB3_C,
--                                  MV_TBYJ_ZZWW_JGDB3_C,
--                                  MV_TBYJ_GA_LDRK_C,
--                                  MV_TBYJ_GA_HJRK_C,
--                                  MV_TBYJ_MZ_JIEHUN_C,
--                                  MV_TBYJ_MZ_LYSY_C,
--                                  MV_TBYJ_MZ_LHTB_C,
--                                  MV_TBYJ_GS_XLLDRK_C,
--                                  MV_TBYJ_GS_YGRYRK_C,
--                                  MV_TBYJ_RLZY_XLLDRK_C,
--                                  MV_TBYJ_JT_XLLDRK_C,
--                                  MV_TBYJ_ZZWW_JGDB1_C,
--                                  MV_TBYJ_ZZWW_JGDB2_C,
--                                  MV_TBYJ_ZZWW_JGDAB1_C,
--                                  MV_TBYJ_ZZWW_JGDAB2_C',
--                    next_date => sysdate,
--                    interval  => 'sysdate + 1 / 144');
--end;
--/

--创建快速刷新组
begin
  dbms_refresh.make(name      => 'refgroup2',
                    list      => 'MV_JG_BFWWXX_AGG,
                                  MV_JG_CJRY_AGG,
                                  MV_JG_CSRK_AGG,
                                  MV_JG_CXYLJZ_AGG,
                                  MV_JG_CZCSRY_AGG,
                                  MV_JG_CZRK_AGG,
                                  MV_JG_DATAID,
                                  MV_JG_DBH_AGG,
                                  MV_JG_FLGRY_AGG,
                                  MV_JG_FQYDW_AGG,
                                  MV_JG_FXPGINFO_AGG,
                                  MV_JG_FZXCZYZ_AGG,
                                  MV_JG_GHRK_AGG,
                                  MV_JG_HJRK_AGG,
                                  MV_JG_JBXX_AGG,
                                  MV_JG_JJJZ_AGG,
                                  MV_JG_JJLY_AGG,
                                  MV_JG_JKXXJC_AGG,
                                  MV_JG_JYFW_AGG,
                                  MV_JG_JYQKXX_AGG,
                                  MV_JG_KCH_AGG,
                                  MV_JG_KP_AGG,
                                  MV_JG_LDLZXXY_AGG,
                                  MV_JG_LDRK_AGG,
                                  MV_JG_LD_AGG,
                                  MV_JG_LRRK_AGG,
                                  MV_JG_RMTJY_AGG,
                                  MV_JG_SCJR_AGG,
                                  MV_JG_SHTT_AGG,
                                  MV_JG_SJZDRY_AGG,
                                  MV_JG_SQJZRY_AGG,
                                  MV_JG_SZBJ_AGG,
                                  MV_JG_TJHZINFO_AGG,
                                  MV_JG_TJHZINFO_BASE,
                                  MV_JG_TSRQ_AGG,
                                  MV_JG_TXXX_AGG,
                                  MV_JG_WXJSBRY_AGG,
                                  MV_JG_WZXX_AGG,
                                  MV_JG_XDRY_AGG,
                                  MV_JG_XQ_AGG,
                                  MV_JG_XSJJRY_AGG,
                                  MV_JG_XYTYRY_AGG,
                                  MV_JG_YBSB_AGG,
                                  MV_JG_YFDXWH_AGG,
                                  MV_JG_YJSJINFO_AGG,
                                  MV_JG_YLFN_AGG,
                                  MV_JG_ZDQSNRY_AGG,
                                  MV_JG_ZHS_AGG,
                                  MV_JG_ZHS_BASE,
                                  MV_JG_ZJXY_AGG,
                                  MV_JG_ZZRK_AGG,
                                  mv_jg_dy_agg,
                                  MV_LD_BFWW_AGG,
                                  MV_LD_CJRY_AGG,
                                  MV_LD_CXYLJZ_AGG,
                                  MV_LD_CZCSRY_AGG,
                                  MV_LD_CZRK_AGG,
                                  MV_LD_DATAID,
                                  MV_LD_DBH_AGG,
                                  MV_LD_FLGRY_AGG,
                                  MV_LD_FZXCZYZ_AGG,
                                  MV_LD_JJJZ_AGG,
                                  MV_LD_JKXXJC_AGG,
                                  MV_LD_JYFW_AGG,
                                  MV_LD_JYQK_AGG,
                                  MV_LD_KCH_AGG,
                                  MV_LD_KP_AGG,
                                  MV_LD_LDLZXXY_AGG,
                                  MV_LD_LDRK_AGG,
                                  MV_LD_LRRK_AGG,
                                  MV_LD_LYFN_AGG,
                                  MV_LD_RMTJY_AGG,
                                  MV_LD_SCJR_AGG,
                                  MV_LD_SJZDRY_AGG,
                                  MV_LD_SQJZRY_AGG,
                                  MV_LD_SZBJ_AGG,
                                  MV_LD_TSRQ_AGG,
                                  MV_LD_TXXX_AGG,
                                  MV_LD_WXJSBRY_AGG,
                                  MV_LD_XDRY_AGG,
                                  MV_LD_XSJJRY_AGG,
                                  MV_LD_XYTYRY_AGG,
                                  MV_LD_YBSB_AGG,
                                  MV_LD_YFDXWH_AGG,
                                  MV_LD_ZDQSNRY_AGG,
                                  MV_LD_ZJXY_AGG,
                                  MV_LD_ZZRK_AGG,
                                  MV_ZRR_BFWW_AGG,
                                  MV_ZRR_CJRY_AGG,
                                  MV_ZRR_CSRK_AGG,
                                  MV_ZRR_CXYLJZ_AGG,
                                  MV_ZRR_CZCSRY_AGG,
                                  MV_ZRR_CZRK_AGG,
                                  MV_ZRR_DATAID,
                                  MV_ZRR_DBH_AGG,
                                  MV_ZRR_FLGRY_AGG,
                                  MV_ZRR_FZXCZYZ_AGG,
                                  MV_ZRR_GHRK_AGG,
                                  MV_ZRR_HJRK_AGG,
                                  MV_ZRR_JBXX_AGG,
                                  MV_ZRR_JJJZ_AGG,
                                  MV_ZRR_JJLY_AGG,
                                  MV_ZRR_JKXXJC_AGG,
                                  MV_ZRR_JYFW_AGG,
                                  MV_ZRR_JYQK_AGG,
                                  MV_ZRR_KCH_AGG,
                                  MV_ZRR_KP_AGG,
                                  MV_ZRR_LDLZXXY_AGG,
                                  MV_ZRR_LDRK_AGG,
                                  MV_ZRR_LD_AGG,
                                  MV_ZRR_LRRK_AGG,
                                  MV_ZRR_RMTJY_AGG,
                                  MV_ZRR_SCJR_AGG,
                                  MV_ZRR_SJZDRY_AGG,
                                  MV_ZRR_SQJZRY_AGG,
                                  MV_ZRR_SZBJ_AGG,
                                  MV_ZRR_TSRQ_AGG,
                                  MV_ZRR_TXXX_AGG,
                                  MV_ZRR_WXJSBRY_AGG,
                                  MV_ZRR_XDRY_AGG,
                                  MV_ZRR_XQ_AGG,
                                  MV_ZRR_XQ_BASE,
                                  MV_ZRR_XSJJRY_AGG,
                                  MV_ZRR_XYTYRY_AGG,
                                  MV_ZRR_YBSB_AGG,
                                  MV_ZRR_YFDXWH_AGG,
                                  MV_ZRR_YLFN_AGG,
                                  MV_ZRR_ZDQSNRY_AGG,
                                  MV_ZRR_ZHS_AGG,
                                  MV_ZRR_ZHS_BASE,
                                  MV_ZRR_ZJXY_AGG,
                                  MV_ZRR_ZZRK_AGG,
                                  MV_ZRR_GYS_AGG,
                                  mv_zrr_dy_agg,
                                  MV_JG_xsqsn_AGG,
                                  MV_LD_xsqsn_AGG,
                                  MV_JG_azbhz_AGG,
                                  MV_LD_azbhz_AGG, 
                                  MV_JG_xfzdry_AGG,
                                  MV_LD_xfzdry_AGG,
                                  MV_JG_zjxyxx_AGG,
                                  MV_LD_zjxyxx_AGG,
                                  MV_JG_lset_AGG,
                                  MV_LD_lset_AGG,
                                  MV_JG_lsfn_AGG,
                                  MV_LD_lsfn_AGG',
                                  next_date => sysdate,
                                  interval  => 'sysdate + 10 /(1440*60)');
end;
/
commit;
--------------------------------------------------------------------------------
----创建维护任务
create or replace procedure sys_maintain_mv as
begin
  --重编译失效物化视图
  for c_co in (select owner, mview_name
                 from user_mviews
                where compile_state <> 'VALID') loop
    begin
      execute immediate 'alter materialized view ' || c_co.owner || '.' ||c_co.mview_name || ' compile';
    exception
      when others then
        null;
    end;
  end loop;

  --刷新staleness物化视图
  for c_re in (select owner,mview_name from user_mviews where staleness <> 'FRESH') loop
    begin
      dbms_mview.refresh(list => c_re.owner||'.'||c_re.mview_name,method => '?',nested => true);
      exception
        when others then
          null;
    end;
  end loop;
end;
/

--定时维护任务
begin
  sys.dbms_scheduler.create_job(job_name            => 'QYRK.JOB_MAINTAIN_MV',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'sys_maintain_mv',
                                start_date          => sysdate,
                                repeat_interval     => 'Freq=Minutely;Interval=5',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => 'recompile and refresh unusable or staleness materialized view');
end;
/

--begin
--  dbms_scheduler.run_job(job_name => 'QYRK.JOB_MAINTAIN_MV');
--end;
--/
--定时清楚JOB日志
begin
  sys.dbms_scheduler.create_job(job_name            => 'QYRK.JOB_PURGE_LOG',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin dbms_scheduler.purge_log; end;',
                                start_date          => sysdate,
                                repeat_interval     => 'Freq=Daily;Interval=1;ByHour=10;ByMinute=00;BySecond=00',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'purge job''s logs everyday.');
end;
/

--begin
--  dbms_scheduler.run_job(job_name => 'QYRK.JOB_PURGE_LOG');
--end;
--/
--select 'alter table '||table_name||' drop constraint '||constraint_name||' cascade;' from user_constraints where constraint_type='U' and table_name like 'MV%';
