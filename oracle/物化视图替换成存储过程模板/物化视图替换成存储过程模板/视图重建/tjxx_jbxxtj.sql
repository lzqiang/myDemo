create or replace view tjxx_jbxxtj as
select null tjid,jgid userid,jgbm,dataid,num,bs from t_jg_dataid_0801 --����ͼ��Ϣ(����)
union all
--����ͼ��Ϣ(������)
select null tjid,userid,null,dataid,num,bs from t_zrr_dataid_0801
union all
--����ͼ��Ϣ(¥��)
select null tjid,userid,null,dataid,num,bs from t_ld_dataid_0801
union all
--ͨ��Ԥ����ָʾ
select null tjid,userid,jgbm,dataid,num,bs from tjxx_tbyj_dataid
;
