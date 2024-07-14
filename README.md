# AIRBNB_Greek_Listings_SQL_Project
## Background Information
### Data Source
### Data Files
* First file is the listings.csv file that contains information about Airbnb listings and hosts
* Second file is the reviews.csv file that contains information about the reviews a property has received
* Third file is the calendar.csv file that contains information about Airbnb property availability
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
Extract
Data extraction comes from the three CSV files in the "Resources" folder

Cleaning
For the FactCalendar table , I replaced null values with zero in the price and adjusted price columns. Also, I replaced with numeric values the column is_available.
Finally, I used the FORMAT() function to format the booking_date as yyyy-MM-dd'.

![image](https://github.com/user-attachments/assets/fabf2e75-4e38-464a-9182-82c0432b4d5f)

For the FactListings table, in order to load the data correctly, I excluded all listing id that contained the E letter. 
Also, I replaced null values with zero in the price column and i extracted the numeric values from the bathrooms text column to create a new column called bathrooms including those. 
Then, i used the TRYCAST function to alter the datatype of bathrooms column to decimal and the CAST function to alter the data type of neighbourhood's column to VARCHAR(150).
Finally, I replaced the null values in the neighborhood column with N/A and in the columns has_availability and instant_bookable i replaced with numeric values.

![image](https://github.com/user-attachments/assets/deabd03a-1f3d-42d6-9f93-e1d3202e266e)

For the DimHost table, I replaced the null values in the host_location and host_neighborhood columns with 'N/A'. For the columns host_has_profile_pic, host_identity_verified, and host_is_superhost, I replaced the null values with numeric values.

![image](https://github.com/user-attachments/assets/3f731b1f-6222-45d4-8ea7-6baba5dc507f)

Load
To set up the schema for this analysis, i created seven tables: FactListings, DimHost, FactReview, FactCalendar, FactReviewScores, DimPropertyType, and DimRoomType. 
I believe this is the best way to organize the data because each table has a specific focus. As a result, we minimize redundancy, queries become more efficient, and data management is more straightforward.

FactListings table
![image](https://github.com/user-attachments/assets/05093a26-13fc-47d9-9876-a70fefdf37fd)

FactReview table
![image](https://github.com/user-attachments/assets/db44b34f-765e-4297-9a92-b3b8482f3d9f)

FactCalendar table
![image](https://github.com/user-attachments/assets/ffe70bcc-6a7b-4905-95a0-7325e75a11aa)

FactReviewScores table
![image](https://github.com/user-attachments/assets/64ab0fca-d7de-4b3d-8c53-faaad3d5a35b)

DimHost table
![image](https://github.com/user-attachments/assets/caeac8aa-086c-4795-a3bf-1f4cb583ad65)


In order to create the DimRoomType table and the DimPropertyType table, which help with the storage of distinct values into two separate tables, I used the CREATE TABLE command. Each table includes a column, room_type_id for DimRoomType and property_type_id for DimPropertyType, which stores unique integer values starting at 1 and incrementing by one. These columns act as primary keys for their respective tables.

![image](https://github.com/user-attachments/assets/857ac024-fe67-4470-8bcc-89d448e76a06)
























