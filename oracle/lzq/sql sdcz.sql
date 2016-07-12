
SELECT y.casenum, MIN(y.njzrq) FROM(
SELECT k.casenum,n.jzrq AS njzrq FROM ng_casecheckin k LEFT JOIN ng_handle n ON n.casenum =k.casenum WHERE 1=1 
)y GROUP BY y.casenum


CREATE TABLE  ng_casecheckin_bak20141129 AS SELECT y.*,l.njzrq FROM  ng_casecheckin y LEFT JOIN (SELECT y.casenum, MIN(y.njzrq) AS njzrq FROM(
SELECT k.casenum,n.jzrq AS njzrq FROM ng_casecheckin k LEFT JOIN ng_handle n ON n.casenum =k.casenum WHERE 1=1 
)y GROUP BY y.casenum) l ON l.casenum=y.casenum

UPDATE ng_casecheckin_bak20141129 n SET n.jzrq = n.njzrq

CREATE TABLE ng_casecheckin AS SELECT * FROM ng_casecheckin_bak20141129
SELECT * FROM  ng_casecheckin_bak20141129


SELECT djtime,clqx,c.casestatus FROM  ng_casecheckin c WHERE jzrq IS NULL

SELECT * FROM ng_casecheckin WHERE to_char(jzrq,'yyyy') ='0114' FOR UPDATE 

UPDATE ng_casecheckin m SET m.jzrq = (m.djtime+5) WHERE m.jzrq IS NULL 
