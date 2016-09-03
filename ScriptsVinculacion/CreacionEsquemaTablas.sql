CREATE TABLE `mivinculacion`.`classes` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` longtext,
  `Code` longtext,
  PRIMARY KEY (`Id`)
);

CREATE TABLE `mivinculacion`.`faculties` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` longtext,
  PRIMARY KEY (`Id`)
);

CREATE TABLE `mivinculacion`.`periods` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Number` int(11) NOT NULL,
  `Year` int(11) NOT NULL,
  `FromDate` longtext,
  `ToDate` longtext,
  `IsCurrent` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`)
);

CREATE TABLE `mivinculacion`.`projects` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProjectId` longtext,
  `Name` longtext,
  `Description` longtext,
  `IsDeleted` tinyint(1) NOT NULL,
  `BeneficiarieOrganization` longtext,
  PRIMARY KEY (`Id`)
);

CREATE TABLE `mivinculacion`.`roles` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` longtext,
  PRIMARY KEY (`Id`)
) ;

CREATE TABLE `mivinculacion`.`majors` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `MajorId` longtext,
  `Name` longtext,
  `Faculty_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Faculty_Id` (`Faculty_Id`) USING HASH,
  CONSTRAINT `FK_Majors_Faculties_Faculty_Id` FOREIGN KEY (`Faculty_Id`) REFERENCES `faculties` (`Id`)
) ;

CREATE TABLE `mivinculacion`.`users` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AccountId` longtext,
  `Name` longtext,
  `Password` longtext,
  `Campus` longtext,
  `Email` longtext,
  `CreationDate` datetime NOT NULL,
  `ModificationDate` datetime NOT NULL,
  `Status` int(11) NOT NULL,
  `Major_Id` bigint(20) DEFAULT NULL,
  `Finiquiteado` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Major_Id` (`Major_Id`) USING HASH,
  CONSTRAINT `FK_Users_Majors_Major_Id` FOREIGN KEY (`Major_Id`) REFERENCES `majors` (`Id`)
) ;

CREATE TABLE `mivinculacion`.`majorusers` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Major_Id` bigint(20) DEFAULT NULL,
  `User_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Major_Id` (`Major_Id`) USING HASH,
  KEY `IX_User_Id` (`User_Id`) USING HASH,
  CONSTRAINT `FK_MajorUsers_Majors_Major_Id` FOREIGN KEY (`Major_Id`) REFERENCES `majors` (`Id`),
  CONSTRAINT `FK_MajorUsers_Users_User_Id` FOREIGN KEY (`User_Id`) REFERENCES `users` (`Id`)
);

CREATE TABLE `mivinculacion`.`projectmajors` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Major_Id` bigint(20) DEFAULT NULL,
  `Project_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Major_Id` (`Major_Id`) USING HASH,
  KEY `IX_Project_Id` (`Project_Id`) USING HASH,
  CONSTRAINT `FK_ProjectMajors_Majors_Major_Id` FOREIGN KEY (`Major_Id`) REFERENCES `majors` (`Id`),
  CONSTRAINT `FK_ProjectMajors_Projects_Project_Id` FOREIGN KEY (`Project_Id`) REFERENCES `projects` (`Id`)
) ;

CREATE TABLE `mivinculacion`.`sections` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` longtext,
  `Class_Id` bigint(20) DEFAULT NULL,
  `Period_Id` bigint(20) DEFAULT NULL,
  `User_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Class_Id` (`Class_Id`) USING HASH,
  KEY `IX_Period_Id` (`Period_Id`) USING HASH,
  KEY `IX_User_Id` (`User_Id`) USING HASH,
  CONSTRAINT `FK_Sections_Classes_Class_Id` FOREIGN KEY (`Class_Id`) REFERENCES `classes` (`Id`),
  CONSTRAINT `FK_Sections_Periods_Period_Id` FOREIGN KEY (`Period_Id`) REFERENCES `periods` (`Id`),
  CONSTRAINT `FK_Sections_Users_User_Id` FOREIGN KEY (`User_Id`) REFERENCES `users` (`Id`)
) ;

CREATE TABLE `mivinculacion`.`sectionusers` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Section_Id` bigint(20) DEFAULT NULL,
  `User_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Section_Id` (`Section_Id`) USING HASH,
  KEY `IX_User_Id` (`User_Id`) USING HASH,
  CONSTRAINT `FK_SectionUsers_Sections_Section_Id` FOREIGN KEY (`Section_Id`) REFERENCES `sections` (`Id`),
  CONSTRAINT `FK_SectionUsers_Users_User_Id` FOREIGN KEY (`User_Id`) REFERENCES `users` (`Id`)
) ;


CREATE TABLE `mivinculacion`.`userroles` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Role_Id` bigint(20) DEFAULT NULL,
  `User_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Role_Id` (`Role_Id`) USING HASH,
  KEY `IX_User_Id` (`User_Id`) USING HASH,
  CONSTRAINT `FK_UserRoles_Roles_Role_Id` FOREIGN KEY (`Role_Id`) REFERENCES `roles` (`Id`),
  CONSTRAINT `FK_UserRoles_Users_User_Id` FOREIGN KEY (`User_Id`) REFERENCES `users` (`Id`)
) ;


CREATE TABLE `mivinculacion`.`sectionprojects` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Project_Id` bigint(20) DEFAULT NULL,
  `Section_Id` bigint(20) DEFAULT NULL,
  `IsApproved` tinyint(1) NOT NULL,
  `Description` longtext,
  `Cost` double NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Project_Id` (`Project_Id`) USING HASH,
  KEY `IX_Section_Id` (`Section_Id`) USING HASH,
  CONSTRAINT `FK_SectionProjects_Projects_Project_Id` FOREIGN KEY (`Project_Id`) REFERENCES `projects` (`Id`),
  CONSTRAINT `FK_SectionProjects_Sections_Section_Id` FOREIGN KEY (`Section_Id`) REFERENCES `sections` (`Id`)
) ;


CREATE TABLE `mivinculacion`.`hours` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Amount` int(11) NOT NULL,
  `SectionProject_Id` bigint(20) DEFAULT NULL,
  `User_Id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_SectionProject_Id` (`SectionProject_Id`) USING HASH,
  KEY `IX_User_Id` (`User_Id`) USING HASH,
  CONSTRAINT `FK_Hours_SectionProjects_SectionProject_Id` FOREIGN KEY (`SectionProject_Id`) REFERENCES `sectionprojects` (`Id`),
  CONSTRAINT `FK_Hours_Users_User_Id` FOREIGN KEY (`User_Id`) REFERENCES `users` (`Id`)
);




select * from mivinculacion.classes;
select * from mivinculacion.faculties;
select * from mivinculacion.projects;
select * from mivinculacion.roles;
select * from mivinculacion.majors;
select * from mivinculacion.users;