# Pluma (Journal App)

Pluma is a journal app where you can list down and be reminded of your day-to-day tasks and activities. It makes creating tasks easier and fun by assigning them to different colorful categories that you can also create. Know which tasks are due for today or left unaccomplished and quickly mark them complete with Pluma. 

Pluma is there to help you organize tasks and save time so you can spend it on the things that matter to you most.

Live website: https://rjaa25-pluma.herokuapp.com/

## Don't want to make an account? 
Use these credentials to log in and get a feel of using the application.
```
Email: janedoe@email.com
Password: password
```
![Pluma Showcase](https://user-images.githubusercontent.com/88828088/181020880-b30ef1a7-e676-40d5-ba0c-3bd0e1f39f99.png)

## Tool Versions

This project is built with Ruby on Rails and designed using Bootstrap v5.0
```
Ruby: 3.1.0
Rails 7.0.3
```
### Gems Installed
- [bootstrap-rubygem](https://github.com/twbs/bootstrap-rubygem)
- [bootstap-icons](https://github.com/marcelolx/bootstrap-icons)
- [simplecov](https://github.com/simplecov-ruby/simplecov)
- [devise](https://github.com/heartcombo/devise)

## Notes
- **DO NOT USE** credentials that may contain sensitive information. This a is personal project and should be treated as such.
- The application is set to a **GMT+8** timezone. Please keep this in consideration when creating tasks.
- Authentication is handled using Devise v4.8.1 (latest at this time).
- The code coverage is at least 90%.
- Profile avatars are generated by [DiceBear Avatars](https://avatars.dicebear.com/styles/avataaars) using the provided username during sign up. 
- The application is responsive across multiple mobile devices.

## Usage
Use the application in you local machine by running these commands in terminal of your desired directory
```
git clone https://github.com/RJAA-25/Journal-App.git
bundle install
rails db:migrate
rails server
```
The application will be running in *https://localhost:3000*

