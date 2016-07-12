 --日志数量
    select w.recordman,COUNT(*) cnt from rcgz_worklog w WHERE to_char(w.recordtime,'MM') = '07'
                       group by w.recordman;
              --事件管理        
                       WITH tab_casetj AS (
                      SELECT C.SJLXDL, C.DJR, COUNT(*) CNT
                        FROM NG_CASECHECKIN C
                       WHERE C.AJLX = 1
                         AND TO_CHAR(C.DJTIME, 'MM') = '07'
                         AND C.SJLXDL IN (181, 182, 201, 202)
                       GROUP BY C.SJLXDL, C.DJR)
                       SELECT DJR,max(DECODE(SJLXDL,181,cnt,0)) 治安安全隐患,max(DECODE(SJLXDL,182,cnt,0)) 矛盾纠纷,max(DECODE(SJLXDL,201,cnt,0)) 民生服务,max(DECODE(SJLXDL,202,cnt,0)) 举报投诉
                        FROM tab_casetj GROUP BY DJR;
                        --更新数量
              SELECT O.USERID, COUNT(*) CNT
                FROM LOG_OPERATIONLOG O
               WHERE TO_CHAR(O.OPERTIME, 'MM') = '07'
               GROUP BY O.USERID;
