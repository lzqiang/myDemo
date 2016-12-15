---同步时间表
create table SYS_LAST_SYNC_TIME
(
  ID            NUMBER,
  SYNC_TIME     VARCHAR2(50),
  COMMENTS      VARCHAR2(1000),
  DELAY_MINUTES NUMBER
);
insert into sys_last_sync_time(id,sync_time,comments,delay_minutes) values(1,'2013-06-14 11:03:55','Synchronize From SQLServer 's DB GPSDB.',-5);
insert into sys_last_sync_time(id,sync_time,comments,delay_minutes) values(2,'2013-06-14 10:59:59','Synchronize From Oracle's DB keligpsdba.',-35);
commit;

---临时表
create global temporary table TMP_GPS_B_DCYSZ
(
  CARD_ID            NUMBER not null,
  ORG_ID             VARCHAR2(10),
  BUILD_SITE_ID      VARCHAR2(10),
  BUILD_COMPANY_NAME VARCHAR2(100),
  COMPANY_ID         VARCHAR2(10),
  CAR_ID             NUMBER,
  CARRY_START_DATE   DATE,
  CARRY_END_DATE     DATE,
  DRAVEL_START_TIME  VARCHAR2(6),
  DRAVEL_END_TIME    VARCHAR2(6),
  DRAVEL_ID          NUMBER,
  DUMP_ID            NUMBER,
  OPT_DATE           DATE,
  RMK                VARCHAR2(500),
  STATUS_ID          CHAR(2)
)
on commit preserve rows;

create global temporary table TMP_GPS_B_JZGD
(
  BUILD_SITE_ID   VARCHAR2(10) not null,
  BUILD_SITE_NAME VARCHAR2(100),
  ORG_ID          VARCHAR2(10),
  RMK             VARCHAR2(500),
  CRT_DATE        DATE
)
on commit preserve rows;

create global temporary table TMP_SYNC_CAR_PATH
(
  LONGIT        VARCHAR2(20) not null,
  LONGIT_POS    VARCHAR2(1),
  LAT           VARCHAR2(20) not null,
  OFFSET_LONGIT VARCHAR2(20),
  LAT_POS       VARCHAR2(1),
  VEHICLE_CODE  VARCHAR2(50) not null,
  REPORT_TIME   VARCHAR2(25) not null,
  OFFSET_LAT    VARCHAR2(20),
  STANDBY1      VARCHAR2(256),
  STANDBY2      VARCHAR2(256),
  STANDBY3      VARCHAR2(256),
  SPEED         VARCHAR2(8),
  DERIVE_POS    VARCHAR2(3),
  MILE_COUNT    VARCHAR2(20),
  OFF_SUCCESS   CHAR(4),
  STATUS        VARCHAR2(40)
)
on commit preserve rows;

create global temporary table TMP_SYNC_CAR_O
(
  VEHICLE_CODE  VARCHAR2(50) not null,
  SIM_CODE      VARCHAR2(20),
  TERMINAL_CODE VARCHAR2(20),
  IS_ONLINE     CHAR(1)
)
on commit preserve rows;

create global temporary table TMP_SYNC_GPS_POSITION
(
  TERMID    NUMBER,
  LON       NUMBER,
  LAT       NUMBER,
  DIRECTION NUMBER,
  SPEED     NUMBER,
  RECVTIME  DATE,
  MILEAGE   NUMBER,
  ISALARM   NUMBER,
  ALARMDATA RAW(200)
)
on commit preserve rows;

create global temporary table TMP_SYNC_CAR
(
  CARNUM        VARCHAR2(20) not null,
  TERMID        VARCHAR2(20) not null,
  CREATETIME    DATE not null,
  MODIFYTIME    DATE,
  SIMCARD       VARCHAR2(20) not null,
  VEHICLECOLOR  VARCHAR2(50),
  SETUPDATE     DATE not null,
  ENDSERVERDATE DATE,
  COMPANY_ID    NUMBER
)
on commit preserve rows;

/***********************************************************************************/
---同步tb_card,tb_build_site
create or replace procedure sync_card is
begin
  
  execute immediate 'truncate table tmp_gps_b_dcysz';
  insert into tmp_gps_b_dcysz
  select bm card_id,
         b.XZQH_BM org_id,
         b.jzgd_bm build_site_id,
         jsdw_mc build_company_name,
         b.ysdw_bm company_id,
         t.car_id car_id,
         yykssj carry_start_date,
         yyjssj carry_end_date,
         yykssj_1 dravel_start_time,
         yyjssj_1 dravel_end_time,
         xslx_bm dravel_id,
         qdd_bm dump_id,
         bzsj opt_date,
         bz rmk,
         decode(b.is_ty,0,1,2) status_id
    from gps_b_dcysz@sync b
    left join tb_car t
      on t.car_num = cphm;
   commit;
   
merge into tb_card t
using tmp_gps_b_dcysz s
on (t.card_id = s.card_id and t.car_id=s.car_id)
when not matched then
  insert
    (t.card_id,
     t.org_id,
     t.build_site_id,
     t.build_company_name,
     t.company_id,
     t.car_id,
     t.carry_start_date,
     t.carry_end_date,
     t.dravel_start_time,
     t.dravel_end_time,
     t.dravel_id,
     t.dump_id,
     t.opt_date,
     t.rmk,
     t.status_id)
  values
    (s.card_id,
     s.org_id,
     s.build_site_id,
     s.build_company_name,
     s.company_id,
     s.car_id,
     s.carry_start_date,
     s.carry_end_date,
     s.dravel_start_time,
     s.dravel_end_time,
     s.dravel_id,
     s.dump_id,
     s.opt_date,
     s.rmk,
     s.status_id);
 commit;
 ------------------
 execute immediate 'truncate table tmp_gps_b_jzgd';
 insert into tmp_gps_b_jzgd
  select bm build_site_id, mc build_site_name, xzqh_bm org_id, bz rmk, cjsj crt_date from gps_b_jzgd@sync;
 commit;
 
 merge into tb_build_site t
using tmp_gps_b_jzgd s
on (t.build_site_id = s.build_site_id)
when not matched then
  insert
    (t.build_site_id, t.build_site_name, t.org_id, t.rmk, t.crt_date)
  values
    (s.build_site_id, s.build_site_name, s.org_id, s.rmk, s.crt_date);
commit;
 
end sync_card;
/

---老库同步程序tb_car_path,tb_car_path_his,tb_car,tb_car_break
create or replace procedure SYNC_CAR_PATH is
v_last_sync_time varchar2(50);
--v_suffix varchar2(10);
--v_new_suffix varchar2(10);
--v_sql varchar2(4000);
begin
  --last synchronized time point
  select to_char(
                 to_date(sync_time, 'yyyy-mm-dd hh24:mi:ss') +
                 delay_minutes / 1440,
                 'yyyy-mm-dd hh24:mi:ss') into v_last_sync_time
    from sys_last_sync_time where id=2;
  
  --begin synchronize
  execute immediate 'truncate table tmp_sync_car_path';
  insert into tmp_sync_car_path 
  select * from gps_t_clwzls_b@sync
   where report_time >= v_last_sync_time;
   
  /*
  execute immediate 'truncate table tmp_gps_t_cljbxx_b';
  insert into tmp_gps_t_cljbxx_b(vehicle_code,terminal_code)
  select vehicle_code,terminal_code from gps_t_cljbxx_b@sync;
  */
  
  --1.syncronize into current table
/*  execute immediate 'truncate table tb_car_path2';
  insert into tb_car_path2
    (car_break_id, gps_num, longitude_point, dimensionality_point, speede,
     direction, record_time, mile_count,  carsouretype)
    select SEQ_CAR_BREAK.NEXTVAL,
           --b.terminal_code,
           b.gps_num,
           a.longit,
           a.lat,
           a.speed,
           a.derive_pos,
           to_date(a.report_time, 'yyyy-mm-dd hh24:mi:ss'),
           a.mile_count,
           1 carsouretype
      from tmp_sync_car_path a, --tmp_gps_t_cljbxx_b b
           tb_car b
     where a.vehicle_code = b.car_num;*/
     
  --1.update current table     
   merge into tb_car_path a
   using (/*select *
            from (select b.gps_num,
                         a.longit,
                         a.lat,
                         a.speed,
                         a.derive_pos,
                         to_date(a.report_time, 'yyyy-mm-dd hh24:mi:ss') record_time,
                         a.mile_count,
                         1 carsouretype,
                         row_number() over(partition by b.gps_num order by a.report_time desc) rn
                    from tmp_sync_car_path a, tb_car b
                   where a.vehicle_code = b.car_num)
             where rn = 1*/
         select *
            from (select b.gps_num,
                         a.longit,
                         a.lat,
                         a.speed,
                         a.derive_pos,
                         to_date(a.report_time, 'yyyy-mm-dd hh24:mi:ss') record_time,
                         a.mile_count,
                         1 carsouretype,
                         nvl(t.offset_lng,0) offset_lng,
                         nvl(t.offset_lat,0) offset_lat,
                         row_number() over(partition by b.gps_num order by a.report_time desc) rn
                    from tmp_sync_car_path a, tb_car b,tb_offset t
                   where a.vehicle_code = b.car_num and round(a.longit,3)=t.lng(+) and round(a.lat,3)=t.lat(+))
             where rn = 1
         ) b
     on (a.gps_num = b.gps_num /*and a.carsouretype = b.carsouretype*/)
   when matched then
   update
      set a.longitude_point      = b.longit,
          a.dimensionality_point = b.lat,
          a.speede               = b.speed,
          a.direction            = b.derive_pos,
          a.record_time          = b.record_time,
          a.mile_count           = b.mile_count,
          a.offset_lng           = b.offset_lng,
          a.offset_lat           = b.offset_lat,
          a.update_time          = b.record_time
   when not matched then
   insert
     (a.car_break_id, a.gps_num, a.longitude_point, a.dimensionality_point, a.speede,
      a.direction, a.record_time, a.mile_count, a.carsouretype, a.offset_lng, a.offset_lat,a.update_time)
   values
     (seq_car_break.nextval, b.gps_num, b.longit, b.lat, b.speed,
      b.derive_pos, b.record_time, b.mile_count, b.carsouretype, b.offset_lng, b.offset_lat,b.record_time);
   commit;
   
   --2.syncronize into history table
   /*merge into tb_car_path_his2 a
   using tb_car_path2 b
      on (a.gps_num = b.gps_num and 
          a.record_time = to_number(to_char(b.record_time, 'yyyymmddhh24miss')) and 
          a.carsouretype = b.carsouretype)
   when not matched then
   insert(car_break_id, gps_num, longitude, latitude, speed,
     direction, record_time, mile_count, carsouretype)
   values(b.car_break_id, b.gps_num, b.longitude_point, b.dimensionality_point, b.speede,
     b.direction, to_number(to_char(b.record_time, 'yyyymmddhh24miss')), b.mile_count, b.carsouretype);*/
   merge into tb_car_path_his a
   using (/*select b.gps_num,
                 a.longit,
                 a.lat,
                 a.speed,
                 a.derive_pos,
                 to_number(translate(a.report_time, 'F:- ', 'F')) record_time,
                 a.mile_count,
                 1 carsouretype
            from tmp_sync_car_path a, tb_car b
           where a.vehicle_code = b.car_num*/
          select b.gps_num,
                 a.longit,
                 a.lat,
                 a.speed,
                 a.derive_pos,
                 to_number(translate(a.report_time, 'F:- ', 'F')) record_time,
                 a.mile_count,
                 1 carsouretype,
                 nvl(t.offset_lng,0) offset_lng,
                 nvl(t.offset_lat,0) offset_lat
            from tmp_sync_car_path a, tb_car b, tb_offset t
           where a.vehicle_code = b.car_num and round(a.longit,3)=t.lng(+) and round(a.lat,3)=t.lat(+)
         ) b
   on (a.gps_num = b.gps_num and a.record_time = b.record_time and a.carsouretype = b.carsouretype)
   when not matched then
   insert
     (a.car_break_id, a.gps_num, a.longitude, a.latitude, a.speed,
      a.direction, a.record_time, a.mile_count, a.carsouretype, a.offset_lng, a.offset_lat)
   values
     (seq_car_break.nextval, b.gps_num, b.longit, b.lat, b.speed,
      b.derive_pos, b.record_time, b.mile_count, b.carsouretype, b.offset_lng, b.offset_lat);
   commit;
  
   --update last synchronized time point
   update sys_last_sync_time a set a.sync_time=nvl((select max(report_time) from tmp_sync_car_path),a.sync_time)
   where a.id=2;
   commit;

----------------------------------------------------------------------------------------------------------------------------------  
   --3.update online and offline
   /*update tb_car a
      set a.online_flag =
          (select case
                  when b.carsouretype = 2 and
                      (sysdate - b.record_time) * 24 * 60 > 5 then
                   0
                  when (b.carsouretype = 1 or b.carsouretype is null) and
                       (sysdate - b.record_time) * 24 * 60 > 5 then
                   0
                  when b.record_time is null then
                   0
                  else
                   1
                end
           from tb_car_path b
          where a.gps_num = b.gps_num and rownum=1)
    where exists (select 1 from tb_car_path c where a.gps_num = c.gps_num);*/
   execute immediate 'truncate table tmp_sync_car_o';
   insert into tmp_sync_car_o
   select vehicle_code,sim_code,terminal_code,is_online from gps_t_cljbxx_b@sync;
   commit;

   update tb_car a
      set a.online_flag =
          (select is_online from tmp_sync_car_o b where a.car_num = b.vehicle_code)
    where (a.carsouretype = 1 or a.carsouretype is null)
      and exists
          (select 1 from tmp_sync_car_o c where a.car_num = c.vehicle_code);
    commit;
 --------------------------------------------------------------------------------------------------------------------
   --4.speed alarm
   merge into tb_car_break a
   using (/*select b.car_id,
                 1 car_break_type,
                 a.report_time,
                 a.lat,
                 a.longit,
                 a.derive_pos,
                 '车辆超速报警' remark,
                 a.speed
            from tmp_sync_car_path a, tb_car b
           where a.vehicle_code = b.car_num
             and substr(a.status, 22, 1) = 1*/
          select car_id, 1 car_break_type, report_time, lat, longit, derive_pos,
                 '车辆超速报警' remark, speed,build_site_id,company_id,
                 case when (flag = 0 and rept between dravel_start_time and dravel_end_time)
                        or (flag = 1 and ((rept between dravel_start_time and '23:59') or (rept between '00:00' and dravel_end_time)))
                       then 1
                       else 0 end dravel_flag,
                 offset_lng,offset_lat
            from (select b.car_id,
                         a.report_time,
                         a.lat,
                         a.longit,
                         a.derive_pos,
                         a.speed,
                         c.build_site_id,
                         c.company_id,
                         c.dravel_start_time,
                         c.dravel_end_time,
                         substr(a.report_time, 12, 5) rept,
                         case when c.dravel_start_time > c.dravel_end_time then 1 else 0 end as flag,
                         nvl(t.offset_lng,0) offset_lng,
                         nvl(t.offset_lat,0) offset_lat
                    from tmp_sync_car_path a, tb_car b, tb_card c, tb_offset t
                   where a.vehicle_code = b.car_num
                     and b.car_id = c.car_id
                     and trunc(sysdate) between c.carry_start_date and c.carry_end_date
                     and c.status_id=1
                     and a.speed >60
                     and round(a.longit,3)=t.lng(+) and round(a.lat,3)=t.lat(+))
           --where (flag = 0 and rept between dravel_start_time and dravel_end_time)
              --or (flag = 1 and ((rept between dravel_start_time and '23:59') or (rept between '00:00' and dravel_end_time)))   
      ) b
   on (a.car_id = b.car_id and 
       a.car_break_type = b.car_break_type and 
       a.car_break_time = to_date(b.report_time, 'yyyy-mm-dd hh24:mi:ss'))
   when not matched then
   insert
     (a.car_break_id, a.car_id, a.car_break_type, a.car_break_time, a.dimensionality_point,
      a.longitude_point, a.direction, a.remark, a.speed,a.build_site_id,a.company_id,a.dravel_flag,
      a.offset_lng, a.offset_lat)
   values
     (seq_car_break.nextval, b.car_id, b.car_break_type, to_date(b.report_time, 'yyyy-mm-dd hh24:mi:ss'),
      b.lat, b.longit, b.derive_pos, b.remark, b.speed,b.build_site_id,b.company_id,b.dravel_flag,
      b.offset_lng, b.offset_lat);
   commit;
   
   --5.offline alarm
   merge into tb_car_break t
   using (
          select car_id,3 car_break_type,record_time,dimensionality_point,
                 longitude_point,direction,remark,speede,build_site_id,company_id,
                 case when (flag = 0 and to_char(sysdate, 'hh24:mi') between dravel_start_time and dravel_end_time) 
                        or (flag = 1 and ((to_char(sysdate, 'hh24:mi') between dravel_start_time and '23:59') or (to_char(sysdate, 'hh24:mi') between '00:00' and dravel_end_time)))
                      then 1
                      else 0 end dravel_flag,
                 offset_lng,offset_lat
            from (select a.car_id,
                         c.record_time,
                         c.dimensionality_point,
                         c.longitude_point,
                         c.direction,
                         '设备在有效期间和运行时间内没有开启' remark,
                         c.speede,
                         b.build_site_id,
                         b.company_id,
                         b.dravel_start_time,
                         b.dravel_end_time,
                         case when b.dravel_start_time > b.dravel_end_time then 1 else 0 end as flag,
                         c.offset_lng,c.offset_lat
                    from tb_car a, tb_card b, tb_car_path c
                   where a.car_id = b.car_id
                     and a.gps_num = c.gps_num
                     and b.carry_start_date <= trunc(sysdate)
                     and b.carry_end_date >= trunc(sysdate)
                     and b.status_id=1
                     and (a.carsouretype = 1 or a.carsouretype is null)
                     and a.online_flag = 0)
           --where (flag = 0 and to_char(sysdate, 'hh24:mi') between dravel_start_time and dravel_end_time) 
              --or (flag = 1 and ((to_char(sysdate, 'hh24:mi') between dravel_start_time and '23:59') or (to_char(sysdate, 'hh24:mi') between '00:00' and dravel_end_time)))
         ) s
      on (t.car_id=s.car_id and 
          t.car_break_type=s.car_break_type and 
          t.car_break_time=s.record_time)
    when not matched then
      insert(t.car_break_id,t.car_id,t.car_break_type,t.car_break_time,t.dimensionality_point,
             t.longitude_point,t.direction,t.remark,t.speed,t.build_site_id,t.company_id,t.dravel_flag,
             t.offset_lng, t.offset_lat)
      values(seq_car_break.nextval,s.car_id,s.car_break_type,s.record_time,s.dimensionality_point,
             s.longitude_point,s.direction,s.remark,s.speede,s.build_site_id,s.company_id,s.dravel_flag,
             s.offset_lng, s.offset_lat);
   commit;
end SYNC_CAR_PATH;
/

---新库同步程序tb_car_path,tb_car_path_his,tb_car,tb_company_car_rel,tb_car_break
create or replace procedure sync_gps_position is
v_last_sync_time varchar2(50);
v_suffix varchar2(10);
v_new_suffix varchar2(10);
--v_sql varchar2(4000);
begin
  --last synchronized time point
  select to_char(
                 to_date(sync_time, 'yyyy-mm-dd hh24:mi:ss') +
                 delay_minutes / 1440,
                 'yyyy-mm-dd hh24:mi:ss') into v_last_sync_time
    from sys_last_sync_time where id=1;
  --source table suffix:2013_05_9 2013_05_10
  v_suffix:=translate(substr(v_last_sync_time,1,8)||to_number(substr(v_last_sync_time,9,2)),'-','_');
  
  --begin synchronize
  execute immediate 'truncate table tmp_sync_gps_position';
  execute immediate '
  insert into tmp_sync_gps_position(termid, lon, lat, direction, speed, recvtime, mileage, isalarm, alarmdata)
    select "TermID",
           "lon",
           "lat",
           "Direction",
           "Speed",
           "gpstime",
           "Mileage",
           "IsAlarm",
           "AlarmData"
      from gps_position_'||v_suffix||'@gpsdb
     where "gpstime" >=
           to_date('''||v_last_sync_time||''', ''yyyy-mm-dd hh24:mi:ss'')';
    --dbms_output.put_line(v_sql);
   --begin with a new source table
   if(trunc(sysdate)>trunc(to_date(v_last_sync_time,'yyyy-mm-dd hh24:mi:ss'))) then
     v_new_suffix:=to_char(trunc(to_date(v_last_sync_time,'yyyy-mm-dd hh24:mi:ss')+1),'yyyy-mm-dd');
     v_new_suffix:=translate(substr(v_new_suffix,1,8)||to_number(substr(v_new_suffix,9,2)),'-','_');
     begin
     execute immediate '
     insert into tmp_sync_gps_position(termid, lon, lat, direction, speed, recvtime, mileage, isalarm, alarmdata)
      select "TermID",
             "lon",
             "lat",
             "Direction",
             "Speed",
             "gpstime",
             "Mileage",
             "IsAlarm",
             "AlarmData"
        from gps_position_'||v_new_suffix||'@gpsdb
       where "gpstime" >=
             to_date('''||v_new_suffix||' 00:00:00'', ''yyyy-mm-dd hh24:mi:ss'')';
      exception when others then
        null;
      end;
   end if;
   
   execute immediate 'truncate table tmp_sync_car';
   insert into tmp_sync_car
   select tn."CarNum"         carnum,
          tn."TermID"         termid,
          tn."CreateTime"     createtime,
          tn."ModifyTime"     modifytime,
          tn."simcard"        simcard,
          tn."VehicleColor"   vehiclecolor,
          tn."SetupDate"      setupdate,
          tn."EndServiceDate" endserverdate,
          tn.company_id
     from (select a.*, c.company_id, b."id"
             from gps_term@gpsdb a
             left join gps_group@gpsdb b
               on a."GroupID" = b."id"
             left join tb_company c
               on c.company_name = b."GroupName") tn;
----------------------------------------------------------------------------------------------------------
   --0.synchronize car info from new db server
   merge into tb_car t
   using tmp_sync_car s
      on (t.car_num = s.carnum)
   when matched then
     update
       set t.black_status    = (case when t.carsouretype=2 then t.black_status else 0 end),
           t.gps_num         = (case when t.carsouretype=2 then t.gps_num else s.termid end),--s.termid,
           t.crt_date        = (case when t.carsouretype=2 then t.crt_date else s.createtime end),--s.createtime,
           t.mod_date        = (case when t.carsouretype=2 then t.mod_date else s.modifytime end),--s.modifytime,
           t.online_flag     = (case when t.carsouretype=2 then t.online_flag else 1 end),--1,
           t.sim_code        = (case when t.carsouretype=2 then t.sim_code else s.simcard end),--s.simcard,
           t.color           = (case when t.carsouretype=2 then t.color else s.vehiclecolor end),--s.vehiclecolor,
           t.guarantee_start = (case when t.carsouretype=2 then t.guarantee_start else s.setupdate end),--s.setupdate,
           t.guarantee_end   = (case when t.carsouretype=2 then t.guarantee_end else s.endserverdate end),--s.endserverdate,
           t.borrow_status   = (case when t.carsouretype=2 then t.borrow_status else 0 end),--0,
           t.gps_status      = (case when t.carsouretype=2 then t.gps_status else 1 end),--1,
           t.carsouretype    = (case when t.carsouretype=2 then t.carsouretype else 2 end),--2,
           t.status_id       = (case when t.carsouretype=2 then t.status_id else 0 end)--0
   when not matched then
     insert
       (t.car_id, t.car_num, t.black_status, t.gps_num, t.crt_date, t.mod_date,
        t.online_flag, t.sim_code, t.color, t.guarantee_start, t.guarantee_end,
        t.borrow_status, t.gps_status, t.carsouretype, t.status_id)
     values
       (seq_car.nextval, s.carnum, 0, s.termid, s.createtime, s.modifytime,
        1, s.simcard, s.vehiclecolor, s.setupdate, s.endserverdate,
        0, 1, 2, 0);
     commit;
      
   merge into tb_company_car_rel t
   using (select a.carnum, a.company_id, c.car_id
            from tmp_sync_car a
            left join tb_car c
              on a.carnum = c.car_num) s
      on (t.company_id = s.company_id and t.car_id = s.car_id)
    when not matched then
      insert
        (t.company_car_rel, t.car_id, t.company_id, t.status_id, t.crt_date)
      values
        (seq_car.nextval, s.car_id, s.company_id, 1, sysdate);
   commit;
   --0.initial new car's path info
   insert into tb_car_path(car_break_id,gps_num,carsouretype)
   select seq_car_break.nextval, a.gps_num,a.carsouretype
     from tb_car a
     left join tb_car_path b
       on a.gps_num = b.gps_num
    where b.gps_num is null and a.gps_num is not null;
   commit;
   --1.update current table  
   merge into tb_car_path a
   using (/*select *
            from (select a.*,2 carsouretype,
                         row_number()over(partition by termid order by recvtime desc) rn
                    from tmp_sync_gps_position a)
           where rn = 1*/
          select *
            from (select a.*,
                         2 carsouretype,
                         nvl(t.offset_lng,0) offset_lng,
                         nvl(t.offset_lat,0) offset_lat,
                         row_number()over(partition by termid order by recvtime desc) rn
                    from tmp_sync_gps_position a, tb_offset t
                   where round(a.lon,3)=t.lng(+) and round(a.lat,3)=t.lat(+))
           where rn = 1
         ) b
   on (a.gps_num = to_char(b.termid) /*and a.carsouretype = b.carsouretype*/)
   when matched then
   update
     set a.longitude_point      = (case when b.lon<>0 and b.lat<>0 then b.lon else a.longitude_point end),--b.lon,
         a.dimensionality_point = (case when b.lon<>0 and b.lat<>0 then b.lat else a.dimensionality_point end),--b.lat,
         a.speede               = (case when b.lon<>0 and b.lat<>0 then b.speed else a.speede end),--b.speed,
         a.direction            = (case when b.lon<>0 and b.lat<>0 then to_char(b.direction) else a.direction end),--b.direction,
         a.record_time          = (case when b.lon<>0 and b.lat<>0 then b.recvtime else a.record_time end),--b.recvtime,
         a.mile_count           = (case when b.lon<>0 and b.lat<>0 then to_char(b.mileage) else a.mile_count end),--b.mileage,
         a.offset_lng           = (case when b.lon<>0 and b.lat<>0 then b.offset_lng else a.offset_lng end),--b.offset_lng,
         a.offset_lat           = (case when b.lon<>0 and b.lat<>0 then b.offset_lat else a.offset_lat end),--b.offset_lat,
         a.update_time          = b.recvtime
   when not matched then
     insert
       (a.car_break_id, a.gps_num, a.longitude_point, a.dimensionality_point, a.speede,
        a.direction, a.record_time, a.mile_count, a.carsouretype, a.offset_lng, a.offset_lat,a.update_time)
     values
       (seq_car_break.nextval, b.termid, b.lon, b.lat, b.speed,
        b.direction, b.recvtime, b.mileage, b.carsouretype, b.offset_lng, b.offset_lat,b.recvtime);
   commit;
   
   --2.syncronize into history table
   merge into tb_car_path_his a
   using (/*select a.*,2 carsouretype
            from tmp_sync_gps_position a*/
          select a.*,
                 2 carsouretype,
                 nvl(t.offset_lng,0) offset_lng,
                 nvl(t.offset_lat,0) offset_lat
            from tmp_sync_gps_position a,  tb_offset t
           where round(a.lon,3)=t.lng(+) and round(a.lat,3)=t.lat(+)
         ) b
   on (a.gps_num = to_char(b.termid) and a.record_time = to_number(to_char(b.recvtime, 'yyyymmddhh24miss')) and a.carsouretype = b.carsouretype)
   when not matched then
     insert
       (a.car_break_id, a.gps_num, a.longitude, a.latitude, a.speed,
        a.direction, a.record_time, a.mile_count, a.carsouretype, a.offset_lng, a.offset_lat)
     values
       (seq_car_break.nextval, b.termid, b.lon, b.lat, b.speed,
        b.direction, to_number(to_char(b.recvtime, 'yyyymmddhh24miss')), b.mileage, b.carsouretype, b.offset_lng, b.offset_lat);
   commit;
   
   --update last synchronized time point
   update sys_last_sync_time a set a.sync_time=nvl((select to_char(max(recvtime),'yyyy-mm-dd hh24:mi:ss') from tmp_sync_gps_position),a.sync_time)
   where a.id=1;
   commit;
----------------------------------------------------------------------------------------------------------------------------------  
   --3.update online and offline
   update tb_car a
   set a.online_flag =
       (select case
                 when b.carsouretype = 2 and
                      (sysdate - b.update_time/*b.record_time*/) * 24 * 60 > 5 then
                  0
                 when (b.carsouretype = 1 or b.carsouretype is null) and
                      (sysdate - b.update_time/*b.record_time*/) * 24 * 60 > 5 then
                  0
                 when /*b.record_time*/b.update_time is null then
                  0
                 else
                  1
               end
          from tb_car_path b
         where a.gps_num = b.gps_num  and rownum=1)
   where exists (select 1 from tb_car_path c where a.gps_num = c.gps_num)
     and a.carsouretype=2;
   commit;
-----------------------------------------------------------------------------------------------------------------------
   --4.speed alarm
   merge into tb_car_break a
   using (/*select b.car_id,
                 1 car_break_type,
                 a.recvtime,
                 a.lat,
                 a.lon,
                 a.direction,
                 '车辆超速报警' remark,
                 a.speed
            from tmp_sync_gps_position a,tb_car b
           where to_char(a.termid)=b.gps_num and a.isalarm=1*/
          select car_id, 1 car_break_type, recvtime, lat, lon, direction,
                 '车辆超速报警' remark, speed,build_site_id,company_id,
                 case when (flag = 0 and rept between dravel_start_time and dravel_end_time)
                        or (flag = 1 and ((rept between dravel_start_time and '23:59') or (rept between '00:00' and dravel_end_time)))
                       then 1
                       else 0 end dravel_flag,
                 offset_lng, offset_lat
            from (select b.car_id,
                         a.recvtime,
                         a.lat,
                         a.lon,
                         a.direction,
                         a.speed,
                         c.build_site_id,
                         c.company_id,
                         c.dravel_start_time,
                         c.dravel_end_time,
                         to_char(recvtime, 'hh24:mi') rept,
                         case when c.dravel_start_time > c.dravel_end_time then 1 else 0 end as flag,
                         t.offset_lng, t.offset_lat
                    from tmp_sync_gps_position a, tb_car b, tb_card c, tb_offset t
                   where to_char(a.termid) = b.gps_num
                     and b.car_id = c.car_id
                     and c.status_id=1
                     and trunc(sysdate) between c.carry_start_date and c.carry_end_date
                     and (a.alarmdata like '%0807030000000932%' or a.alarmdata like '%0807000061D278%')
                     and round(a.lon,3)=t.lng(+) and round(a.lat,3)=t.lat(+))
              --where (flag = 0 and rept between dravel_start_time and dravel_end_time)
                 --or (flag = 1 and ((rept between dravel_start_time and '23:59') or (rept between '00:00' and dravel_end_time))) 
         ) b
   on (a.car_id = b.car_id and 
       a.car_break_type = b.car_break_type and 
       a.car_break_time = recvtime)
   when not matched then
     insert
       (a.car_break_id, a.car_id, a.car_break_type, a.car_break_time, a.dimensionality_point,
        a.longitude_point, a.direction, a.remark, a.speed,a.build_site_id,a.company_id,a.dravel_flag,
        a.offset_lng, a.offset_lat)
     values
       (seq_car_break.nextval, b.car_id, b.car_break_type, b.recvtime,
        b.lat, b.lon, b.direction, b.remark, b.speed,b.build_site_id,b.company_id,b.dravel_flag,
        b.offset_lng, b.offset_lat);
   commit;
   
   --5.offline alarm
   merge into tb_car_break t
   using (
          select car_id,3 car_break_type,record_time,dimensionality_point,
                 longitude_point,direction,remark,speede,build_site_id,company_id,
                 case when (flag = 0 and to_char(sysdate, 'hh24:mi') between dravel_start_time and dravel_end_time) 
                        or (flag = 1 and ((to_char(sysdate, 'hh24:mi') between dravel_start_time and '23:59') or (to_char(sysdate, 'hh24:mi') between '00:00' and dravel_end_time)))
                      then 1
                      else 0 end dravel_flag,
                 offset_lng, offset_lat
            from (select a.car_id,
                         c.record_time,
                         c.dimensionality_point,
                         c.longitude_point,
                         c.direction,
                         '设备在有效期间和运行时间内没有开启' remark,
                         c.speede,
                         b.build_site_id,
                         b.company_id,
                         b.dravel_start_time,
                         b.dravel_end_time,
                         case when b.dravel_start_time > b.dravel_end_time then 1 else 0 end as flag,
                         c.offset_lng, c.offset_lat
                    from tb_car a, tb_card b, tb_car_path c
                   where a.car_id = b.car_id
                     and a.gps_num = c.gps_num
                     and b.status_id=1
                     and b.carry_start_date <= trunc(sysdate)
                     and b.carry_end_date >= trunc(sysdate)
                     and a.carsouretype = 2
                     and a.online_flag = 0)
           --where (flag = 0 and to_char(sysdate, 'hh24:mi') between dravel_start_time and dravel_end_time) 
              --or (flag = 1 and ((to_char(sysdate, 'hh24:mi') between dravel_start_time and '23:59') or (to_char(sysdate, 'hh24:mi') between '00:00' and dravel_end_time)))
         ) s
      on (t.car_id=s.car_id and 
          t.car_break_type=s.car_break_type and 
          t.car_break_time=s.record_time)
    when not matched then
      insert(t.car_break_id,t.car_id,t.car_break_type,t.car_break_time,t.dimensionality_point,
             t.longitude_point,t.direction,t.remark,t.speed,t.build_site_id,t.company_id,t.dravel_flag,
             t.offset_lng,t.offset_lat)
      values(seq_car_break.nextval,s.car_id,s.car_break_type,s.record_time,s.dimensionality_point,
             s.longitude_point,s.direction,s.remark,s.speede,s.build_site_id,s.company_id,s.dravel_flag,
             s.offset_lng,s.offset_lat);
   commit;
   
end sync_gps_position;
/

---维护存储过程
create or replace procedure sys_maintenance is
  v_cnt number;
begin
  --创建3天的分区
  for c in (select 'P'||to_char(sysdate+level-1,'yyyymmdd') v_partition,
                   to_number(to_char(sysdate+level,'yyyymmdd')||'000000') v_key 
              from dual connect by level <=3) loop
    select count(*) into v_cnt 
      from user_segments 
     where segment_name='TB_CAR_PATH_HIS' and partition_name=c.v_partition;
    if (v_cnt = 0) then
      execute immediate 'alter table TB_CAR_PATH_HIS add partition '||c.v_partition||' values less than('||c.v_key||') tablespace path_his';
    end if;  
  end loop;

end sys_maintenance;
/
/**************************************************************************************************************************************************/
---创建相关定时JOB
begin
  sys.dbms_scheduler.create_job(job_name            => 'MUCKCAR.JOB_MAINTENANCE',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'sys_maintenance',
                                start_date          => to_date('14-06-2013 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Daily;Interval=1;ByHour=00;ByMinute=00;BySecond=01',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Auto add table's partion everyday.');
end;
/

begin
  sys.dbms_scheduler.create_job(job_name            => 'MUCKCAR.JOB_PURGE_LOGS',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin dbms_scheduler.purge_log; end;',
                                start_date          => to_date('14-06-2013 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Daily;Interval=7;ByHour=00;ByMinute=00;BySecond=01',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Purge log history once a week.');
end;
/

begin
  sys.dbms_scheduler.create_job(job_name            => 'MUCKCAR.JOB_SYNC_CARD',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'sync_card',
                                start_date          => to_date('14-06-2013 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Daily;Interval=1;ByHour=00;ByMinute=00;BySecond=02',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Synchronize tb_card');
end;
/

begin
  sys.dbms_scheduler.create_job(job_name            => 'MUCKCAR.JOB_SYNC_CAR_PATH',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'sync_car_path',
                                start_date          => to_date('14-06-2013 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Minutely;Interval=5;',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Synchronize car position informations from Oracle's DB ORCL');
end;
/

begin
  sys.dbms_scheduler.create_job(job_name            => 'MUCKCAR.JOB_SYNC_GPS_POSITION',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'SYNC_GPS_POSITION',
                                start_date          => to_date('14-06-2013 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Minutely;Interval=1;',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Synchronize gps position informations from SQLServer's DB GPSDB');
end;
/