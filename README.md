# ANALYSIS OF GREEK AIRBNB LISTINGS USING SQL
## Background Information
### Data Source
### Data Files
* First file is the listings.csv file that contains information about Airbnb listings and hosts
* Second file is the reviews.csv file that contains information about the reviews a property has received
* Third file is the calendar.csv file that contains information about Airbnb property availability

### Resources 
The data are from the official site of Airbnb and they are licensed under a Creative Commons Attribution 4.0 International License.
http://creativecommons.org/licenses/by/4.0/

### Concept for a Relational Database Design
*Seven tables:

    * One table for listings information from the listings.csv file
    * One table with hosts information from the listings.csv file
    * One table with listings reviews from the reviews.csv file
    * One table with properties availability information from calendar.csv file
    * One table with rooms type information from the listings.csv file
    * One table with properties types information from the listings.csv file
    * One table with review scores for each listing from the listings.csv file
    
* Tables are linked together:
  
    * Listings and hosts tables linked together by host_id
    * Listings and property availability tables linked together by id
    * Listings and property reviews tables linked together by id
    * Listings and rooms type tables linked together by room_type
    * Listings and properties type tables linked together by property_type
    * Listings and review scores table linked together by id

### Data Warehouse Creation ( SQL_DATA TABLES)
* For the FactCalendar table , I replaced null values with zero in the price and adjusted price columns. Also, I replaced with numeric values the column is_available.
Finally, I used the FORMAT() function to format the booking_date as yyyy-MM-dd'.

  ![image](https://github.com/user-attachments/assets/fabf2e75-4e38-464a-9182-82c0432b4d5f)

* For the FactListings table, in order to load the data correctly, I excluded all listing id that contained the E letter. 
Also, I replaced null values with zero in the price column and i extracted the numeric values from the bathrooms text column to create a new column called bathrooms including those. 
Then, i used the TRYCAST function to alter the datatype of bathrooms column to decimal and the CAST function to alter the data types of
two columns(fact_neighbourhood's and fact_neighbourhood_cleansed)to VARCHAR(150).
Further, i used the CAST function again to change the data type of the id column to bigint and the data type of name column to nvarchar(max).
Finally, I replaced the null values in the neighborhood column with N/A and in the columns has_availability and instant_bookable i replaced with numeric values.

![image](https://github.com/user-attachments/assets/90b97529-44f4-40d8-ac89-651da9362c4f)

* For the DimHost table, I replaced the null values in the host_location and host_neighborhood columns with 'N/A'. For the columns host_has_profile_pic, host_identity_verified, and host_is_superhost, I replaced the null values with numeric values.

  ![image](https://github.com/user-attachments/assets/3f731b1f-6222-45d4-8ea7-6baba5dc507f)

### Load
* To set up the schema for this analysis, i created seven tables: FactListings, DimHost, FactReview, FactCalendar, FactReviewScores, DimPropertyType, and DimRoomType. 
I believe this is the best way to organize the data because each table has a specific focus. As a result, we minimize redundancy, queries become more efficient, and data management is more straightforward.

#### FactListings table

![image](https://github.com/user-attachments/assets/df7d38bd-155f-4dee-9b0c-07a0ac9eb5f8)


#### FactReview table

![image](https://github.com/user-attachments/assets/77e54e33-28fe-45b7-9ed0-9595d287bc12)


#### FactCalendar table

![image](https://github.com/user-attachments/assets/ffe70bcc-6a7b-4905-95a0-7325e75a11aa)

#### FactReviewScores table

![image](https://github.com/user-attachments/assets/64ab0fca-d7de-4b3d-8c53-faaad3d5a35b)

#### DimHost table

![image](https://github.com/user-attachments/assets/caeac8aa-086c-4795-a3bf-1f4cb583ad65)

In order to create the DimRoomType table and the DimPropertyType table, which help with the storage of distinct values into two separate tables, I used the CREATE TABLE command. Each table includes a column, room_type_id for DimRoomType and property_type_id for DimPropertyType, which stores unique integer values starting at 1 and incrementing by one. These columns act as primary keys for their respective tables.

![image](https://github.com/user-attachments/assets/857ac024-fe67-4470-8bcc-89d448e76a06)

### Purpose of this project 
The purpose of this project is to create a Data Warehouse from 3 CSV files related with Airbnb listings, reviews and bookings.  The  creation of the Data Warehouse required us to use SQL Server Management Studio. After applying the Data Warehouse Architecture principles and creating a Data model that follows a Star Schema, it was decided to answer to some business questions(SQL_QUESTIONS). 
Below you can find a detailed description of those:

#### Data questions


•	Which are the top five Greek neighborhoods with the highest average price per night?

•	What is the number of accommodates for the highly-priced neighborhood of Athens? 

•	Which are the top five neighborhoods with the highest revenue potential based on listing data?

•	Do Superhosts or regular hosts have the most properties?

•	What percentage of Superhosts and Non-Superhosts have a profile picture?

•	What is the most common room type among Superhosts and Non-Superhosts?

•	What is the average number of beds and bathrooms in listings hosted by superhosts and non-superhosts?

•	Which neighborhoods have the top fifteen highest average review scores for properties?

•	Who are the top five hosts according to the number of reviews?

•	Find the listings who have received the highest number of reviews?

•	In which months do we have the most bookings?

•	Find the listings with the most available dates

•	Find the hosts with the highest number of bookings

•	Find the average price, average minimum nights, and average maximum nights per room type.



### Conclusion

To sum up the findings of this project:

•	There are 7335 neighborhoods with Airbnb listings in Greece and the average price is $121.45. Acropolis has the highest average listing price at $415, mainly because of its historical importance.

•	Accommodations in Acropolis that can accommodate 8 people suggest a special appeal to larger groups or families looking for a shared experience near the historical monuments.

•	Superhosts are 3.7% more likely to have a profile picture than non-superhosts. With 98% of superhosts and 94% of non-superhosts having profile pictures, it is nearly standard practice. This small difference suggests that superhosts' preference for profile pictures may contribute to their success.

•	The majority of Airbnb listings are owned by Non-Superhosts. Although Non-Superhosts own more properties than Superhosts, both groups show a preference for renting entire apartments, with an average of two beds.

•	From the list of top 15 neighborhoods based on average property score, Acropolis ranks 12th. Despite its higher average apartment prices, properties consistently satisfy guests, making it an appealing choice for future Airbnb hosts.

•	•	From the survey, George and Toni stand out as two of the hosts with the highest average number of bookings and reviews Maria and Konstantinos also appear on the list. A host ranking high on both lists shows consistent guest interaction and feedback, which enhances their reputation on the platform due to the high volume of bookings and reviews.

•	Since the average minimum nights for most room types are similar, the average maximum nights can indicate if a room type is suitable for extended stays. With hotels averaging 1037 nights and entire apartments averaging 912 nights, these accommodations are ideal for longer bookings, making them attractive to guests showcasing a factor why a guest may prefer them on the app.


•	The number of bookings increases in the months of  October and September.























