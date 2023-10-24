DELIMITER //
CREATE PROCEDURE insertTableC()
BEGIN

insert into table_c (cardnumber, iss, acq, dest, status_a, status_iss, status_acq, status_dest)
SELECT ta.CARDNUMBER,ta.ISS,ta.ACQ,ta.DEST,ta.STATUS,
issOk.status AS status_issuer ,
acqOk.status AS status_acquirer,
destOk.status AS status_dest
from table_a as ta 
left JOIN (
	SELECT * FROM table_b WHERE STATUS =1 AND SOURCE=acq 
) AS acqOk ON acqOk.CARDNUMBER = ta.CARDNUMBER
left JOIN (
	SELECT * FROM table_b WHERE STATUS =1 AND SOURCE=iss 
) AS issOk ON issOk.CARDNUMBER = ta.CARDNUMBER
left JOIN (
	SELECT * FROM table_b WHERE STATUS =1 AND SOURCE=dest 
) AS destOk ON destOk.CARDNUMBER = ta.CARDNUMBER
WHERE 
(ta.ISS = acqOk.ISS AND ta.ACQ = acqOk.ACQ AND ta.DEST = acqOk.DEST) OR 
(ta.ISS = issOk.ISS AND ta.ACQ = issOk.ACQ AND ta.DEST = issOk.DEST) OR 
(ta.ISS = destOk.ISS AND ta.ACQ = destOk.ACQ AND ta.DEST = destOk.DEST);  

    
END
//
DELIMITER
