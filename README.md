# TimelyBloc
 This repository was made when I was learning more about the Bloc architecture/state management technique in Flutter
  
# Table of Contents
  - [Overview](#timelybloc)
  - [Building and Installation](#building-and-installation)
  - [Technical Discussion](#technical-discussion)

  ## Goals 
  Build a simple Timer app using Flutter compatible with Android/iOS devices.

  - Build a simple Timer Appp using Flutter and use Bloc archtitecture.

  ## Status
  I have completed the task accomplishing the following -
  - Completed the tutorial functionality and also added/adding a few new features (see [new feature](#extra-features-implemented))

  # Building and Installation
  ## Prerequisites
  To build this app, you will need -
  - [Flutter SDK](https://flutter.dev)

  ## Cloning the Project Repo
  If you like using the terminal
   - Navigate to where you want to clone this repo
   - ```git clone https://github.com/aryang117/timelyBloc.git```
  <br> </br>
  
  If you wish to clone using the browser only
   - Scroll up to the about section
   - To the left of about section, you will see a button with label ``Code``
   - Click on the code button and then on Download zip
   - Extract the zip and you have the project folder!
    
   [Other ways to get the project repo](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github/cloning-a-repository)
  
  ## Build
  Now, to actually build the app
  - Clone this repo
  - Navigate to the folder where this repo has been cloned
  - ```flutter build apk --release``` to build a release build of the app
  
  ## Installation
  To install this on a real device, after building the app
  - Plug-in your phone via USB
  - In the project folder ``flutter install [device-id]`` (device-id -> device-id of your phone, run ``flutter devices`` to see your device's id)
  It should be installed now! Check it out! (Assuming no errors occured during build)
  
  # Technical Discussion
  ## Packages Used
  These are the different 3rd Party Packages I used to complete this project
  - flutter_bloc - To use Bloc in Flutter
  - equatable

  ## Features Implemented
  
  The app already fulfills all the requirements given in the goals. 
  
  ### Extra Features Implemented
  I added a few features that were not part of the problem statement, but they were added to help in development and are just tiny QoL (Quality of Life) features to make it easier to perform all operations of the app
  #### Allowed Custom Time setting
  The simple text display has now been replaced with a TextFormField, allowing the user to set time for the timer by their own choice
  - Set custom time for the timer
  - Is Read-only once you start/resume the timer
  
  ### [Back to top](#timelybloc)
