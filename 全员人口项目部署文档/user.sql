-- Create the user 
create user wis
  identified by wis
  default tablespace wis
  temporary tablespace TEMP
  profile DEFAULT
  quota unlimited on wis;
-- Grant/Revoke role privileges 
grant connect to wis with admin option;
grant dba to wis with admin option;
-- Grant/Revoke system privileges 
grant create any sequence to wis with admin option;
grant create any table to wis with admin option;
grant delete any table to wis with admin option;
grant insert any table to wis with admin option;
grant select any table to wis with admin option;
grant unlimited tablespace to wis with admin option;
grant update any table to wis with admin option;
