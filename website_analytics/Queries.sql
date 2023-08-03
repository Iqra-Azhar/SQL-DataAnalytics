# Retrieve all the visitors' information from the "Visitors" table.
SELECT *
FROM visitors;
# Get the unique countries from which visitors accessed the website.
SELECT DISTINCT
 country
FROM visitors;
# Find the total number of page views in the "Page_Views" table.
SELECT COUNT(view_id)
FROM page_views;
#  List all the interactions performed on the website along with their timestamps.
SELECT 
 interaction_type AS interactions , 
time(interaction_timestamp) AS timestamps
FROM interactions;
# Get the names and URLs of all the pages in the "Pages" table.
SELECT 
 page_name,
 page_url
FROM pages;
# Find the number of interactions of each type (interaction_type) in the "Interactions" table.
SELECT interaction_type, COUNT(*) AS num_interactions
FROM Interactions
GROUP BY interaction_type;
# Retrieve the visitor_id, visitor_ip, and country of the visitors who accessed the website using the "Chrome" browser.
SELECT 
 visitor_id,
 visitor_ip,
 country 
FROM visitors
WHERE browser = 'Chrome';
#List all the pages that were created after '2023-07-01'.
SELECT *
FROM pages
WHERE DATE(created_at) = '2023-07-01';
# Find the average number of interactions per visitor in the "Interactions" table.




