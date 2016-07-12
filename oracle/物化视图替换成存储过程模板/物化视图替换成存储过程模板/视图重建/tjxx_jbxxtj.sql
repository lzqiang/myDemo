create or replace view tjxx_jbxxtj as
select null tjid,jgid userid,jgbm,dataid,num,bs from t_jg_dataid_0801 --户况图信息(机构)
union all
--户况图信息(责任人)
select null tjid,userid,null,dataid,num,bs from t_zrr_dataid_0801
union all
--户况图信息(楼栋)
select null tjid,userid,null,dataid,num,bs from t_ld_dataid_0801
union all
--通报预警类指示
select null tjid,userid,jgbm,dataid,num,bs from tjxx_tbyj_dataid
;
