# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app 
      Built using Corneal gem

- [x] Use ActiveRecord for storing information in a database
      Controllers use Activerecord to save, update, read and delete from a database

- [x] Include more than one model class (e.g. User, Post, Category)
      5 Models: User, Collection, Console, Games, Games-Collection (join table)

- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
      User has many Collections

- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
      A Console belongs to a Collection 

- [x] Include user accounts with unique login attribute (username or email)
      Users have a unique username

- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
      Console Controller handles this

- [x] Ensure that users can't modify content created by other users
      I check if the correct user is logged in before allowing the user to go to the edit page or delete

- [x] Include user input validations
      I validate uniqeness and I check to see if records exist in the database before displaying to a user

- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
      I use an instance variable of @errors to hold error messages and display on the page to the user

- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
    Done

Confirm
- [x] You have a large number of small Git commits
      300+ commits.. Had a lot of fun with css!

- [x] Your commit messages are meaningful
      I did not leave blank messages. I always tried to describe what I was doing. 

- [x] You made the changes in a commit that relate to the commit message
      I tried my best to break up what I was doing into small commits and leave a related message.

- [x] You don't include changes in a commit that aren't related to the commit message
      I would create a new commit if I had something to do that was unrelated to my current commit.