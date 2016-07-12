create or replace procedure P_JG_DATAID
as
BEGIN

--����ͼ��Ϣ(����)
  --create table T_JG_INFO as
  execute immediate 'truncate table T_JG_INFO';
insert into T_JG_INFO
select b.jgid, b.jgbm,count(*) cnt
  from sys_userinfo a, sys_jgxxb b
 where a.ssjg = b.jgid
 group by b.jgid, b.jgbm;
   commit;

  --create table T_JG_DATAID as
  execute immediate 'truncate table T_JG_DATAID';
  --6148  С������
INSERT INTO T_JG_DATAID
SELECT B.JGID,
       B.JGBM,
       6148 DATAID,
       SUM(NUM) NUM,
       2 BS,
       COUNT(NUM) CNTN,
       COUNT(*) CNT
  FROM (SELECT B.JGBM, COUNT(A.XQID) NUM, COUNT(*) CNT
          FROM SYS_XQXXB A, SYS_JGXXB B
         WHERE A.SSDEPT = B.JGID
         GROUP BY B.JGBM) A,
       T_JG_INFO B
 WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
 GROUP BY B.JGID, B.JGBM;
 COMMIT;
   --6149  ¥������
INSERT INTO T_JG_DATAID
  SELECT B.JGID,
         B.JGBM,
         6149 DATAID,
         SUM(NUM) NUM,
         2 BS,
         COUNT(NUM) CNTN,
         COUNT(*) CNT
    FROM (SELECT B.JGBM, COUNT(A.LDID) NUM, COUNT(*) CNT
            FROM SYS_LDWHB A, SYS_JGXXB B
           WHERE A.JGID = B.JGID
             AND A.LDLX = 282
           GROUP BY B.JGBM) A,
         T_JG_INFO B
   WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
   GROUP BY B.JGID, B.JGBM ;
   COMMIT;
   --6150  ����¥������
   INSERT INTO T_JG_DATAID
   SELECT B.JGID,
       B.JGBM,
       6150 DATAID,
       SUM(NUM) NUM,
       2 BS,
       COUNT(NUM) CNTN,
       COUNT(*) CNT
  FROM (select b.jgbm, count(a.ldid) num,count(*) cnt
  from SYS_LDWHB a, sys_jgxxb b
 where a.jgid = b.jgid
   and a.ldlx <> 282
 group by b.jgbm) A, T_JG_INFO B
 WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
 GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6151  �����˿�����
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
       B.JGBM,
       6151 DATAID,
       SUM(NUM) NUM,
       2 BS,
       COUNT(NUM) CNTN,
       COUNT(*) CNT
  FROM (select f.jgbm, count(a.KPXXID) num, count(*) cnt
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
   and a.RKLX in (20, 21) group by f.jgbm) A, T_JG_INFO B
 WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
 GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6152  ��Ƭ��
 INSERT INTO T_JG_DATAID
SELECT B.JGID,
       B.JGBM,
       6152 DATAID,
       SUM(NUM) NUM,
       2 BS,
       COUNT(NUM) CNTN,
       COUNT(*) CNT
  FROM (select d.jgbm, count(a.KPXXID) num,count(*) cnt
  from QYXX_KPXXB a, SYS_LDWHB b, SYS_XQXXB c, SYS_JGXXB d, SYS_USERINFO e
 where a.LDHM = b.ldid
   and b.JGID = d.jgid
   and b.XQID = c.xqid
   and b.ZRRUSERID = e.userid
 group by d.jgbm) A, T_JG_INFO B
 WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
 GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6153  ��ס�˿���
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6153 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select e.jgbm, count(*) num
  from qyxx_kpryglb a, qyxx_kpxxb b, sys_ldwhb c, sys_jgxxb e
 where a.kpxxid = b.kpxxid
   and b.ldhm = c.ldid
   and c.jgid = e.jgid
   and a.sfczr = 'N'
 group by e.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6154  ���举Ů��
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6154 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select b.jgbm, count(*) num
  from QYXX_KPRYGLB  a,
       SYS_JGXXB     b,
       SYS_LDWHB     c,
       QYXX_KPXXB    f,
       QYXX_CPJTXX   g
 where a.KPXXID = f.KPXXID
   and f.LDHM = c.LDID
   and b.jgid = c.jgid
   and a.CYID = g.CYID
   and g.xb='Ů'
   and g.nl between 14 and 49
 group by b.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6155  ��ס�˿���
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6155 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select e.jgbm, count(*) num
  from qyxx_kpryglb a, qyxx_kpxxb b, sys_ldwhb c, sys_jgxxb e
 where a.kpxxid = b.kpxxid
   and b.ldhm = c.ldid
   and c.jgid = e.jgid
   and a.sfczr = 'N'
 group by e.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6156  �����˿���
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6156 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select e.jgbm, count(*) num
  from qyxx_kpryglb a, qyxx_kpxxb b, sys_ldwhb c, sys_jgxxb e
 where a.kpxxid = b.kpxxid
   and b.ldhm = c.ldid
   and c.jgid = e.jgid
   and a.sfczr = 'N'
   and a.rklx = 21
 group by e.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6157  �����˿���
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6157 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select e.jgbm, count(*) num
  from Qyxx_Kpryglbhjry a, qyxx_kpxxb b, sys_ldwhb c, sys_jgxxb e
 where a.kpxxid = b.kpxxid
   and b.ldhm = c.ldid
   and c.jgid = e.jgid
 group by e.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6158  �����˿���
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6158 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(*) num
  from QYXX_KPRYGLB a, QYXX_CPJTXX e, SYS_JGXXB f
 where a.CYID = e.CYID
   and a.jgid = f.jgid
   and e.nl between 0 and 1
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6159  �ͱ���
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6159 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,QYXX_DJWBRY r
 where a.JGID = f.jgid and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6160  �ճ���
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6160 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,QYXX_KCXX r
 where a.JGID = f.jgid and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6168  ��ֳ����
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6168 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_cyszbjxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;
 --6169  ��ҵ����
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6169 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f, qyxx_jyfwxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6170  �м���Ա
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6170 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num, count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f, qyxx_cjry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6171  ���ֹ���Ա��Ϣ
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6171 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,wqww_flgry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6172  ���ͽ����Ա��Ϣ
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6172 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,wqww_xsjjry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6173  ������Ϣ
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6173 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_txxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6174  ��ս����
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6174 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_czcsry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6175  ҽ���籣
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6175 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_ybsbxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6176  ����ҽ��
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6176 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_cxyljz r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6177  ���־ȼ�
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6177 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_jjjzxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6178  �˲о���
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6178 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_scjrxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6179  ������Ⱥ
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6179 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_tsrqxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6180  ��������
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6180 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_xytyry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6181  �������
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6181 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_jkxxjc r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6182  ���ο��
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6182 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_bfwwxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6183  �������
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6183 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_jyqkxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6184  ��������־Ը��
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6184 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,wqww_fzxczyz r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6185  ����������Ա
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6185 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,wqww_sqjzry r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6186  ����ص���Ա
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6186 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_sjzdryxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6187  ������Ա
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6187 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_xdryxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6188  Σ�վ�����Ա
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6188 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_wxjsbryxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6189  �ص���������Ա
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6189 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_zdqsnryxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6190  �������Ա
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6190 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_rmtjy r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6191  ¥������ϢԱ
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6191 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_ldlzxxy r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6192  �ڽ�������Ϣ
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6192 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_zjxyxx r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --6193  �Ÿ�������Ϣ
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        6193 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.cyid) num,count(*) cnt
  from QYXX_KPRYGLB a, SYS_JGXXB f,qyxx_yfdxwh r
 where a.JGID = f.jgid
   and a.CYID = r.CYID
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --16248  ������Ϣ
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        16248 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select t.jgbm,count(q.CKINFOID) num,count(*) cnt
  from GGYJ_CKINFO q, sys_jgxxb t
 where q.ssjg = t.jgid
 group by t.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --16249  �ŷ��¼�
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        16249 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select t.jgbm,count(q.JBID) num,count(*) cnt
  from ZZWW_ZXJBXX q, sys_jgxxb t
 where q.CLSYSJGXX = t.jgid
   and q.SHJG = 0
 group by t.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --16250  ����Ӧ���¼�
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        16250 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select t.jgbm, count(q.YJSJINFOID) num, count(*) cnt
  from GGYJ_YJSJINFO q, sys_jgxxb t
 where q.SSJG = t.jgid
 group by t.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --16251  ���������¼�
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        16251 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select t.jgbm, count(q.INFOID) num, count(*) cnt
  from FXPG_INFO q, sys_jgxxb t
 where q.SSJG = t.jgid
 group by t.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --16252  ������¼�
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        16252 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select jgbm, count(TJBASEINFOID) num, count(*) cnt
  from (
      select t.jgbm, q.TJBASEINFOID, count(*) cnt
  from DTJ_TJHZINFO q, SYS_DEPTINFO d, sys_jgxxb t
 where q.TJBM = d.DEPTID
   and d.SSJGID = t.jgid
   and q.SFDQKY = 'Y'
   group by t.jgbm, q.TJBASEINFOID
  )
 group by jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --16268  �������
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        16268 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select t.jgbm, count(q.SHTTID) num, count(*) cnt
  from SZMZ_SHTT q, sys_jgxxb t
 where q.SSDQ = t.jgid
 group by t.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --16269  ����ҵ��λ
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        16269 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select t.jgbm, count(q.MBFQYID) num, count(*) cnt
  from SZMZ_MBFQYDW q, sys_jgxxb t
 where q.SSDQ = t.jgid
 group by t.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --16288  �ܻ���
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        16288 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select jgbm, count(hm) num,count(*) cnt
  from (
       select b.jgbm, a.kpxxid, nvl(a.hm, 1) hm,count(*) cnt
       from qyxx_kpryglb a, sys_jgxxb b
       where a.jgid = b.jgid
       group by b.jgbm, a.kpxxid,nvl(a.hm, 1)
  )
 group by jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;

 --40008 �һ��˿���
 INSERT INTO T_JG_DATAID
 SELECT B.JGID,
        B.JGBM,
        40008 DATAID,
        SUM(NUM) NUM,
        2 BS,
        COUNT(NUM) CNTN,
        COUNT(*) CNT
   FROM (select f.jgbm, count(a.KPXXID) num, count(*) cnt
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
 group by f.jgbm) A, T_JG_INFO B
  WHERE REGEXP_LIKE(A.JGBM, B.JGBM)
  GROUP BY B.JGID, B.JGBM;
 COMMIT;
end;
