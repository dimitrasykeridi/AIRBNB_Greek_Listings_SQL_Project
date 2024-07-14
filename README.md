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
![image](https://github.com/user-attachments/assets/d4703261-ebb2-4a53-b5d5-aceedb47e08d)


















