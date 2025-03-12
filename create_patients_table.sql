-- Combines admissions and patients table
CREATE OR REPLACE TABLE pat_tbl_combo AS 
SELECT
	a.row_id,
	a.subject_id,
	a.hadm_id,
	a.admission_type,
	a.admission_location,
	a.discharge_location,
	a.insurance,
	a.language,
	a.religion,
	a.marital_status,
	a.ethnicity,
	a.diagnosis,
	p.gender,
	p.dob,
	p.dod
FROM
	admissions a
JOIN patients p ON
	p.subject_id = a.subject_id;

-- Adds age column
ALTER TABLE pat_tbl_combo ADD COLUMN age int;
UPDATE pat_tbl_combo SET age = (EXTRACT(DAY FROM (dod - dob))::FLOAT) / 365.25;

-- Removes dob and dod columns
ALTER TABLE pat_tbl_combo DROP COLUMN dob;
ALTER TABLE pat_tbl_combo DROP COLUMN dod;