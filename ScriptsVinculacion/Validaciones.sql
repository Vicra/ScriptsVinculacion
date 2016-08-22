SELECT projectItem.ProjectId, 
		periodItem.Number, 
		periodItem.Year, 
        userItem.AccountId , 
        userItem.Name, 
        projectItem.BeneficiarieOrganization, 
        hourItem.Amount,
        sectionProjectItem.Id as ProjectId,
        sectionItem.Id as SectionId
    
FROM vinculacion.hours hourItem

INNER JOIN vinculacion.users userItem on hourItem.User_Id = userItem.Id
INNER JOIN vinculacion.sectionprojects sectionProjectItem on hourItem.SectionProject_Id = sectionProjectItem.Id
INNER JOIN vinculacion.sections sectionItem on sectionProjectItem.Section_Id = sectionItem.Id
INNER JOIN vinculacion.periods periodItem on sectionItem.Period_Id = periodItem.Id
INNER JOIN vinculacion.projects projectItem on sectionProjectItem.Project_Id = projectItem.Id;

SELECT periodItem.Number, periodItem.Year, sum(hourItem.Amount) as totalHours
FROM vinculacion.hours hourItem

INNER JOIN vinculacion.users userItem on hourItem.User_Id = userItem.Id
INNER JOIN vinculacion.sectionprojects sectionProjectItem on hourItem.SectionProject_Id = sectionProjectItem.Id
INNER JOIN vinculacion.sections sectionItem on sectionProjectItem.Section_Id = sectionItem.Id
INNER JOIN vinculacion.periods periodItem on sectionItem.Period_Id = periodItem.Id
INNER JOIN vinculacion.classes classItem on sectionItem.Class_Id = classItem.Id

GROUP BY periodItem.Number, periodItem.Year
ORDER BY periodItem.Year,periodItem.Number ASC;

SELECT facultyItem.Id, facultyItem.Name, sum(hourItem.Amount) as HoursByFaculty
FROM vinculacion.hours hourItem
INNER JOIN vinculacion.users userItem on hourItem.User_Id = userItem.Id
INNER JOIN vinculacion.majors majorItem on userItem.Major_Id = majorItem.Id
INNER JOIN vinculacion.faculties facultyItem on majorItem.Faculty_Id = facultyItem.Id
GROUP BY facultyItem.Id, facultyItem.Name;

SELECT majorItem.Name, sum(hourItem.Amount) as HoursByMajor
FROM vinculacion.hours hourItem
INNER JOIN vinculacion.users userItem on hourItem.User_Id = userItem.Id
INNER JOIN vinculacion.majors majorItem on userItem.Major_Id = majorItem.Id
GROUP BY majorItem.Name;

SELECT userItem.Name,  sum(hourItem.Amount) as HoursByProfessor
FROM vinculacion.hours hourItem
INNER JOIN vinculacion.sectionprojects sectionProjectItem on hourItem.SectionProject_Id = sectionProjectItem.Id
INNER JOIN vinculacion.sections sectionItem on sectionProjectItem.Section_Id = sectionItem.Id
INNER JOIN vinculacion.users userItem on sectionItem.User_Id = userItem.Id
GROUP BY userItem.Name;