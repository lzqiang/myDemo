--查询机构编码
select * from SYS_JGXXB t WHERE T.JGMC='沅陵县';

--修改首页的代码 字段：sjgbmkt
select a.* from sys_parameter a;

--admin用户所属机构修改   字段：ssjg
select b.* from sys_userinfo b where b.loginname='admin';

--党建党组织，机构编码修改
select c.* from sqdj_sqdjxx  c ;


--头部图片修改路径  \webapps\qyrk\mainFrame\images\
--登录页面图片修改路径  \webapps\qyrk\images\

