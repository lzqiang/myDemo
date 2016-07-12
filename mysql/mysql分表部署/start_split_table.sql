DELIMITER $$

USE `zdrns`$$

DROP PROCEDURE IF EXISTS `start_split_table`$$
#1.每个子表的条数(切表标准) 2.要切割表的名 3.要切割表的主键
CREATE DEFINER=`root`@`%` PROCEDURE `start_split_table`(IN tablerownum INT ,IN tablename VARCHAR(2560),IN primarykey VARCHAR(2560))
BEGIN
  DECLARE `@tablename` VARCHAR(2560);#要切割表的名称
  DECLARE `@tabnames` LONGTEXT; #拼接所有子表的字符串
  DECLARE `@startindex` INT(11);#切割表的开始位置
  DECLARE `@tablerownum` INT(11);#切割表的行数(标准)
  DECLARE `@sqlstr` VARCHAR(2560);#sql语句字符串
  DECLARE `@siteCount` INT(11);#原表数据条数
  DECLARE `@num` INT(11);#切割的表数
  DECLARE `@i` INT(11);
  DECLARE `@j` INT(11);
  DECLARE `@primarykey` VARCHAR(2560);#主键 
  
  SET `@primarykey` = primarykey;
  SET `@tablename` = tablename;
  SET `@tablerownum` = tablerownum;
  #计算原表数据条数  开始
  SET @sqlstr = CONCAT('SELECT COUNT(0) into @siteCount FROM ',`@tablename`);
  PREPARE stmt FROM @sqlstr;
  EXECUTE stmt;
  SET `@siteCount` = @siteCount;
  DEALLOCATE PREPARE stmt;
  #计算原表数据条数  结束
  
  #生成子表 开始
  SET `@num` = CEIL(`@siteCount` / `@tablerownum`);
  SET `@i`=1;
  SET `@startindex` = 0;
  WHILE `@i`<=`@num`    DO
  SET @sqlstr = CONCAT('CREATE TABLE ',`@tablename`,'_',`@i`,' as select * from ',`@tablename`,' limit ',`@startindex`,',',`@tablerownum`);
  PREPARE stmt FROM @sqlstr;
  EXECUTE stmt;
  SET `@startindex` = `@startindex`+`@tablerownum`;
  SET `@i`=`@i`+1;
 END WHILE;
 #生成子表 结束
 
 #修改子表属性 添加主键 开始
 SET `@i`  = 1;
 WHILE `@i`<=`@num`    DO
  SET @sqlstr = CONCAT('alter table ',`@tablename`,'_',`@i`,' engine=myisam;');
  PREPARE stmt FROM @sqlstr;
  EXECUTE stmt;
  SET @sqlstr = CONCAT('alter table ',`@tablename`,'_',`@i`,' ADD PRIMARY KEY(`',`@primarykey`,'`);');
  PREPARE stmt FROM @sqlstr;
  EXECUTE stmt;
  SET @sqlstr = CONCAT('alter table ',`@tablename`,'_',`@i`,' MODIFY COLUMN `',`@primarykey`,'` INT NOT NULL AUTO_INCREMENT FIRST ;');
  PREPARE stmt FROM @sqlstr;
  EXECUTE stmt;
  SET `@i`=`@i`+1;
 END WHILE;
#修改子表属性 添加主键 结束 
 
 #将原表重命名 开始
  SET @sqlstr = CONCAT('rename table ',`@tablename`,' to old_',`@tablename`);
  PREPARE stmt FROM @sqlstr;
  EXECUTE stmt;
 #将原表重命名 结束

#拼接子表字符串 开始  
SET `@j`=0;
WHILE `@j`<`@num` DO
 SET `@j`= `@j`+1;
 IF(`@tabnames` IS NULL)
 THEN
    SET `@tabnames`=CONCAT(`@tablename`,'_',`@j`);
 ELSE
    SET `@tabnames`=CONCAT(`@tabnames`,',',`@tablename`,'_',`@j`);
 END IF;
END WHILE;
#拼接子表字符串 结束

  #创建总表 开始
  SET @sqlstr = CONCAT('create table ',`@tablename`, ' as select * from old_',`@tablename`,' limit 0');
  PREPARE stmt FROM @sqlstr;
  EXECUTE stmt;
  SET @sqlstr = CONCAT('alter table ',`@tablename`,' engine=MRG_MYISAM');
  PREPARE stmt FROM @sqlstr;
  EXECUTE stmt;
  SET @sqlstr = CONCAT('ALTER TABLE ',`@tablename`,' UNION=(',`@tabnames`,')');
  PREPARE stmt FROM @sqlstr;
  EXECUTE stmt;
  SET @sqlstr = CONCAT('alter table ',`@tablename`,' INSERT_METHOD=LAST');
  PREPARE stmt FROM @sqlstr;
  EXECUTE stmt;
   #创建总表 结束  
  
END$$

DELIMITER ;