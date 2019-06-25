SELECT 
INV_ID
, ORDEM
, PC
, SUM(CASE WHEN KI = 1 THEN VALOR END) KI
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 4 THEN VALOR ELSE 0 END) APRIL
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 5 THEN VALOR ELSE 0 END) MAY
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 6 THEN VALOR ELSE 0 END) JUNE
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 7 THEN VALOR ELSE 0 END) JULY
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 8 THEN VALOR ELSE 0 END) AUGUST
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 9 THEN VALOR ELSE 0 END) SEPTEMBER
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 10 THEN VALOR ELSE 0 END) OCTOBER
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 11 THEN VALOR ELSE 0 END) NOVEMBER
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 12 THEN VALOR ELSE 0 END) DECEMBER
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 1 THEN VALOR ELSE 0 END) JANUARY
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 2 THEN VALOR ELSE 0 END) FEBRUARY
, SUM(CASE WHEN KI = 0 AND TO_CHAR(MES,'MM') = 3 THEN VALOR ELSE 0 END) MARCH
, SUM(CASE WHEN KI = 2 THEN VALOR END) KIP
FROM
(
	SELECT
	INV_ID,
	VALOR,
	MES,
	CASE				
		WHEN 
			MES >= PF.DT_INICIO_KI_ANT
			AND MES <= PF.DT_TERMINO_KI_ANT
			THEN 1
		WHEN
			PC = 'ACTUAL' 
			AND MES >= PF.DT_INICIO_KI_ATUAL
			AND MES <= TRUNC($P{data_referencia},'MONTH')
			THEN 0 
		WHEN
			PC != 'ACTUAL'
			AND MES >= PF.DT_INICIO_KI_ATUAL
			AND MES <= PF.DT_TERMINO_KI_ATUAL
			THEN 0
		WHEN
			MES >= PF.DT_INICIO_KI_PROX
			AND MES <= PF.DT_TERMINO_KI_PROX
			THEN 2
		ELSE NULL 
		END KI,
	PC,
	ORDEM
	FROM
	(
		SELECT 
			INVI.ID INV_ID
			, FP_COST.START_DATE MES
			, ROUND(SUM(NVL((FP_COST.FINISH_DATE-FP_COST.START_DATE)*FP_COST.SLICE,0)),2) VALOR
			, 'ORB' PC
			, 10 ORDEM
		FROM
			INV_INVESTMENTS INVI
			LEFT JOIN FIN_PLANS FIN_PLAN ON FIN_PLAN.OBJECT_ID = INVI.ID AND FIN_PLAN.PLAN_TYPE_CODE = 'BUDGET'
			LEFT JOIN FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
			LEFT JOIN ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
			LEFT JOIN ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID
			LEFT JOIN PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
		WHERE 
			FIN_PLAN.ID = (SELECT MAX(FP2.ID) FROM FIN_PLANS FP2 JOIN ODF_CA_COSTPLAN OCCP2 ON FP2.ID = OCCP2.ID WHERE FIN_PLAN.OBJECT_ID = FP2.OBJECT_ID AND OCCP2.hon_orb = 1)
		GROUP BY 
			INVI.ID
			, FP_COST.START_DATE 
			
		UNION
		
		SELECT 
			INVI.ID INV_ID
			, FP_COST.START_DATE MES
			, ROUND(SUM(NVL((FP_COST.FINISH_DATE-FP_COST.START_DATE)*FP_COST.SLICE,0)),2) VALOR
			, 'PLAN' PC
			, 20 ORDEM
		FROM
			INV_INVESTMENTS INVI
			LEFT JOIN FIN_PLANS FIN_PLAN ON FIN_PLAN.OBJECT_ID = INVI.ID AND FIN_PLAN.IS_PLAN_OF_RECORD = 1 AND FIN_PLAN.PLAN_TYPE_CODE = 'BUDGET'
			LEFT JOIN FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
			LEFT JOIN ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
			LEFT JOIN ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID 
			LEFT JOIN PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
		GROUP BY 
			INVI.ID
			, FP_COST.START_DATE 
		
		UNION
		
		SELECT 
			INVI.ID INV_ID
			, TRUNC(PW.TRANSDATE,'MONTH') MES
			, SUM(PV.TOTALCOST) VALOR
			, 'ACTUAL' PC 
			, 30 ORDEM
		FROM
			INV_INVESTMENTS INVI 
			LEFT JOIN PPA_WIP PW ON PW.INVESTMENT_ID = INVI.ID AND PW.STATUS = 0
			LEFT JOIN PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'				
		GROUP BY 
			INVI.ID
			, TRUNC(PW.TRANSDATE,'MONTH')
		
		UNION
		
		SELECT
			INV_ID
			, MES
			, (SUM(REAL)-SUM(ORC)) VALOR
			, 'VAR' PC
			, 40 ORDEM
		FROM 
		(
			SELECT 
				INVI.ID INV_ID
				, FP_COST.START_DATE MES
				, ROUND(SUM(NVL((FP_COST.FINISH_DATE-FP_COST.START_DATE)*FP_COST.SLICE,0)),2) ORC
				, 0 REAL
			FROM
				INV_INVESTMENTS INVI 
				LEFT JOIN FIN_PLANS FIN_PLAN ON INVI.ID = FIN_PLAN.OBJECT_ID AND FIN_PLAN.IS_PLAN_OF_RECORD = 1 AND FIN_PLAN.PLAN_TYPE_CODE = 'BUDGET'
				LEFT JOIN FIN_COST_PLAN_DETAILS FPD on FIN_PLAN.ID = FPD.PLAN_ID
				LEFT JOIN ODF_CA_COSTPLAN OCA_COST on FIN_PLAN.ID = OCA_COST.ID
				LEFT JOIN ODF_SSL_CST_DTL_COST FP_COST ON FPD.ID = FP_COST.PRJ_OBJECT_ID 
				LEFT JOIN PAC_FOS_RESOURCE_CLASS RES_CLASS ON RES_CLASS.ID = FPD.RESOURCE_CLASS_ID
			GROUP BY 
				INVI.ID
				, FP_COST.START_DATE 
					
			UNION
				
			SELECT 
				INVI.ID INV_ID
				, TRUNC(PW.TRANSDATE,'MONTH') MES
				, 0 ORC
				, SUM(PV.TOTALCOST) REAL
			FROM
				INV_INVESTMENTS INVI 
				LEFT JOIN PPA_WIP PW ON PW.INVESTMENT_ID = INVI.ID AND PW.STATUS = 0 
				LEFT JOIN PPA_WIP_VALUES PV ON PW.TRANSNO = PV.TRANSNO AND PV.CURRENCY_TYPE = 'HOME'
			GROUP BY 
			INVI.ID
			, TRUNC(PW.TRANSDATE,'MONTH')			
		)
		GROUP BY 
			INV_ID
			, MES
	)
	LEFT JOIN
	(
		SELECT
			PF.NAME KI,
			(SELECT dt_inicio FROM ODF_CA_HON_PER_FISCAIS WHERE NAME = PF.hon_prev_ki) DT_INICIO_KI_ANT,
			(SELECT dt_termino FROM ODF_CA_HON_PER_FISCAIS WHERE NAME = PF.hon_prev_ki) DT_TERMINO_KI_ANT,
			PF.dt_inicio DT_INICIO_KI_ATUAL,
			PF.dt_termino DT_TERMINO_KI_ATUAL,
			(SELECT dt_inicio FROM ODF_CA_HON_PER_FISCAIS WHERE NAME = PF.hon_next_ki) DT_INICIO_KI_PROX,
			(SELECT dt_termino FROM ODF_CA_HON_PER_FISCAIS WHERE NAME = PF.hon_next_ki) DT_TERMINO_KI_PROX
		FROM
			ODF_CA_HON_PER_FISCAIS PF
		WHERE
			$P{data_referencia} >= PF.dt_inicio AND $P{data_referencia} <= PF.dt_termino
	)PF ON 1=1
)
WHERE
	INV_ID = $P{INV_ID}
	
GROUP BY
	INV_ID
	, PC
	, ORDEM
	
ORDER BY
	ORDEM ASC