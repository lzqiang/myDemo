 --��־����
    select w.recordman,COUNT(*) cnt from rcgz_worklog w WHERE to_char(w.recordtime,'MM') = '07'
                       group by w.recordman;
              --�¼�����        
                       WITH tab_casetj AS (
                      SELECT C.SJLXDL, C.DJR, COUNT(*) CNT
                        FROM NG_CASECHECKIN C
                       WHERE C.AJLX = 1
                         AND TO_CHAR(C.DJTIME, 'MM') = '07'
                         AND C.SJLXDL IN (181, 182, 201, 202)
                       GROUP BY C.SJLXDL, C.DJR)
                       SELECT DJR,max(DECODE(SJLXDL,181,cnt,0)) �ΰ���ȫ����,max(DECODE(SJLXDL,182,cnt,0)) ì�ܾ���,max(DECODE(SJLXDL,201,cnt,0)) ��������,max(DECODE(SJLXDL,202,cnt,0)) �ٱ�Ͷ��
                        FROM tab_casetj GROUP BY DJR;
                        --��������
              SELECT O.USERID, COUNT(*) CNT
                FROM LOG_OPERATIONLOG O
               WHERE TO_CHAR(O.OPERTIME, 'MM') = '07'
               GROUP BY O.USERID;
