USE universitycareercenter;

/* Create and use a view for all open internships in Raleigh, NC.  Create and name the view, RaleighInternships.  
Run the following to see all tables and your new view.
SHOW FULL Tables;
*/
CREATE VIEW RaleighInternships AS
SELECT Opening.*, Company.CompanyCity
FROM Opening, Company
WHERE CompanyCity = 'Raleigh' AND Opening.CompanyName = Company.CompanyName
ORDER BY OpeningNumber;

SHOW FULL TABLES;
-- From the raleigh internships view, What are the entry-level positions available?

SELECT * 
FROM RaleighInternships
WHERE TypeOfOpening = 'Entry-Level'
ORDER BY OpeningNumber;

CREATE TRIGGER tr_ins_Qualification
BEFORE INSERT ON universitycareercenter.studentqual
FOR EACH ROW 
SET new.StudentQualification = upper(new.StudentQualification);

INSERT INTO universitycareercenter.Studentqual (StudentQualification, StudentID, QualificationDate)
VALUES ('AWS Cloud Certification', 2, curdate());

SELECT *
FROM studentQual
WHERE StudentID = 2;
