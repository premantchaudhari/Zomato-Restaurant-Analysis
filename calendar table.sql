use zomatodata;

drop table if exists calendar_table;
create table calendar_table (
    id                  integer primary key,  
    db_date             date not null,
    year                integer not null,
    month               integer not null, 
    day                 integer not null, 
    quarter             integer not null,
    week                integer not null, 
    weekday_no          integer not null,
    weekday_name        varchar(9) not null, 
    month_name          varchar(9) not null, 
    financial_month     char(3) not null,
    financial_quarter   integer not null,
    unique td_ymd_idx (year,month,day),
    unique td_dbdate_idx (db_date)
) engine=myisam;

drop procedure if exists fill_date_dimension;
delimiter //
create procedure fill_date_dimension(in startdate date,in stopdate date)
begin
    declare currentdate date;
    set currentdate = startdate;
    while currentdate < stopdate do
        insert into calendar_table (id, db_date, year, month, day, quarter, week, weekday_no, weekday_name, month_name, financial_month, financial_quarter) values (
            year(currentdate)*10000+month(currentdate)*100 + day(currentdate),
            currentdate,
            year(currentdate),
            month(currentdate),
            day(currentdate),
            quarter(currentdate),
            weekofyear(currentdate),
		dayofweek(currentdate),
            date_format(currentdate,'%w'),
            date_format(currentdate,'%m'),
           case when month(currentdate) >= 4 then month(currentdate) - 3 else month(currentdate) + 9 end,
            case when month(currentdate) in (1, 2, 3) then 4 when month(currentdate) in (4, 5, 6) then 1 
                when month(currentdate) in (7, 8, 9) then 2 else 3 end
        );
        set currentdate = adddate(currentdate,interval 1 day);
    end while;
end
//
delimiter ;

truncate table calendar_table;

call fill_date_dimension('2010-01-01', '2028-12-31');

optimize table calendar_table;

select * from calendar_table;
