create or replace procedure sys_tbyj_dataid as
begin

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6208	??110
select jg.jgid, jg.jgbm, 6208 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
 inner join (select b.jgbm, count(cs110id) num
               from cs110 a, sys_jgxxb b
              where a.jbjgid = b.jgid
                and shr is null
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6209	????(????)
select jg.jgid, jg.jgbm, 6209 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
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
--6210	????(????)
select jg.jgid, jg.jgbm, 6210 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
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
--6211	?????(????)
select jg.jgid, jg.jgbm, 6211 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
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
--6212	????(????)
select jg.jgid, jg.jgbm, 6212 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
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
--6213	?????(????)
select jg.jgid, jg.jgbm, 6213 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
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
--6214	?????(????)
select jg.jgid, jg.jgbm, 6214 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
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
                and e.xb = '?'
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
--6215	?????(????)
select jg.jgid, jg.jgbm, 6215 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
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
                and e.xb = '?'
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

--6216	??(????)
insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6216	??(????) ???null
select jg.jgid, jg.jgbm, 6216 dataid, nvl(sum(num), 0) num, -1 bs,sysdate
  from t_jg_info jg
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
--6216	??(????) ????null
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
--6216	??(????) ???
select z.userid, z.jgbm, 6216 dataid, nvl(num, 0) num, 1 bs,sysdate
  from t_zrr_info z
 inner join (select zrruserid, count(*) num
               from zzww_zxjbxx
              where 1 = 1
                and sfdeptview = 1
                and ylzd2 = 1
              group by zrruserid) o
    on z.userid = o.zrruserid;

--6217	??(????)
insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6217	??(????) ???null
select jg.jgid, jg.jgbm, 6217 dataid, nvl(sum(num), 0) num, -1 bs,sysdate
  from t_jg_info jg
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
--6217	??(????) ????null
select jg.jgid, jg.jgbm, 6217 dataid, nvl(sum(num), 0) num, o.deptid bs,sysdate
  from t_jg_info jg
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
--6217	??(????) ???
select z.userid, z.jgbm, 6217 dataid, nvl(num, 0) num, 1 bs,sysdate
  from t_zrr_info z
 inner join (select zrruserid, count(*) num
               from zzww_zxjbxx
              where 1 = 1
                and sfdeptview = 1
              group by zrruserid) o
    on z.userid = o.zrruserid;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6218	????(??)
select jg.jgid, jg.jgbm, 6218 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from gabm_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6219	??(??)
select jg.jgid, jg.jgbm, 6219 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
 inner join (select b.jgbm, count(hjxgid) num
               from gabm_hjxxxg a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6220	??(??)
select jg.jgid, jg.jgbm, 6220 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
 inner join (select b.jgbm, count(mztbid) num
               from mzbm_mzbmtb a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6221	??(??)
select jg.jgid, jg.jgbm, 6221 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
 inner join (select b.jgbm, count(syylid) num
               from mzbm_ylsy a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6222	??(??)
select jg.jgid, jg.jgbm, 6222 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
 inner join (select b.jgbm, count(tbid) num
               from mzbm_lhtb a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6223	????(??)
select jg.jgid, jg.jgbm, 6223 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from gsbm_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6224	????(??)
select jg.jgid, jg.jgbm, 6224 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from gsbm_ygryrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6225	????(????)
select jg.jgid, jg.jgbm, 6225 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from rlzy_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

insert into temp_tbyj_dataid (jgid,jgbm,dataid,num,bs,refresh_time)
--6226	????(????)
select jg.jgid, jg.jgbm, 6226 dataid, nvl(sum(num),0) num, 2 bs,sysdate
  from t_jg_info jg
 inner join (select b.jgbm, count(xlrkid) num
               from jtbm_xlldrk a, sys_jgxxb b
              where a.tbzjg = b.jgid
                and (shjg = 0 or shjg = 3)
              group by b.jgbm) o
    on regexp_like(o.jgbm, jg.jgbm)
 group by jg.jgid, jg.jgbm;

------?????
execute immediate 'truncate table tjxx_tbyj_dataid';

insert /*+ APPEND */ into tjxx_tbyj_dataid
select * from temp_tbyj_dataid;
commit;
end sys_tbyj_dataid;
/
