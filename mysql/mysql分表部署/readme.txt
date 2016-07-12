1.给表dpa_det_old添加 主键自增

2.创建nextid 主键维护表
CREATE TABLE `nextid` (
	`id` INT (11)
); 

3.执行start_split_table,split_table,nextId脚本

4.执行
CALL  CALL start_split_table(5000,'dpa_det_alarm','id');; #5000是每个子表的条数,dpa_det_alarm 要切分的表名称,id:要切分表的主键

5.建立job 每天执行一次 如果最后一个子表大于分割的 自动添加子表

CREATE EVENT `check_split_table` ON SCHEDULE EVERY 1 DAY STARTS '2015-08-21 00:10:00'

ON COMPLETION NOT PRESERVE ENABLE

DO CALL CALL split_table(5000,'zdrns','dpa_det_alarm','id');


启动

 SET GLOBAL event_scheduler = ON;  

