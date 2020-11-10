SELECT  tr.id
			, t.ClientId AS recepient_id
            , tr.Pan AS FLD_002 -- PAN
            , '' + TransactionCode + FromAccountType + ToAccountType AS FLD_003
            , tr.TransactionAmount AS FLD_004
            , FORMAT(tr.TransactionDate, 'yyyyMMddHHmmssffff') AS FLD_007
            , tr.Stan AS FLD_011
            , FORMAT(tr.TransactionDate, 'yyyyMMddHHmmssffff') AS FLD_012
            , tr.AcceptorCode AS FLD_026 -- MCC

            , RetrievalData AS FLD_037
            , ApprovalCode AS FLD_038
            , TerminalId AS FLD_041
            , AcceptorId AS FLD_042
            , AcceptorCountry AS FLD_043
			--, tr.*
FROM Transactions tr(NOLOCK)
     LEFT JOIN TreatyCards tc(NOLOCK) ON tc.CardId = tr.CardIdCode
     LEFT JOIN Treaty t(NOLOCK) ON t.Id = tc.TreatyId
/*
     LEFT JOIN Amounts a(NOLOCK) ON a.Id = t.AmountId
*/
WHERE 1 = 1
      AND tr.TransactionAmount > 0
      AND tr.AuthorizationFlag = 1
      AND tr.ActionCode < 100
	  AND tr.TransactionCode = 00
	  AND tr.id > 719300000
	  --AND tr.id > {{LastTransactionID}}
--ORDER BY tr.ID DESC;

/*
SELECT src,fld,val FROM nr_clients.gl_varbase WHERE fld = 'LastTransactionID'; 
SELECT src,fld,val FROM gl_varbase WHERE src = '{{source}}' AND fld = '{{lastTransactionID}}'; 

INSERT INTO gl_varbase(src,fld,val) VALUES ('CARD', 'lastTransactionID', '719300000') 
INSERT INTO gl_varbase(src,fld,val) VALUES ('{{source}}', '{{lastTransactionID}}', '{{value}}') 

UPDATE gl_varbase SET val = '719300000' WHERE src = 'CARD' AND fld = 'lastTransactionID' 
UPDATE gl_varbase SET val = '{{value}}' WHERE src = '{{source}}' AND fld = '{{lastTransactionID}}' 

*/
