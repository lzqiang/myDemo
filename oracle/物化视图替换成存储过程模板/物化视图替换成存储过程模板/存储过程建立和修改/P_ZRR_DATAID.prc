create or replace procedure P_ZRR_DATAID
as
BEGIN

--户况图信息(责任人)
  --CREATE table t_zrr_info as
  execute immediate 'truncate table t_zrr_info';
insert into t_zrr_info
select a.userid, b.jgbm,a.rowid user_rid,b.rowid jg_rid
  from sys_userinfo a, sys_jgxxb b
 where a.ssjg = b.jgid(+)
   and qwzt = 1;
   commit;

  --create table T_ZRR_DATAID as
  execute immediate 'truncate table T_ZRR_DATAID';
  --6148  小区数量
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6148 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM t_zrr_info A,( select a.zrruserid, count(a.xqid) num,count(*) cnt
  from (
       select p.zrruserid, t.xqid,count(*) cnt
       from sys_ldwhb p, sys_xqxxb t
       where p.xqid = t.xqid
       group by p.zrruserid, t.xqid
  ) a
 group by a.zrruserid) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
 --6149  楼栋数量
insert into T_ZRR_DATAID
SELECT A.USERID,
       6149 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select z.zrruserid, count(z.ldid) num, count(*) cnt
  from SYS_LDWHB z
 where z.ldlx = 282
 group by z.zrruserid) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6150  经济楼宇数量
insert into T_ZRR_DATAID
SELECT A.USERID,
       6150 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select z.zrruserid, count(z.ldid) num, count(*) cnt
  from SYS_LDWHB z
 where z.ldlx <> 282
 group by z.zrruserid) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6151  流动人口数量
insert into T_ZRR_DATAID
SELECT A.USERID,
       6151 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
 group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6152  卡片数
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6152 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select b.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPXXB a, SYS_LDWHB b, SYS_XQXXB c, SYS_JGXXB d, SYS_USERINFO e
 where a.LDHM = b.ldid
   and b.JGID = d.jgid
   and b.XQID = c.xqid
   and b.ZRRUSERID = e.userid
 group by b.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6153  在住人口数
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6153 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
 group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6154  育龄妇女数
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6154 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(*) num
  from QYXX_KPRYGLB  a,
       SYS_JGXXB     b,
       SYS_LDWHB     c,
       QYXX_KPXXB    f,
       QYXX_CPJTXX   g
 where a.KPXXID = f.KPXXID
   and f.LDHM = c.LDID
   and b.jgid = c.jgid
   and a.CYID = g.CYID
   and g.xb='女'
   and g.nl between 14 and 49
 group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6155  常住人口数
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6155 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
 group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6156  流入人口数
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6156 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6157  户籍人口数
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6157 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
 group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6158  出生人口数
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6158 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
   and e.nl between 0 and 1
 group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6159  低保户
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6159 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6160  空巢户
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6160 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6168  生殖保健
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6168 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6169  就业服务
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6169 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6170  残疾人员
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6170 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6171  法轮功人员信息
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6171 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6172  刑释解教人员信息
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6172 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6173  退休信息
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6173 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6174  参战参试
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6174 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6175  医保社保
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6175 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6176  城乡医疗
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6176 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6177  救灾救济
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6177 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6178  伤残军人
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6178 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6179  特殊人群
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6179 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
 group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6180  现役退役
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6180 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
 group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6181  健康检查
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6181 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6182  帮扶慰问
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6182 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6183  教育情况
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6183 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6184  法制宣传志愿者
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6184 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6185  社区矫正人员
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6185 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6186  涉军重点人员
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6186 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6187  吸毒人员
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6187 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6188  危险精神病人员
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6188 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6189  重点青少年人员
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6189 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6190  人民调解员
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6190 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6191  楼栋长信息员
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6191 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6192  宗教信仰信息
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6192 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6193  优抚对象信息
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6193 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num, count(*) cnt
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
         group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--6194  党员数
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       6194 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.zrruserid,count(a.KPXXID) num,count(*) cnt
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
 group by c.zrruserid) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--16249 信访事件
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       16249 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select ZRRUSERID, count(JBID) num,count(*) cnt
  from ZZWW_ZXJBXX
 where SHJG = 0
 group by ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--16288 总户数
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       16288 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select zrruserid, count(hm) num,count(*) cnt
  from (
       select b.zrruserid, a.kpxxid, nvl(a.hm, 1) hm,count(*) cnt
       from qyxx_kpryglb a, sys_ldwhb b
       where a.ldid = b.ldid
       and b.zrruserid is not null
       group by b.zrruserid, a.kpxxid,nvl(a.hm, 1)
  )
 group by zrruserid) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
--40008 挂户人口数
INSERT INTO T_ZRR_DATAID
SELECT A.USERID,
       40008 DATAID,
       NVL(B.NUM, 0) NUM,
       1 BS
  FROM T_ZRR_INFO A, (select c.ZRRUSERID, count(a.KPXXID) num,count(*) cnt
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
 group by c.ZRRUSERID) B
 WHERE A.USERID = B.ZRRUSERID(+);
 COMMIT;
 end;
