-- Create the user 
create user ylqyrk
  identified by ylqyrk
  default tablespace qyrk
  temporary tablespace TEMP
  profile DEFAULT
  quota unlimited on qyrk;
-- Grant/Revoke role privileges 
grant connect to ylqyrk with admin option;
grant dba to ylqyrk with admin option;
-- Grant/Revoke system privileges 
grant create any sequence to ylqyrk with admin option;
grant create any table to ylqyrk with admin option;
grant delete any table to ylqyrk with admin option;
grant insert any table to ylqyrk with admin option;
grant select any table to ylqyrk with admin option;
grant unlimited tablespace to ylqyrk with admin option;
grant update any table to ylqyrk with admin option;
