-- Combines procedure tables
CREATE OR REPLACE TABLE proced_tbl_combo AS 
SELECT
	pi.row_id,
	pi.subject_id,
	pi.hadm_id,
	pi.icd9_code,
	dp.short_title,
	dp.long_title
FROM
	procedures_icd pi
JOIN d_icd_procedures dp ON pi.icd9_code = dp.icd9_code;