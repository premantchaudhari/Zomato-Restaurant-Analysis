use zomatodata;

create table zomato (restaurantid int,restaurantname varchar(255),country_code varchar(10),city varchar(255),address varchar(255),Locality varchar(255) 
,LocalityVerbose varchar(250) ,Longitude float ,Latitude float ,Cuisines varchar(255) ,Currency varchar(255) ,Has_Table_booking varchar(255) 
,Has_Online_delivery varchar(255) ,Is_delivering_now varchar(255) ,Switch_to_order_menu varchar(255) ,Price_range varchar(255), Votes varchar(255) 
,Average_Cost_for_two varchar(255) ,Rating varchar(255) ,Datekey_Opening varchar(255));

LOAD DATA INFILE 'zomato.csv'
INTO TABLE zomato
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select count(*) from zomato;

UPDATE zomato SET Datekey_Opening = REPLACE(Datekey_Opening, '/', '-') WHERE Datekey_Opening LIKE '%/%';
alter table zomato modify column Datekey_Opening date;

UPDATE zomato
SET Datekey_Opening = DATE_FORMAT(STR_TO_DATE(Datekey_Opening, '%d-%m-%Y'), '%Y-%m-%d');
select * from zomato;


select * from zomato;

create table countries (CountryCode int , Countryname varchar(255));

LOAD DATA INFILE 'countries.csv'
INTO TABLE countries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from countries;





