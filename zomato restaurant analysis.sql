
use zomatodata;
select * from countries;


#Numbers of Resturants based on City and Country.
select countries.countryname,zomato.city,count(restaurantid)no_of_restaurants
from zomato inner join countries 
on zomato.country_code=countries.countrycode 
group by countries.countryname,zomato.city;


#Numbers of Resturants opening based on Year , Quarter , Month.
SELECT td.year,td.quarter,td.month, COUNT(DISTINCT zr.restaurantid) AS num_restaurants FROM calendar_table td 
LEFT JOIN zomatodata.zomato zr ON td.db_date = zr.Datekey_Opening GROUP BY td.year, td.quarter, td.month ORDER BY td.year, td.quarter, td.month;


#Count of Resturants based on Average Ratings.
select case when rating <=2 then "0-2" when rating <=3 then "2-3" when rating <=4 then "3-4" when Rating<=5 then "4-5" end rating_range,count(restaurantid) 
from zomato 
group by rating_range 
order by rating_range;


#Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets
select case when price_range=1 then "0-500" when price_range=2 then "500-3000" when Price_range=3 then "3000-10000" when Price_range=4 then ">10000" end price_range,count(restaurantid)
from zomato 
group by price_range
order by Price_range;

#Percentage of Resturants based on "Has_Table_booking"
select has_online_delivery,concat(round(count(Has_Online_delivery)/100,1),"%") percentage 
from zomato 
group by has_online_delivery;

#Percentage of Resturants based on "Has_Online_delivery"
select has_table_booking,concat(round(count(has_table_booking)/100,1),"%") percentage from zomato group by has_table_booking;

#Top 10 restaurant with highest votes
select RestaurantName, Votes From zomato ORDER BY Votes DESC
LIMIT 10;

#top 10 cuisines by the number of restaurants in the dataset
select cuisines, COUNT(*) AS num_restaurants from zomato GROUP BY cuisines ORDER BY num_restaurants DESC
LIMIT 10;

