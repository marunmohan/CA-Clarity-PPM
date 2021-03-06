SELECT

BU.NAME BU
, NPV_ANO.ANO
, SUM(NPV_ANO.TOTAL_COST) TOTAL_COST
, SUM(NPV_ANO.TOTAL_BENEFIT) TOTAL_REVENUE
, SUM(NPV_ANO.TOTAL_BENEFIT - NPV_ANO.TOTAL_COST) NPV

FROM INV_INVESTMENTS INVI 
JOIN ODF_CA_INV OCINV ON INVI.ID = OCINV.ID
JOIN CMN_LOOKUPS_V BU ON BU.LOOKUP_CODE = OCINV.SAN_BU AND BU.LOOKUP_TYPE = 'SAN_LKP_BU' AND BU.LANGUAGE_CODE = 'en'
JOIN
(SELECT
ID
, TO_CHAR(DATA,'YYYY') ANO
, SUM(COST) TOTAL_COST
, SUM(BENEFIT) TOTAL_BENEFIT

FROM

(SELECT

CASE WHEN COST_TABLE.ID IS NULL
THEN BENEFIT_TABLE.ID ELSE COST_TABLE.ID END ID
, CASE WHEN COST_TABLE.DATA IS NULL
THEN BENEFIT_TABLE.DATA ELSE COST_TABLE.DATA END DATA
, NVL(COST_TABLE.COST,0) COST
, NVL(BENEFIT_TABLE.BENE,0) BENEFIT

FROM
(SELECT
INVI.ID

, NVL(ROUND((COST.FINISH_DATE-COST.START_DATE)*COST.SLICE,2),0) COST  
, COST.START_DATE DATA

FROM INV_INVESTMENTS INVI
JOIN ODF_CA_INV OCINV ON INVI.ID = OCINV.ID
JOIN INV_PROJECTS INVP ON INVI.ID = INVP.PRID
LEFT JOIN CMN_LOOKUPS_V PHASE ON OCINV.san_proj_phase = PHASE.LOOKUP_CODE 
  AND PHASE.LOOKUP_TYPE='SAN_LKP_PROJ_PHASE' 
  AND PHASE.LANGUAGE_CODE = 'en'
LEFT JOIN SRM_RESOURCES MAN ON MAN.USER_ID = INVI.MANAGER_ID
LEFT JOIN CMN_LOOKUPS_V BU ON BU.LOOKUP_CODE = OCINV.SAN_BU 
  AND BU.LOOKUP_TYPE = 'SAN_LKP_BU' 
  AND BU.LANGUAGE_CODE = 'en'
LEFT JOIN CMN_LOOKUPS_V STAGE ON STAGE.LOOKUP_CODE = OCINV.SAN_STAGE_GATE
	AND STAGE.LOOKUP_TYPE = 'SAN_LKP_STAGE_GATE'
	AND STAGE.LANGUAGE_CODE = 'en'
LEFT JOIN FIN_PLANS COSTPLAN ON COSTPLAN.OBJECT_ID = INVI.ID AND COSTPLAN.PLAN_TYPE_CODE = 'FORECAST' AND COSTPLAN.IS_PLAN_OF_RECORD = 1
LEFT JOIN FIN_COST_PLAN_DETAILS COSTPLAND ON COSTPLAND.PLAN_ID = COSTPLAN.ID
LEFT JOIN ODF_SSL_CST_DTL_COST COST ON COST.PRJ_OBJECT_ID = COSTPLAND.ID

LEFT JOIN FIN_PLANS BENEPLAN ON COSTPLAN.BENEFIT_PLAN_ID = BENEPLAN.ID 



WHERE INVI.IS_ACTIVE = 1
AND INVP.IS_TEMPLATE = 0
) COST_TABLE

FULL OUTER JOIN 

(SELECT
INVI.ID

, NVL(ROUND((BENE.FINISH_DATE-BENE.START_DATE)*BENE.SLICE,2),0) BENE  
, BENE.START_DATE DATA

FROM INV_INVESTMENTS INVI
JOIN ODF_CA_INV OCINV ON INVI.ID = OCINV.ID
JOIN INV_PROJECTS INVP ON INVI.ID = INVP.PRID
LEFT JOIN CMN_LOOKUPS_V PHASE ON OCINV.san_proj_phase = PHASE.LOOKUP_CODE 
  AND PHASE.LOOKUP_TYPE='SAN_LKP_PROJ_PHASE' 
  AND PHASE.LANGUAGE_CODE = 'en'
LEFT JOIN SRM_RESOURCES MAN ON MAN.USER_ID = INVI.MANAGER_ID
LEFT JOIN CMN_LOOKUPS_V BU ON BU.LOOKUP_CODE = OCINV.SAN_BU 
  AND BU.LOOKUP_TYPE = 'SAN_LKP_BU' 
  AND BU.LANGUAGE_CODE = 'en'
LEFT JOIN CMN_LOOKUPS_V STAGE ON STAGE.LOOKUP_CODE = OCINV.SAN_STAGE_GATE
	AND STAGE.LOOKUP_TYPE = 'SAN_LKP_STAGE_GATE'
	AND STAGE.LANGUAGE_CODE = 'en'
LEFT JOIN FIN_PLANS COSTPLAN ON COSTPLAN.OBJECT_ID = INVI.ID AND COSTPLAN.PLAN_TYPE_CODE = 'FORECAST' AND COSTPLAN.IS_PLAN_OF_RECORD = 1
LEFT JOIN FIN_PLANS BENEPLAN ON COSTPLAN.BENEFIT_PLAN_ID = BENEPLAN.ID 
LEFT JOIN FIN_BENEFIT_PLAN_DETAILS BENEPLAND ON BENEPLAND.PLAN_ID = BENEPLAN.ID
LEFT JOIN ODF_SSL_BFT_DTL_BFT BENE ON BENE.PRJ_OBJECT_ID = BENEPLAND.ID

WHERE INVI.IS_ACTIVE = 1
AND INVP.IS_TEMPLATE = 0
) BENEFIT_TABLE
ON COST_TABLE.ID = BENEFIT_TABLE.ID
AND COST_TABLE.DATA = BENEFIT_TABLE.DATA

ORDER BY ID) 

WHERE DATA IS NOT NULL

GROUP BY

ID
, TO_CHAR(DATA,'YYYY')) NPV_ANO 
ON INVI.ID = NPV_ANO.ID

--WHERE NPV_ANO = 

GROUP BY
BU.NAME 
, NPV_ANO.ANO