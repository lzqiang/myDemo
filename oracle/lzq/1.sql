                      --关注人群：
                      SELECT C.HJXXDZ,
                             COUNT(X.CYID) 刑释解教人员,
                             COUNT(X1.CYID) 社区矫正人员,
                             COUNT(X2.CYID) 信访重点人员,
                             COUNT(X3.CYID) 邪教人员,
                             COUNT(X4.CYID) 精神病人员,
                             COUNT(X5.CYID) 吸毒人员,
                             COUNT(X6.CYID) 重点青少年,
                             COUNT(X7.CYID) 危险品从业人员,
                             COUNT(Y1.CYID) 空巢信息,
                             COUNT(Y2.CYID) 残障信息,
                             COUNT(Y3.CYID) 优抚对象信息,
                             COUNT(Y4.CYID) 低保人员,
                             COUNT(Y5.CYID) 生殖保健信息,
                             COUNT(Y6.CYID) 就业失业服务,
                             COUNT(Y7.CYID) 伤残军人信息,
                             COUNT(Y8.CYID) 城乡医疗,
                             COUNT(Y9.CYID) 艾滋病患者
                        FROM QYXX_CPJTXX C
                        LEFT JOIN SYS_JGXXB J
                          ON C.HJXXDZ = J.JGID
                        LEFT JOIN (SELECT cyid FROM WQWW_XSJJRY WHERE cyid IS NOT NULL) X
                          ON C.CYID = X.CYID
                        LEFT JOIN (SELECT cyid FROM QYXX_SJZDRYXX WHERE cyid IS NOT NULL) X1
                          ON C.CYID = X1.CYID
                        LEFT JOIN (SELECT cyid FROM QYXX_XFZDRY WHERE cyid IS NOT NULL) X2
                          ON C.CYID = X2.CYID
                        LEFT JOIN (SELECT cyid FROM QYXX_ZJXYXX WHERE cyid IS NOT NULL) X3
                          ON C.CYID = X3.CYID
                        LEFT JOIN (SELECT cyid FROM QYXX_WXJSBRYXX WHERE cyid IS NOT NULL) X4
                          ON C.CYID = X4.CYID
                        LEFT JOIN (SELECT cyid FROM QYXX_XDRYXX WHERE cyid IS NOT NULL) X5
                          ON C.CYID = X5.CYID
                        LEFT JOIN (SELECT cyid FROM QYXX_ZDQSNRYXX WHERE cyid IS NOT NULL) X6
                          ON C.CYID = X6.CYID
                        LEFT JOIN (SELECT cyid FROM QYXX_WXPCYRY WHERE cyid IS NOT NULL) X7
                          ON C.CYID = X7.CYID
                        LEFT JOIN (SELECT cyid FROM qyxx_kcxx WHERE cyid IS NOT NULL) Y1
                          ON C.CYID = Y1.CYID
                        LEFT JOIN (SELECT cyid FROM qyxx_cjry WHERE cyid IS NOT NULL) Y2
                          ON C.CYID = Y2.CYID
                        LEFT JOIN (SELECT cyid FROM qyxx_yfdxwh WHERE cyid IS NOT NULL) Y3
                          ON C.CYID = Y3.CYID
                        LEFT JOIN (SELECT cyid FROM qyxx_dbry WHERE cyid IS NOT NULL) Y4
                          ON C.CYID = Y4.CYID
                        LEFT JOIN (SELECT cyid FROM qyxx_cyszbjxx WHERE cyid IS NOT NULL) Y5
                          ON C.CYID = Y5.CYID
                        LEFT JOIN (SELECT cyid FROM qyxx_jyfwxx WHERE cyid IS NOT NULL) Y6
                          ON C.CYID = Y6.CYID
                        LEFT JOIN (SELECT cyid FROM qyxx_scjrxx WHERE cyid IS NOT NULL) Y7
                          ON C.CYID = Y7.CYID
                        LEFT JOIN (SELECT cyid FROM qyxx_cxyljz WHERE cyid IS NOT NULL) Y8
                          ON C.CYID = Y8.CYID
                        LEFT JOIN (SELECT cyid FROM xz_azbhz WHERE cyid IS NOT NULL) Y9
                          ON C.CYID = Y9.CYID
                       WHERE J.JGBM LIKE '4290040' || '%'
                      --and to_char(x.djsj,'MM') = '07'
                       GROUP BY C.HJXXDZ
