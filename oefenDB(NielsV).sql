DROP TABLE if EXISTS `oefenDB`;

CREATE TABLE `training` (
	`id` int NOT NULL,
	`subject` varchar(50) DEFAULT NULL,
	`duration` int DEFAULT NULL,
PRIMARY KEY (`id`)
);

INSERT INTO `training` VALUES (1, 'titreren', '2'),(2, 'afwegen', 5);

CREATE TABLE `lab_members` (
	`member_id` int NOT NULL,
	`name` varchar(45) DEFAULT NULL,
	`lastname` varchar(45) DEFAULT NULL,
	`birth_date` date DEFAULT NULL,
PRIMARY KEY (`member_id`)
);

INSERT INTO `lab_members` VALUES ('1','Niels','Vanneste','1992-11-26'),('2','Piet','Verkest','1989-04-23'),(3, 'Jos', 'Vermeulen', '1970-04-12');

CREATE TABLE `xtraining` (
	`id` int NOT NULL,
	`member_id` int NOT NULL,
	`training_id` int NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`training_id`) REFERENCES training(`id`),
	FOREIGN KEY (`member_id`) REFERENCES lab_members(`member_id`)
);

INSERT INTO `xtraining` VALUES (1, 1, 1),(2,2,2)(3,3,1);
/*Niels heeft dan een training gehad die als id 1 had (titreren) en Piet heeft afwegen gedaan*/

CREATE TABLE `equipment` (
	`equipment_id` int NOT NULL,
	`name` varchar (45) DEFAULT NULL,
	`manufacturer` varchar (45) DEFAULT NULL,
	`purchase_date` date DEFAULT NULL,
PRIMARY KEY (`equipment_id`)
);

INSERT INTO `equipment` VALUES ('1', 'buret','duran', '2016-11-20'),(2,'erlenmeyer','pyrex','2016-10-23');

CREATE TABLE `experiments` (
	`experiment_id` int NOT NULL,
	`name` varchar (45) DEFAULT NULL,
	`performed_by` int  NOT NULL,
	`equipment_used` int DEFAULT NULL,
	`date` date DEFAULT NULL,
PRIMARY KEY (`experiment_id`),
FOREIGN KEY (`equipment_used`) REFERENCES equipment (`equipment_id`),
FOREIGN KEY (`performed_by`) REFERENCES lab_members (`member_id`)
);

INSERT INTO experiments VALUES (1, 'titratie', 1, 1, '2016-12-14'),(2,'wegen', 2, 2,'2016-11-03'),(3, 'titratie', 3, 1, '2010-05-12');
/*Niels heeft titratie uitgevoerd in december en Piet iets afgewogen*/

CREATE TABLE `results` (
	`id` int NOT NULL,
	`directory` varchar (45) DEFAULT NULL,
	`experiment` int DEFAULT NULL,
	`status` enum ('FAILED','PROGRESS','COMPLETED'),
PRIMARY KEY (`id`),
FOREIGN KEY (`experiment`) REFERENCES experiments (`experiment_id`)
);

INSERT INTO results VALUES (1, 'home/results/titratie',1,'COMPLETED'),(2,'home/resulsts/balans', 2, 'PROGRESS'), (3, 'home/results/titratie', 1, 'FAILED');

