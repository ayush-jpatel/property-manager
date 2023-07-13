--SQL code script

create table Role_Table(role_id number,role_name varchar(20),primary
key(role_id));

create table Users(aid number primary key,name varchar(20),age
number,door_number number,pincode number,street varchar(20),city
varchar(20),state varchar(20),username varchar(20),password number,role
number, foreign key(role) references Role_Table(role_id));

create table Owner(Owner_id number primary key,foreign key(owner_id)
references Users(aid));

create table User_Info(Aid number,contact number,primary
key(Aid,contact),foreign key(Aid) references Users(aid));

create table Property(pid number primary key,owner_id number,availability
number,end_date date,address varchar(40),rpm number,hike_percent
number,total_area number,plinth_area number,Floors_no number,locality
varchar(20),Yrs_of_cons number,No_of_bedrooms number,type_id number,foreign
key(owner_id) references Owner(Owner_id),foreign key(type_id) references
Type_table(Type_id));

create table Type_table(Type_id number,Type_name varchar(20),primary
key(Type_id));

create table Tenant(tid number,Pid number,primary key(tid,Pid),start_date
date,end_date date,agency_comm varchar(20),rent_pm number,hike number,foreign
key(tid) references Users(aid),foreign key(Pid) references Property(pid));

create or replace procedure InsertPropertyRecord(pid in number, owner_id in
number, availabilty in number, end_date in date, address in varchar, rpm in
number, hike_percent in number, total_area in number, plinth_area in number,
floors_no in number, locality in varchar, yrs_of_cons in number,
no_of_bedrooms in number, type_id in number) as
begin
insert into property values(pid, owner_id, availabilty, end_date, address,
rpm, hike_percent, total_area, plinth_area, floors_no, locality, yrs_of_cons,
no_of_bedrooms, type_id);
end;
/


create or replace procedure CreateNewUser(aid in number, name in varchar,
age in number, door_num in number, pincode in number, street in varchar, city
in varchar, state in varchar, username in varchar, password in varchar, role
in number ) as
begin
insert into Users values(aid,name,age,door_num,pincode,street,city,state,
username,password,role);
end;
/


create or replace procedure SearchPropertyForRent(city in varchar(20)) as
declare
avail number;
pid number;
c_name varchar(20);
CURSOR n_prop is select pid,city, availabilty from property;
BEGIN
Open n_prop;
LOOP
Fetch from n_prop into pid, c_name, avail;
EXIT WHEN n_prop%notfound;
if(avail ==1) then
dbms_output.put_line('Available property ID:' || pid);
END LOOP;
CLOSE n_prop;
END;
/


--main below

create table Property(pid number primary key,owner_id number,availability
number,end_date date,address varchar(40),rpm number,hike_percent
number,total_area number,plinth_area number,Floors_no number,locality
varchar(20),Yrs_of_cons number,No_of_bedrooms number,type_id number,foreign
key(owner_id) references Owner(Owner_id),foreign key(type_id) references
Type_table(Type_id));


create or replace procedure InsertPropertyRecord(oid number) as
id number;
Owner_id number;
avail number;
endDate date;
addres varchar(40);
rpm number;
hike number;
t_a number;
p_a number;
no_floors number;
locality varchar(20);
Yrs_cons number;
No_bedrooms number;
type_ID number;

cursor Property_cursor is
select
pid,owner_id,availability,end_date,address,rpm,hike_percent,total_area,plinth_
area,Floors_no,locality,Yrs_of_cons,No_of_bedrooms,type_id from Property p
where p.owner_id=oid;
begin
open Property_cursor;
loop
fetch Property_cursor into
id,Owner_id,avail,endDate,addres,rpm,hike,t_a,p_a,no_floors,locality,Yrs_cons,
No_bedrooms,type_ID;
exit when Property_cursor%notfound;
dbms_output.put_line(' For the property with owner ID: '||Owner_id||' Property
ID is: '||id||' Availability status is: '||avail||' end date: '||endDate||'
address is: '||addres||' rent per month is: '||rpm||' hike percent is:
'||hike||' total area is: '||t_a||' plinth area is: '||p_a||' number of floors
are: '||no_floors||' locality is: '||locality||' Years of construction:
'||Yrs_cons||' Number of bedrooms are: '||No_bedrooms||' type ID is:
'||type_ID);
end loop;
close Property_cursor;
end;
/





/*
create or replace procedure SearchPropertyForRent(city in varchar2)as
avail number;
pid number;
c_name varchar2(20);
CURSOR n_prop is
select pid,locality, AVAILABILITY from property;
BEGIN
Open n_prop;
LOOP
Fetch n_prop into pid, c_name, avail;
EXIT WHEN n_prop%notfound;
if(avail = 1 and c_name = city) then
dbms_output.put_line('Available property ID:' || pid);
End if;
END LOOP;
CLOSE n_prop;
END;
/
*/


create or replace procedure getrenthistory(pid1 number) as
ans number;
aid1 number;
start_date1 date;
end_date1 date;
hike1 number;
agency1 varchar(15);
rent_per_month1 number;
cursor printer is select
tid,start_date ,end_date,hike ,agency_comm,rent_pm
from Tenant where pid=pid1;

cursor printer is select
tid,start_date ,end_date,hike ,agency_comm,rent_pm
from Tenant where pid=pid1;

begin
select count(*) into ans from Tenant where pid=pid1;
if ans>0 then
open printer;
loop
fetch printer into aid1 ,start_date1 ,end_date1,hike1
,agency1,rent_per_month1;
exit when printer%notfound;
begin
dbms_output.put_line(' aid: '||aid1||' start_date: '||start_date1||'
end_date1: ' ||end_date1||' hike: '||hike1||' agency: ' ||agency1||'
rent_per_month: '||rent_per_month1 );
end;
end loop;
close printer;
else
dbms_output.put_line('this has never been rented');
end if;
end;
/




create or replace procedure getuserdetails(aid1 number) as
user_name1 varchar(15);
user_id1 varchar(15);
age1 number;
add_city1 varchar(15);
add_state1 varchar(15);
add_street1 varchar(15);
add_pincode1 number;
add_doorno1 number;
ans number;
begin
select count(*)into ans from Users where aid=aid1;
if(ans>0) then

SELECT name,aid,age,city,state,street,pincode,door_number into user_name1
,user_id1 ,age1 ,add_city1,add_state1 ,add_street1 ,add_pincode1 ,add_doorno1
from Users
where aid=aid1;
begin
dbms_output.put_line('user name: '||user_name1||' user_id: '||user_id1||' age:
'||age1||' add_city: '||add_city1|| ' add_state: '||add_state1||' add_street:
'||add_street1||' add_pincode: '||add_pincode1||' add_doorno:'||add_doorno1);
end;
else
dbms_output.put_line('no such value');
end if;

end;
/


