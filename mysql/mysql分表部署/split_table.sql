DELIMITER $$

USE `zdrns`$$

DROP PROCEDURE IF EXISTS `split_table`$$

CREATE DEFINER=`root`@`%` PROCEDURE `split_table`(IN rownum INT,IN table_schema VARCHAR(2560),IN splittablename VARCHAR(2560),IN primarykey VARCHAR(2560))
BEGIN
DECLARE `@rownum` INT(11) DEFAULT 0;#子表达到最大行数后进行分表
DECLARE `@tablecount` INT(11) DEFAULT 0;#总表和子表一共有多少了
DECLARE `@i` INT(11) DEFAULT 0;#循环 得到子表字符串的变量
DECLARE `@tabname` LONGTEXT;#拼接子表字符串的变量
DECLARE `@siteCount` INT(11) DEFAULT 0;#存放最后一个子表中有多少条数据
DECLARE `@sqlstr` VARCHAR(2560) CHARACTER SET gbk DEFAULT '';#拼接sql语句
DECLARE `@table_schema` VARCHAR(2560) CHARACTER SET gbk DEFAULT '';#数据库名称
DECLARE `@splittablename` VARCHAR(2560) CHARACTER SET gbk DEFAULT '';#要切割的表名称
DECLARE `@primarykey` VARCHAR(2560) CHARACTER SET gbk DEFAULT '';#要切割的表的主键
#参数赋值开始
SET `@rownum` = rownum;
SET `@table_schema` = table_schema;
SET `@splittablename` = splittablename;
SET `@primarykey` = primarykey;
#参数赋值结束
#查询要分割的表和子表一共有多少个  开始
SET @sqlstr = CONCAT('SELECT COUNT(1) INTO @tablecount FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA =\'','',`@table_schema`,'\' AND table_name LIKE \'',`@splittablename`,'%\'');
PREPARE stmt FROM @sqlstr;
EXECUTE stmt;
SET `@tablecount` = @tablecount;
DEALLOCATE PREPARE stmt;
#查询要分割的表和子表一共有多少个  结束
#查询最后一个子表有多少条数据 开始
SET @sqlstr = CONCAT('SELECT COUNT(0) into @siteCount FROM ',`@splittablename`,'_',`@tablecount`-1);
PREPARE stmt FROM @sqlstr;
EXECUTE stmt;
SET `@siteCount` = @siteCount;
DEALLOCATE PREPARE stmt;
#查询最后一个子表有多少条数据 结束
IF `@rownum`<=`@siteCount`
THEN
SET @sqlstr=CONCAT('create table ',`@splittablename`,'_',`@tablecount`,' as select * from ',`@splittablename`,' limit 0');
PREPARE stmt FROM @sqlstr;#创建表
EXECUTE stmt;
SET @sqlstr = CONCAT('alter table ',`@splittablename`,'_',`@tablecount`,' engine=myisam');
PREPARE stmt FROM @sqlstr;#修改表引擎
EXECUTE stmt;
SET @sqlstr = CONCAT('alter table ',`@splittablename`,'_',`@tablecount`,' ADD PRIMARY KEY(`',`@primarykey`,'`);');
PREPARE stmt FROM @sqlstr;#修改表主键
EXECUTE stmt;
SET @sqlstr = CONCAT('alter table ',`@splittablename`,'_',`@tablecount`,' MODIFY COLUMN `',`@primarykey`,'` INT NOT NULL AUTO_INCREMENT FIRST ;');
PREPARE stmt FROM @sqlstr;
EXECUTE stmt;
#拼接子表字符串
SET `@i`=0;
WHILE `@i`<`@tablecount` DO
 SET `@i`= `@i`+1;
 IF(`@tabname` IS NULL)
 THEN
    SET `@tabname`=CONCAT(`@splittablename`,'_',`@i`);
 ELSE
    SET `@tabname`=CONCAT(`@tabname`,',',`@splittablename`,'_',`@i`);
 END IF;
END WHILE;
SET @sqlstr = CONCAT('ALTER TABLE ',`@splittablename`,' UNION=(',`@tabname`,')');
PREPARE stmt FROM @sqlstr;
EXECUTE stmt;
END IF;
END$$

DELIMITER ;