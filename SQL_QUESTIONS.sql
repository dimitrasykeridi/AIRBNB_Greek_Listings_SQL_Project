use AIRBNB_LIST
go


--QUESTION 1 : Which are the top five Greek neighborhoods with the highest average price per night?--
SELECT DISTINCT COUNT([fact_neighbourhood_cleansed]) as Count_neighbourhoods,
avg([price]) as Average_Neighbourhood_price
FROM FactListings

SELECT TOP 5 avg([price])as Average_price,
[fact_neighbourhood]
FROM FactListings FL
GROUP BY [fact_neighbourhood]
ORDER BY avg([price]) desc;

--QUESTION 2 : What is the number of accommodates for the highly-priced neighborhood of Athens? --

WITH max_price as (SELECT TOP 1 fact_neighbourhood
FROM FactListings
WHERE fact_neighbourhood like '%Athens%'
GROUP BY fact_neighbourhood
ORDER BY avg([price]) desc)
SELECT FL.accommodates, 
AVG(FL.[price]) as average_price
FROM FactListings as FL,max_price
WHERE FL.fact_neighbourhood = max_price.fact_neighbourhood
GROUP BY FL.accommodates
ORDER BY FL.accommodates;

--QUESTION 3 : Which are the top five neighborhoods with the highest revenue potential based on listing data?--
SELECT TOP  5 fact_neighbourhood,
price* maximum_nights as monthly_revenue
FROM FactListings FL
WHERE fact_neighbourhood not like '%N/A%'
GROUP BY fact_neighbourhood,price * maximum_nights
ORDER BY Sum(price * (30-maximum_nights)) DESC ;

--QUESTION 4 : Superhosts or regular hosts have the most properties?--
SELECT CASE WHEN is_superhost = 1 then 'Superhost' when is_superhost=NULL then 'Unknown' else 'Regular Host' end as host_type,
COUNT(*) AS property_type_count
FROM DimHost
GROUP BY is_superhost;

--QUESTION 5 : What percentage of superhosts and non-superhosts have a profile picture? --
SELECT SUM(CASE WHEN has_profile_pic = 1 then 1 else 0 end)*100.00 / count(*) as percentage_of_superhosts
FROM DimHost
WHERE is_superhost=1;

SELECT SUM(CASE WHEN has_profile_pic = 1 then 1 else 0 end)*100.00 / count(*) as percentage_of_non_superhosts
FROM DimHost
WHERE is_superhost=0;

--QUESTION 6 : What is the most common room type among superhosts and non-superhosts? --
SELECT TOP 1  B.room_type,count(*)as room_type_count_superhosts
FROM FactListings as FL
INNER JOIN DimRoomType as B on FL.room_type_id= B.room_type_id
INNER JOIN DimHost as DM on FL.host_id=DM.host_id
WHERE DM.is_superhost=1
GROUP BY B.room_type
ORDER BY room_type_count_superhosts desc;

SELECT TOP 1  B.room_type,count(*)as room_type_count_non_superhosts
FROM FactListings as FL
INNER JOIN DimRoomType as B on FL.room_type_id= B.room_type_id
INNER JOIN DimHost as DM on FL.host_id=DM.host_id
WHERE DM.is_superhost=0
GROUP BY B.room_type
ORDER BY room_type_count_non_superhosts desc;

--QUESTION 7 : What is the average number of beds and bathrooms in listings hosted by superhosts and non-superhosts? --
SELECT AVG(beds) as num_beds, AVG(bathrooms)as num_bathrooms_superhosts
FROM FactListings as FL
INNER JOIN DimHost as DM on FL.host_id= DM.host_id
WHERE DM.is_superhost=1;

SELECT AVG(beds) as num_beds, AVG(bathrooms)as num_bathrooms_non_superhosts 
FROM FactListings as FL
INNER JOIN DimHost as DM on FL.host_id= DM.host_id
WHERE DM.is_superhost=0;


--QUESTION 8 :Which neighborhoods have the top five highest average review scores for properties?--
SELECT TOP 15 AVG(review_scores_rating)as average_review_score, fact_neighbourhood 
FROM FactListings
GROUP BY fact_neighbourhood
ORDER BY average_review_score desc;

--QUESTION 9: Who are the top five hosts according to the number of reviews ?--
SELECT TOP 5 DM.host_name,count(review_scores_rating) as total_reviews
FROM FactListings as FL
INNER JOIN DimHost as DM on FL.host_id= DM.host_id
GROUP BY DM.host_name
ORDER BY count(review_scores_rating) desc;

--QUESTION 10 :Find the listings who have received the highest number of reviews? --
SELECT TOP 5 FL.listing_name, COUNT (FR.review_id) as total_reviews
FROM FactListings as FL
INNER JOIN FactReview FR on FL.id = FR.listing_id
GROUP BY FL.listing_name
ORDER BY total_reviews DESC;

--QUESTION 11 :In which months do we have the most bookings?"--
SELECT TOP 5 datename (month,booking_date) as booking_month, count(booking_date) as total_bookings
FROM Factcalendar
WHERE is_available=0
GROUP BY  datename (month,booking_date)
ORDER BY count(booking_date) desc;

--QUESTION 12 : Find the listings with the most available dates--
WITH available_dates_per_listing as (
SELECT listing_id, count(is_available) as available_days
FROM Factcalendar
WHERE is_available=1
GROUP BY listing_id)
, max_avail_dates as (
SELECT max(available_days) as mx
FROM available_dates_per_listing
)
SELECT available_dates_per_listing.*
FROM available_dates_per_listing
JOIN max_avail_dates on available_days = mx;

--QUESTION 13 : Find the hosts with the highest number of bookings --
SELECT TOP 5 DM.host_name, count (booking_date) as total_bookings from Factcalendar as FC
INNER JOIN FactListings FL on FC.listing_id= FL.id
INNER JOIN DimHost DM ON DM.host_id= FL.host_id
WHERE FC.is_available=0
GROUP BY DM.host_name
ORDER BY count (booking_date) desc;

--QUESTION 14 : Find the average price, average minimum nights, and average maximum nights per room type.--
SELECT AVG(price) as average_price , AVG(FC.minimum_nights) as average_minimum_nights,
avg(FC.maximum_nights) as average_maximum_nights,DRT.room_type
from Factcalendar as FC
INNER JOIN FactListings FL on FC.listing_id= FL.id
INNER JOIN DimRoomType DRT on DRT.room_type_id=FL.room_type_id
GROUP BY FL.room_type_id,DRT.room_type
ORDER BY AVG(price) desc;










