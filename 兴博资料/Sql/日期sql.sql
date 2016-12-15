SELECT G.ORG_NAME,
               I.COMPANY_NAME as CN,
               E.BUILD_SITE_NAME,
               F.COMPANY_NAME,
               B.CAR_ID AS CARID,
               D.CAR_NUM AS CAR_NUM,
               TO_CHAR(B.CAR_BREAK_TIME, 'YYYY-MM-DD HH24:MI') AS BREAK_TIME,
               C.RULE_NAME AS RULE,
               (CASE C.RULE_NAME
                 WHEN '离线报警' THEN
                  0
                 ELSE
                  B.SPEED
               END) AS SPEED,
               B.REMARK AS RMK
          FROM (select t.*,
                       row_number() over(partition by t.car_id, to_char(t.car_break_time, 'yyyymmddhh24mi'), t.car_break_type order by t.speed desc) rn
                  from TB_CAR_BREAK t) B
          LEFT JOIN TB_CAR_ALARM_RULE C
            ON B.CAR_BREAK_TYPE = C.RULE_TYPE
          LEFT JOIN TB_CAR D
            ON B.CAR_ID = D.CAR_ID
          LEFT JOIN TB_BUILD_SITE E
            ON B.BUILD_SITE_ID = E.BUILD_SITE_ID
          LEFT JOIN TB_COMPANY F
            ON B.COMPANY_ID = F.COMPANY_ID
          LEFT JOIN TB_ORG G
            ON E.ORG_ID = G.ORG_ID
          LEFT JOIN TB_CAR_BORROW H
            ON B.CAR_ID = H.CAR_ID
          LEFT JOIN TB_COMPANY I
            ON H.COMPANY_ID = I.COMPANY_ID
         WHERE B.CAR_BREAK_TIME BETWEEN SYSDATE - 60 AND SYSDATE
           and B.BUILD_SITE_ID is not null
           and B.COMPANY_ID is not null
           AND ((to_char(B.CAR_BREAK_TIME ,'yyyy-mm-dd hh24:mi')>= '2013-06-25 00:12') and
                (to_char(B.CAR_BREAK_TIME ,'yyyy-mm-dd hh24:mi') <= '2013-06-25 12:01'))
         group by G.ORG_NAME,
                  I.COMPANY_NAME,
                  E.BUILD_SITE_NAME,
                  F.COMPANY_NAME,
                  B.CAR_ID,
                  D.CAR_NUM,
                  B.CAR_BREAK_TIME,
                  C.RULE_NAME,
                  (CASE C.RULE_NAME
                    WHEN '离线报警' THEN
                     0
                    ELSE
                     B.SPEED
                  END),
                  B.REMARK;
                  

