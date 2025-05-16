
**SQL PROJECT**
----The task is to identify the perpetrator of a murder that occurred on the 15th of January, 2018, in SQL city ,using the police department's database.----

----The first task is to view the database's table structure by running a query..----
select name
from sqlite_master
where type = 'table';

---- The next step was to review crime scene reports from other areas to find the ones that matched the criteria of the crime being investigated.----
select *
from crime_scene_report
where date = 20180115
and type = 'murder'
and city = 'sql city';

----The witness report stated that there were two witnesses, one stays at the last house on 'Northwestern Dr' while the other witness is named 'Annabel' who stays somewhere at 'Franklin Ave'----

----The person table is quried next to get more details on the witnesses.----
select *
from person
where address_street_name = 'Northwestern Dr'
order by address_number desc;

----Now details of the first witness has been obtained---- 
Name; Morty Schapiro
ID; 14887
Licence ID; 118009

----To further get more details on the second witness the below query was used---- 
SELECT *
FROM person
WHERE Address_street_name = 'Franklin Ave' and name like '%Annabel%';
Name; Annabel Miller
ID; 16371
Licence ID; 490173

----Now that i have obtained the details of my witnesses, I need to review their statements to gather clearer information on what they witnessed, and since i have their IDs, I can eaasily locate their statements in the Interview table.----

----For the first witnesses statement, the query below was applied;----
select *
from interview
where person_Id = 14887;

----The first witnesses statement reads; I heard a gunshot, then saw a man flee the scene carrying a 'Get Fit Now Gym' bag with a membership number starting with '48Z', Only gold members have those bags. He got into a car with a licence plate containing 'H42W'.----

----For the second witnesses statement, the below query was applied;----
select *
from interview
where person_Id = 16371

----Which stated "I saw the murder happen, and recognized the killer from my gym when i was working out last week on the 9th of January"----

----The two witnesses both mentioned the gym, with the first witness describing the suspect's vehicle and providing  it's license plates number, and the second witness stating the date the suspect was last seen there.----

---- It's time to examine the gym table based on the information i have; the below query was used;
select *
from get_fit_now_check_in
where membership_id like '48z%'
and check_in_date = 20180109;

---- this confirmed two membership numbers.----

---- Now i queried the second gym table ----
select *
from get_fit_now_member
where id like '48Z%'
and membership_status = 'gold'

---- The name of two suspects was gotten. However, during the interview, only one name surfaced. the suspect, Jeremy Bowers, ultimately confessed to the crime, confirming my conclusion that he is indeed the murderer.

---- Jeremy's confession is stated below;----
select *
from interview
where person_ID = 67318

----"I was hired by a woman with alot of money. I don't know her name but i knew she was about 5'5 (65) or 5'7 (67). She has a red hair and she drives a Tesla model S. I know that she attended the SQL Symphony Concert 3 times in December, 2017."---- 

---- I've obtained the killer's name and details, but he indicates being a hired killer, so i'm now in search for the person who hired him. After a thorough investigation, i focused on the Facebook event check-in table, where i narrowed down the details of the woman Jeremy mentioned, who had attended the 'SQL Symphony Concert' three times in December, 2017. I used this query to identify the person of intrest;----   
select person_id, count(*) as check_in_count
from facebook_event_checkin
where event_name = 'SQL Symphony Concert'
and date >= '20171201'
and date < '20180101'
group by person_id
order by check_in_count desc;
----I got a table with just two people attending the concert three times, definately one of them should be our mastermind.To get our culprit another query was ran;----
select *
from person
where id = 99716
----The name of the woman who hired the killer is 'Miranda Priestly' with social security number 987756388.----

----To confirm one detail Jeremy mentioned about the woman, specifically that she is wealthy, I investigated her annual income on the income table.----
select *
from income
where ssn = 987756388

----She earns $310,000, ranking her 47th among 7,514 individuals on the income database.----	
select *
from income
order by annual_income DESC
limit 50 

----CONCLUSION----
The killer is Jeremy Bowers who was hired by Miranda Priestly a high income earner to execute a murder on the 15th of January, 2018.

