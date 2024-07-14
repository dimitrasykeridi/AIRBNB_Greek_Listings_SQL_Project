USE AIRBNB_LIST
GO

--CREATION OF FACTREVIEW TABLE--
SELECT * FROM FactReview
SELECT listing_id, id as review_id , date as review_date, comments
INTO FactReview
FROM review;

--CREATION OF FACTCALENDAR TABLE--
SELECT CAST (listing_id as bigint) as listing_id,
FORMAT(date, 'yyyy-MM-dd') as booking_date,
ISNULL(price, 0) as price, 
ISNULL(adjusted_price, 0) as adjusted_price ,
minimum_nights,maximum_nights,
CASE WHEN available= 'f' then 0
ELSE 1
END AS is_available
INTO Factcalendar
FROM calendars
SELECT * FROM Factcalendar

--CREATION OF DIMREVIEWER TABLE--
SELECT DISTINCT  reviewer_id,reviewer_name
INTO DimReviewer
FROM review
SELECT * FROM DimReviewer

--CREATION OF FACTLISTINGS TABLE--
SELECT 
    CAST(id as bigint)as id ,CAST(name as nvarchar(max)) as listing_name,host_id,latitude,longitude,D.property_type_id,B.room_type_id,accommodates,bedrooms,
    beds,ISNULL(PRICE, 0) AS price,review_scores_rating,minimum_nights,maximum_nights,
    TRY_CAST(SUBSTRING(bathrooms_text, 1, CHARINDEX(' ', bathrooms_text + ' ') - 1) AS DECIMAL) AS bathrooms,
    CAST(ISNULL(neighbourhood, 'N/A') AS VARCHAR(150)) AS fact_neighbourhood,
	CAST(ISNULL(neighbourhood_cleansed, 'N/A') AS VARCHAR(150)) AS fact_neighbourhood_cleansed,
    CASE WHEN instant_bookable = 'f' THEN 0 ELSE 1 END AS is_instant_bookable,
    CASE WHEN has_availability = 'f' THEN 0 ELSE 1 END AS has_availability
INTO FactListings
FROM LISTING AS A
LEFT JOIN DimRoomType AS B ON A.room_type = B.room_type
LEFT JOIN DimPropertyType AS D ON A.property_type = D.property_type
WHERE id NOT LIKE '%E%';

--CREATION OF FACTREVIEWSCORES TABLE--
SELECT CAST(id as bigint)as listing_id, review_scores_accuracy,review_scores_checkin,
review_scores_cleanliness,review_scores_communication,review_scores_location,
review_scores_rating,review_scores_value
INTO FactReviewsScores
FROM listing
WHERE id NOT LIKE '%E%';

--CREATION OF DIMHOST TABLE--
SELECT DISTINCT host_id, host_name,host_since,host_response_time,host_acceptance_rate,host_response_rate,
ISNULL(host_location, 'N/A') AS dim_host_location,
ISNULL(host_neighbourhood,'N/A') AS dim_host_neighbourhood,
CASE WHEN host_is_superhost= 'f'then 0 
ELSE 1 
END AS is_superhost,
CASE WHEN host_has_profile_pic= 'f'then 0 
ELSE 1 
END AS has_profile_pic,
CASE WHEN host_identity_verified='f' then 0 
ELSE 1 
END AS identity_verified
INTO DimHost
FROM listing
SELECT * FROM DimHost

--CREATION OF DIMROOMTYPE TABLE --
CREATE TABLE DimRoomType (room_type_id int identity(1, 1) PRIMARY KEY  ,
room_type varchar(50)
)
INSERT INTO DimRoomType
SELECT DISTINCT room_type
FROM listings 
SELECT * FROM DimRoomType

--CREATION OF DIMPROPERTYTYPE TABLE --
CREATE TABLE DimPropertyType (property_type_id int identity(1, 1) PRIMARY KEY  ,
property_type varchar(50)
)
INSERT INTO DimPropertyType
SELECT DISTINCT property_type
FROM listings 
SELECT * FROM DimPropertyType