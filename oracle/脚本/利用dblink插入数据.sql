--建dblink
create public database link dmz63
connect to zwsafe identified by "zwsafe2016"
using '192.168.88.13:1521/wtqsafe';

说明：都是目标库的用户名 密码 和数据库地址 密码用双引号 是因为会自动变成大写 可能在使用dblink的时候 登录不上

INSERT INTO sys_xqxxb VALUE SELECT * FROM sys_xqxxb@yd2lt

INSERT INTO sys_ldwhb VALUE SELECT * FROM sys_ldwhb@yd2lt

INSERT INTO qyxx_kpxxb VALUE SELECT * FROM qyxx_kpxxb@yd2lt

INSERT INTO qyxx_cpjtxx VALUE SELECT * FROM qyxx_cpjtxx@yd2lt

INSERT INTO qyxx_kpryglb VALUE SELECT * FROM qyxx_kpryglb@yd2lt

INSERT INTO qyxx_kpryglbhjry VALUE SELECT * FROM qyxx_kpryglbhjry@yd2lt

INSERT INTO sys_deptinfo VALUE SELECT * FROM sys_deptinfo@yd2lt

INSERT INTO sys_userinfo VALUE SELECT u.*,'','','' FROM sys_userinfo@yd2lt u

INSERT INTO sys_secuser VALUE SELECT * FROM sys_secuser@yd2lt 

CREATE TABLE sys_role20141030 AS SELECT * FROM sys_role@yd2lt



SELECT COUNT(*) FROM sys_ldwhb@yd2lt
SELECT COUNT(*) FROM sys_secuser

SELECT * FROM sys_role20141030
