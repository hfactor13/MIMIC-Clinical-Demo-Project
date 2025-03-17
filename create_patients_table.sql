-- Combines admissions, patients, and transfer table
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
	p.dod,
	t.eventtype
FROM
	admissions a
JOIN patients p ON
	p.subject_id = a.subject_id
JOIN transfers t ON
	t.subject_id = p.subject_id;

-- Adds age column
ALTER TABLE pat_tbl_combo ADD COLUMN age int;

UPDATE
	pat_tbl_combo
SET
	age = (EXTRACT(DAY
FROM
	(dod - dob))::FLOAT) / 365.25;

-- Removes dob and dod columns
ALTER TABLE pat_tbl_combo DROP COLUMN dob;

ALTER TABLE pat_tbl_combo DROP COLUMN dod;

-- Deletes patients that have an age greater than 100 (outliers)
DELETE
FROM
	pat_tbl_combo
WHERE
	age > 100;

-- Adds age_group bin column
ALTER TABLE pat_tbl_combo ADD COLUMN age_groups VARCHAR(3);

UPDATE
	pat_tbl_combo
SET
	age_groups = CASE 
		WHEN age < 30 THEN '20s'
		WHEN age < 40 THEN '30s'
		WHEN age < 50 THEN '40s'
		WHEN age < 60 THEN '50s'
		WHEN age < 70 THEN '60s'
		WHEN age < 80 THEN '70s'
		WHEN age < 90 THEN '80s'
		ELSE '90s'
	END;