-- create a new database db_sql_tutorial
CREATE DATABASE website_analysis;
USE website_analysis;

-- create table 

CREATE TABLE website_analysis.Visitors (
  visitor_id INT(10) NOT NULL AUTO_INCREMENT,
  visitor_ip  VARCHAR(50) NOT NULL UNIQUE,
  visit_timestamp DATETIME,
  country     VARCHAR(50) NOT NULL,
  browser     VARCHAR(50) NOT NULL,
  device_type VARCHAR(50) NOT NULL,
  PRIMARY KEY (visitor_id ));

INSERT INTO website_analysis.visitors (visitor_ip, visit_timestamp, country, browser, device_type)
 VALUES
      ('192.168.0.1','2023-07-01 10:00:00','USA', 'Chrome','Desktop'),
	  ('192.168.0.2','2023-07-01 11:30:00','Germany','Firefox','Mobile'),
	  ('192.168.0.3','2023-07-01 12:45:00','Canada', 'Safari','Laptop');


CREATE TABLE website_analysis.Pages(
 page_id INT(10) NOT NULL AUTO_INCREMENT,
 page_name VARCHAR(50) NOT NULL,
 page_url VARCHAR(50) NOT NULL,
 created_at  DATETIME,
PRIMARY KEY (page_id)
);

INSERT INTO website_analysis.pages (page_name, page_url, created_at)
 VALUES 
      ('Home','/home','2023-07-01'),
	  ('Products','/products','2023-07-01'),
	  ('About','/about','2023-07-01');

CREATE TABLE website_analysis.Page_Views (
   view_id INT(10) PRIMARY KEY,
   visitor_id INT(10),
   page_id INT,
   view_timestamp DATETIME,
   FOREIGN KEY (visitor_id) REFERENCES Visitors(visitor_id),
   FOREIGN KEY (page_id) REFERENCES Pages(page_id)
);

INSERT INTO website_analysis.page_views (view_id, visitor_id, page_id, view_timestamp)
VALUES
     (1,1,1,'2023-07-01 10:05:00 '),
     (2,2,1,'2023-07-01 11:35:00 '),
     (3,1,2,'2023-07-01 10:10:00 '),
     (4,2,2,'2023-07-01 11:40:00 '),
     (5,3,1,'2023-07-01 12:50:00 ');

CREATE TABLE website_analysis.Interactions (
  interaction_id INT(10) NOT NULL AUTO_INCREMENT,
  visitor_id INT(10),
  page_id INT,
  interaction_type VARCHAR(50) NOT NULL,
  interaction_timestamp DATETIME,
  PRIMARY KEY (interaction_id),
  FOREIGN KEY (visitor_id) REFERENCES Visitors(visitor_id),
  FOREIGN KEY (page_id) REFERENCES Pages(page_id)
);

INSERT INTO website_analysis.Interactions (visitor_id, page_id, interaction_type, interaction_timestamp)
VALUES
  (1, 1, 'Click', '2023-07-01 10:07:00'),
  (1, 1, 'Scroll', '2023-07-01 10:09:00'),
  (2, 2, 'Click', '2023-07-01 11:42:00'),
  (3, 1, 'Click', '2023-07-01 12:53:00');
