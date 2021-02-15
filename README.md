# MakersBnB group challenge
Week 5 of Makers Academy challenge to build a web application that allows users to list spaces they have available, and to hire spaces for the night.
Our Group is called FAMM and consists of Annabelle, Margarida, Francesco and Michael. 

----
Headline specifications
----
* Any signed-up user can list a new space.
* Users can list multiple spaces.
* Users should be able to name their space, provide a short description of the space, and a price per night.
* Users should be able to offer a range of dates where their space is available.
* Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
* Nights for which a space has already been booked should not be available for users to book that space.
* Until a user has confirmed a booking request, that space can still be booked for that night.

```
User Stories:

As a User
So I can use MakersBnB
I need to create an account(Sign-Up)

As a User
So I can use the makersbnb website
I need to sign-in in to my account

As a User
So I can keep my details secure
I can sign-out of my account

As a user
So I can list a space
I need to create a new space

As a user
So I can advertise my space
I need to add the following attributes: name, description, price & availability. 

As a User
So I can book a space
I need to check if the space is available
```

### To set up the database

Connect to `psql` and create the `makersbnb` database:
```
CREATE DATABASE makersbnb;
```
To set up the tables, connect to the database in `psql` and run the SQL scripts in the `db/migrations` folder.

### To set up Testing database
Connect to `psql` and create the `makersbnb_test` database:
```
CREATE DATABASE makersbnb_test;
```
To set up the tables, connect to the database in `psql` and run the SQL scripts in the `db/migrations` folder.

# Model Diagrams

<img alt="BNB-Group-Challenge first page" src="./model_diagram.png" width="800px" style="display: block;" />














