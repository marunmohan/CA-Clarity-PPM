SELECT DISTINCT 
   INV.CODE COD_PROJ
 , CONVERT(VARCHAR(10),INV.CREATED_DATE ,120) DATA_ABERTURA
 , GER_PROJ.FIRST_NAME + ' ' + GER_PROJ.LAST_NAME GER_PROJETO
 , INV.NAME NOME_PROJ
 , CATEG_PROD.NAME CATEGORIA
 , PORTARIA.NAME PORTARIA
 , TIPO_PROJ.NAME TIPO_PROJ
 , UNID_NEG.NAME UNID_NEG
 , STATUS.NAME STATUS
 , ETAPA.NAME ETAPA
 , OBJMOL.HM_MOLEC MOLECULA
 , OBJMOL.NAME CONCENTRACAO
 , OBJMOL.APRESENTACAO APRESENTACAO
 , FORMA_FARMA.NAME FORMA_FARMA
 , OINV.HM_PROD_REFERENCIA PROD_REF
 , OINV.HM_IND_RAC_TERAP RAC_TERAP
 , CONVERT(VARCHAR(MAX),OINV.HM_RACIONAL) RAC
 , CONVERT(FLOAT, OINV.HM_ANO1) INV_ANO1
 , CONVERT(FLOAT, OINV.HM_ANO2) INV_ANO2
 , CONVERT(FLOAT, OINV.HM_ANO3) INV_ANO3
 , CONVERT(FLOAT, OINV.HM_ANO4) INV_ANO4
 , CONVERT(FLOAT, OINV.HM_ANO5) INV_ANO5
 , CONVERT(VARCHAR(MAX),ISNULL(OINV.HM_COM_MKT_GER,'')) COM_MKT
 , CONVERT(FLOAT,MKT.HM_MES_1 + MKT.HM_MES_2 + MKT.HM_MES_3 + MKT.HM_MES_4 + MKT.HM_MES_5 + MKT.HM_MES_6 + 
   MKT.HM_MES_7 + MKT.HM_MES_8 + MKT.HM_MES_9 + MKT.HM_MES_10 + MKT.HM_MES_11 + MKT.HM_MES_12) FCST_ANO_1
 , CONVERT(FLOAT,MKT.HM_ANO_2) FCST_ANO_2
 , CONVERT(FLOAT,MKT.HM_ANO_3) FCST_ANO_3
 , CONVERT(FLOAT,MKT.HM_ANO_4) FCST_ANO_4
 , CONVERT(FLOAT,MKT.HM_ANO_5) FCST_ANO_5
 , CONVERT(FLOAT,MKT.HM_PRECO_FAB) PRECO_FAB
 , CONVERT(FLOAT,MKT.HM_DESCONTO) DESCONTO
 , CARAC_PROD.NAME CARAC_PROD_ADQ
 , CONVERT(VARCHAR(MAX),OINV.COM_CONC_CARAC_PROD) CARAC_PROD_COM 
 , QUAL_EST.NAME QUAL_EST_ADQ
 , CONVERT(VARCHAR(MAX),OINV.COM_QUAL_EST_PUB_FOR) QUAL_EST_COM 
 , RAC_TERAP.NAME RAC_TERAP_ADQ
 , CONVERT(FLOAT,OINV.VLR_RAC_TER) RAC_TERAP_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_RAC_TER) RAC_TERAP_COM 
 , JUST_TEC.NAME JUST_TEC_ADQ
 , CONVERT(FLOAT,OINV.VLR_NEC_JUS) JUST_TEC_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_NECES_JUST) JUST_TEC_COM 
 , ELAB_DOS.NAME ELAB_DOS_ADQ
 , CONVERT(FLOAT,OINV.VLR_ELA_DOS) ELAB_DOS_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_ELAB_DOSSIE) ELAB_DOS_COM 
 , PRE_CLI.NAME PRE_CLI_ADQ
 , CONVERT(FLOAT,OINV.VLR_EST_PRE) PRE_CLI_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_EST_PRE_CLI) PRE_CLI_COM 
 , CLI_FAS1.NAME CLI_FAS1_ADQ
 , CONVERT(FLOAT,OINV.EST_CLI_F1) CLI_FAS1_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_EST_CLI_FAS1) CLI_FAS1_COM 
 , CLI_FAS2.NAME CLI_FAS2_ADQ
 , CONVERT(FLOAT,OINV.VLR_CL_FAS2) CLI_FAS2_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_EST_CLI_FAS2) CLI_FAS2_COM
 , CLI_FAS3.NAME CLI_FAS3_ADQ
 , CONVERT(FLOAT,OINV.VLR_CL_FAS3) CLI_FAS3_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_EST_CLI_FAS3) CLI_FAS3_COM
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_AR_MEDIC) COM_AR_MEDIC
 , CONVERT(VARCHAR(MAX),OINV.HM_TIP_PET_ANVISA) PET_ANVISA
 , CONVERT(VARCHAR(MAX),OINV.HM_DOS_TEC_NEC) DOSSIE_TEC
 , CONVERT(VARCHAR(MAX),OINV.HM_NUM_LOT_PIL) N_LOT_PIL
 , CATEG_PROD.NAME CATEGORIA
 , CONVERT(FLOAT,OINV.HM_CUST_TAX) CUSTOS_TAX
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_CUST_TAX) CUSTOS_TAX_COM 
 , CONVERT(FLOAT,OINV.HM_OUT_CUST) OUTROS_CUSTOS
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_OUT_CUST) OUTROS_CUSTOS_COM
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_GER_AR) COM_AR
 , CONVERT(VARCHAR(MAX),DP.HM_TAM_LOTE_PAD) LOTE_PAD 
 , CONVERT(FLOAT,DP.HM_VLR_TEST_BANC) TESTE_BANC_VLR
 , CONVERT(VARCHAR(MAX),DP.HM_COM_TESTE_BANC) TESTE_BANC_COM 
 , CONVERT(FLOAT,DP.HM_VLR_LOT_PIL) LOTE_PIL_VLR
 , CONVERT(VARCHAR(MAX),DP.HM_COM_TESTE_BANC) LOTE_PIL_COM 
 , CONVERT(FLOAT,DP.HM_VLR_BIOEQ) BIOEQ_VLR
 , CONVERT(VARCHAR(MAX),DP.HM_COM_TESTE_BANC) BIOEQ_COM 
 , CONVERT(FLOAT,DP.VLR_BIO_REL) BIOD_VLR
 , CONVERT(VARCHAR(MAX),DP.HM_COM_TESTE_BANC) BIOD_COM 
 , CONVERT(FLOAT,DP.HM_VLR_FERRAM) FERRA_VLR
 , CONVERT(VARCHAR(MAX),DP.HM_COM_TESTE_BANC) FERRA_COM
 , FORM.HM_COD_SAP_MAT COD_SAP
 , FORM.NAME DESC_MAT
 , CONVERT(FLOAT,FORM.HM_TEOR) TEOR
 , CONVERT(FLOAT,FORM.HM_QTDE) QTD
 , UNID_MED.NAME UNID_MED 
 , CONVERT(FLOAT,OINV.VLR_MET_ANA) MET_ANA_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_DESENV_MET_AN) MET_ANA_COM 
 , CONVERT(FLOAT,OINV.VLR_EQ_FARM) EQV_FARMA_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_EQUIV_FARM) EQV_FARMA_COM 
 , CONVERT(FLOAT,OINV.VLR_ESTAB) ESTAB_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_ESTAB) ESTAB_COM 
 , CONVERT(FLOAT,OINV.VLR_MAT_CON) MAT_CONS_VLR
 , CONVERT(VARCHAR(MAX),OINV.HM_COM_MAT_CONS) MAT_CONS_COM
 
 --INFORMAÇÕES DE LANÇAMENTO
 , INV.NAME NOME_PROJ
 , OINV.HM_MARCA_PROD MARCA
 , CONVERT(FLOAT,MKT_LANC.HM_MES1 + MKT_LANC.HM_MES2 + MKT_LANC.HM_MES3 + MKT_LANC.HM_MES4 + MKT_LANC.HM_MES5 + MKT_LANC.HM_MES6 +
   MKT_LANC.HM_MES7 + MKT_LANC.HM_MES8 + MKT_LANC.HM_MES9 + MKT_LANC.HM_MES10 + MKT_LANC.HM_MES11 + MKT_LANC.HM_MES12) FCST_ANO_1
 , CONVERT(FLOAT,MKT_LANC.HM_ANO2) FCST_ANO_2
 , CONVERT(FLOAT,MKT_LANC.HM_ANO3) FCST_ANO_3
 , CONVERT(FLOAT,MKT_LANC.HM_ANO4) FCST_ANO_4
 , CONVERT(FLOAT,MKT_LANC.HM_ANO5) FCST_ANO_5
 , CONVERT(FLOAT,MKT_LANC.HM_PCO_FAB) PRECO_FAB
 , CONVERT(FLOAT,MKT_LANC.HM_DESC) DESCONTO
 
 --INFORMAÇÕES DE CANCELAMENTO
 , CANCEL_PROJ.NAME CANCELAR_PROJETO
 , CONVERT(VARCHAR(10),ODFPROJ.DATA_CANCELAMENTO ,120) DATA_CANCEL
 , CONVERT(VARCHAR(MAX),OINV.HM_MOTIV_CANCEL) MOTIVO_CANCEL 
 
FROM 
	NIKU.INV_INVESTMENTS INV
	INNER JOIN NIKU.ODF_CA_INV OINV ON OINV.ID = INV.ID
	INNER JOIN NIKU.ODF_CA_PROJECT ODFPROJ ON ODFPROJ.ID = INV.ID       
	INNER JOIN NIKU.INV_PROJECTS IPRJ ON INV.ID = IPRJ.PRID   
	LEFT JOIN NIKU.ODF_MULTI_VALUED_LOOKUPS MUL ON INV.ID = MUL.PK_ID AND MUL.OBJECT = 'PROJECT' AND MUL.ATTRIBUTE = 'HM_UNID_NE'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CATEG_PROD ON CATEG_PROD.LOOKUP_CODE = OINV.HM_CATEG_PROD AND CATEG_PROD.LOOKUP_TYPE = 'HM_CATEG_PROD' AND CATEG_PROD.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V UNID_NEG ON UNID_NEG.LOOKUP_CODE = MUL.VALUE AND UNID_NEG.LOOKUP_TYPE = 'HM_LKP_UNID_NEG'AND UNID_NEG.LANGUAGE_CODE = 'pt'
	LEFT JOIN NIKU.CMN_LOOKUPS_V ETAPA ON ETAPA.LOOKUP_CODE = OINV.HM_ETAP_PROJ AND ETAPA.LOOKUP_TYPE = 'HM_LKP_ETAP_PROJ' AND ETAPA.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V STATUS ON STATUS.LOOKUP_CODE = OINV.HM_STATUS_PROJ AND STATUS.LOOKUP_TYPE = 'HM_STATUS' AND STATUS.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V TIPO_PROJ ON TIPO_PROJ.LOOKUP_CODE = OINV.HM_TIPO_PROJETO AND TIPO_PROJ.LOOKUP_TYPE = 'HM_LKP_TIPO_PROJ' AND TIPO_PROJ.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V PORTARIA ON PORTARIA.ID = OINV.PORTARIA_344 AND PORTARIA.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND PORTARIA.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.SRM_RESOURCES GER_PROJ ON GER_PROJ.USER_ID = INV.MANAGER_ID
	LEFT JOIN NIKU.ODF_CA_HM_SUBOBJT_MOL_CONC OBJMOL ON OBJMOL.ODF_PARENT_ID = INV.ID 
	LEFT JOIN NIKU.CMN_LOOKUPS_V FORMA_FARMA ON FORMA_FARMA.LOOKUP_CODE = OBJMOL.FORMA_FARMA AND FORMA_FARMA.LOOKUP_TYPE = 'HM_FORMA_FARMA' AND FORMA_FARMA.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.ODF_CA_HM_SUBOBJT_INFO_COM MKT ON MKT.ODF_PARENT_ID = INV.ID AND (OBJMOL.HM_MOLEC + ' ' + OBJMOL.NAME + ' ' + OBJMOL.APRESENTACAO + ' ' + FORMA_FARMA.NAME) = MKT.HM_APR
	LEFT JOIN NIKU.CMN_LOOKUPS_V CARAC_PROD ON CARAC_PROD.ID = OINV.ADQ_CONC_CARAC_PROD AND CARAC_PROD.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND CARAC_PROD.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V QUAL_EST ON QUAL_EST.ID = OINV.ADQ_QUAL_EST_PUB_FOR AND QUAL_EST.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND QUAL_EST.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V RAC_TERAP ON RAC_TERAP.ID = OINV.ADQ_RAC_TERAP AND RAC_TERAP.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND RAC_TERAP.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V JUST_TEC ON JUST_TEC.ID = OINV.ADQ_NEC_JUS AND JUST_TEC.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND JUST_TEC.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V ELAB_DOS ON ELAB_DOS.ID = OINV.ADQ_ELA_DOS AND ELAB_DOS.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND ELAB_DOS.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V PRE_CLI ON PRE_CLI.ID = OINV.ADQ_EST_PRE AND PRE_CLI.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND PRE_CLI.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CLI_FAS1 ON CLI_FAS1.ID = OINV.HM_ADQ_EST_CLI_FASE1 AND CLI_FAS1.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND CLI_FAS1.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CLI_FAS2 ON CLI_FAS2.ID = OINV.ADQ_CL_FAS2 AND CLI_FAS2.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND CLI_FAS2.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.CMN_LOOKUPS_V CLI_FAS3 ON CLI_FAS3.ID = OINV.ADQ_CL_FAS3 AND CLI_FAS3.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND CLI_FAS3.LANGUAGE_CODE = 'PT'
	LEFT JOIN NIKU.ODF_CA_HM_SUBOBJT_DES_PROD DP ON DP.ODF_PARENT_ID = INV.ID AND (OBJMOL.HM_MOLEC + ' ' + OBJMOL.NAME + ' ' + OBJMOL.APRESENTACAO + ' ' + FORMA_FARMA.NAME) = DP.HM_APR
	LEFT JOIN NIKU.ODF_CA_HM_SUBOBJT_FORMULACA FORM ON FORM.ODF_PARENT_ID = DP.ID 
	LEFT JOIN NIKU.CMN_LOOKUPS_V UNID_MED ON UNID_MED.LOOKUP_CODE = FORM.HM_UNID_MED AND UNID_MED.LOOKUP_TYPE = 'HM_UNID_MEDID' AND UNID_MED.LANGUAGE_CODE = 'PT'
	FULL OUTER JOIN NIKU.ODF_CA_HM_SUBOBJ_APR_LAN MKT_LANC ON MKT_LANC.ODF_PARENT_ID = INV.ID AND (OBJMOL.HM_MOLEC + ' ' + OBJMOL.NAME + ' ' + OBJMOL.APRESENTACAO + ' ' + FORMA_FARMA.NAME) = MKT_LANC.HM_APR_MARCA
	LEFT JOIN NIKU.CMN_LOOKUPS_V CANCEL_PROJ ON CANCEL_PROJ.ID = OINV.HM_CANCEL_PROJECT AND CANCEL_PROJ.LOOKUP_TYPE = 'PAC_RPT_YESNO' AND CANCEL_PROJ.LANGUAGE_CODE = 'PT'
	
WHERE
	ODFPROJ.PARTITION_CODE = 'HM_INOVAPROD'
	AND OINV.HM_CATEG_PROD NOT IN ('dermo','alimento_funcional','cosmetico','nutraceutico')
	
ORDER BY	
	INV.CODE ASC