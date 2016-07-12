create or replace procedure P_LD_DATAID
as
BEGIN

--户况图信息(楼栋)
  --create table T_LD_DATAID as
  execute immediate 'truncate table T_LD_DATAID';
--6151  流动人口数量
INSERT INTO T_LD_DATAID
select ldid userid,6151 dataid,num,3 bs from (select a.ldid, count(a.kpxxid) num,count(*) cnt
from qyxx_kpryglb a
where a.RKLX in (20, 21)
group by a.ldid);
COMMIT;
--6152  卡片数
INSERT INTO T_LD_DATAID
select ldid userid,6152 dataid,num,3 bs from (select b.ldid, count(KPXXID) num,count(*) cnt
  from QYXX_KPXXB a, SYS_LDWHB b
 where a.LDHM = b.ldid
 group by b.ldid);
COMMIT;
--6153  在住人口数
INSERT INTO T_LD_DATAID
select ldid userid,6153 dataid,num,3 bs from (select a.ldid, count(a.kpxxid) num,count(*) cnt
  from qyxx_kpryglb a
 group by a.ldid);
COMMIT;
--6154  育龄妇女数
INSERT INTO T_LD_DATAID
select ldid userid,6154 dataid,num,3 bs from (select a.ldid, count(*) num,count(*) cnt
  from YLFN_YLFNJBXX q, QYXX_KPRYGLB a
 where q.YLZD4 = a.GUANLIID
 group by a.ldid);
COMMIT;
--6155  常住人口数
INSERT INTO T_LD_DATAID
select ldid userid,6155 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num,count(*) cnt
  from QYXX_KPRYGLB a
 where a.RKLX = 19
 group by a.ldid);
COMMIT;
--6156  流入人口数
INSERT INTO T_LD_DATAID
select ldid userid,6156 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a
 where a.RKLX = 21
 group by a.ldid);
COMMIT;
--6159  低保户
INSERT INTO T_LD_DATAID
select ldid userid,6159 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,QYXX_DJWBRY r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6160  空巢户
INSERT INTO T_LD_DATAID
select ldid userid,6160 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,QYXX_KCXX r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6168  生殖保健
INSERT INTO T_LD_DATAID
select ldid userid,6168 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_cyszbjxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6169  就业服务
INSERT INTO T_LD_DATAID
select ldid userid,6169 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_jyfwxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6170  残疾人员
INSERT INTO T_LD_DATAID
select ldid userid,6170 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_cjry r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6171  法轮功人员信息
INSERT INTO T_LD_DATAID
select ldid userid,6171 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,wqww_flgry r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6172  刑释解教人员信息
INSERT INTO T_LD_DATAID
select ldid userid,6172 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,wqww_xsjjry r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6173  退休信息
INSERT INTO T_LD_DATAID
select ldid userid,6173 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_txxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6174  参战参试
INSERT INTO T_LD_DATAID
select ldid userid,6174 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_czcsry r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6175  医保社保
INSERT INTO T_LD_DATAID
select ldid userid,6175 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_ybsbxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6176  城乡医疗
INSERT INTO T_LD_DATAID
select ldid userid,6176 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_cxyljz r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6177  救灾救济
INSERT INTO T_LD_DATAID
select ldid userid,6177 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_jjjzxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6178  伤残军人
INSERT INTO T_LD_DATAID
select ldid userid,6178 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_scjrxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6179  特殊人群
INSERT INTO T_LD_DATAID
select ldid userid,6179 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_tsrqxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6180  现役退役
INSERT INTO T_LD_DATAID
select ldid userid,6180 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_xytyry r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6181  健康检查
INSERT INTO T_LD_DATAID
select ldid userid,6181 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_jkxxjc r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6182  帮扶慰问
INSERT INTO T_LD_DATAID
select ldid userid,6182 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_bfwwxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6183  教育情况
INSERT INTO T_LD_DATAID
select ldid userid,6183 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_jyqkxx r
 where a.CYID = r.CYID
 group by a.ldid)
COMMIT;
--6184  法制宣传志愿者
INSERT INTO T_LD_DATAID
select ldid userid,6184 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_jyqkxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6185  社区矫正人员
INSERT INTO T_LD_DATAID
select ldid userid,6185 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,wqww_sqjzry r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6186  涉军重点人员
INSERT INTO T_LD_DATAID
select ldid userid,6186 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_sjzdryxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6187  吸毒人员
INSERT INTO T_LD_DATAID
select ldid userid,6187 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_xdryxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6188  危险精神病人员
INSERT INTO T_LD_DATAID
select ldid userid,6188 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_wxjsbryxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6189  重点青少年人员
INSERT INTO T_LD_DATAID
select ldid userid,6189 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_zdqsnryxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6190  人民调解员
INSERT INTO T_LD_DATAID
select ldid userid,6190 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_rmtjy r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6191  楼栋长信息员
INSERT INTO T_LD_DATAID
select ldid userid,6191 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_ldlzxxy r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6192  宗教信仰信息
INSERT INTO T_LD_DATAID
select ldid userid,6192 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_zjxyxx r
 where a.CYID = r.CYID
 group by a.ldid);
COMMIT;
--6193  优抚对象信息
INSERT INTO T_LD_DATAID
select ldid userid,6193 dataid,num,3 bs from (select a.ldid, count(a.KPXXID) num, count(*) cnt
  from QYXX_KPRYGLB a,qyxx_yfdxwh r
 where a.CYID = r.CYID
 group by a.ldid);
 COMMIT;
 END;
