# Roweather
A mobile weather application targeted towards rowers in Cambridge
## Description
Roweather is a weather application designed for iOS and Android systems which is targeted towards river users in Cambridge - and rowers in particular. It is designed in order to exemplify the paradigm of User-Centred Design, and as such, we, the designers, have aimed to keep the user in mind at all stages of the process.


Throughout this process, we have sought to include features important to our target market which are not typically found on other weather apps. For instance, on the home page, the key piece of information included on each day is the CUCBC daily flag rating, as this is considered vital for planning whether to set outings for certain days, and for those that are set, to embark on them. Other important included pieces of information are water level, current speed and wind speed.


In addition, we have built the capabilities to book outings for certain dates and times, and included a number of settings on another page so the user can customise how the app functions.

# How to run

To run our source code, Flutter/Dart should be installed following the official instructions: https://docs.flutter.dev/get-started/install 


As part of the installation process, ensure that the [Android development toolchain](https://docs.flutter.dev/get-started/install/windows/mobile?tab=download#configure-android-development) and its dependencies are installed. Running `flutter doctor` on the command line will show what dependencies are yet to be installed on your machine. 


Finally, to execute the source code, we recommend following official instructions to open and [run our project in VSCode](https://docs.flutter.dev/get-started/test-drive?tab=vscode), but it is also possible to [execute the app through the command line](https://docs.flutter.dev/get-started/test-drive?tab=terminal).
## Home Screen and Menu
Upon running, and after loading, the home screen will appear, which will include the flag rating for the day at the top, and a carousel of buttons for each day in the middle, each with the predicted flag rating and overall weather for the day. Click on a day button, and the predicted temperature; wind speed; humidity; UV rating and river level will appear. There will also be a series of graphs for the statistics of: temperature; wind speed; cloud cover; and precipitation, predicted hourly for the current day.
## Settings
In the top-left hand corner of the home page is the menu button. This can be pressed to open a sidebar, which can navigate to two other pages, both of which also can access the menu button.


In the settings menu, a number of settings can be changed. Above, there are options to allow notifications for upcoming extreme weather events; flag colour changes; and weather changes during an outing. Below that, are options to change the language; time zone; and units of temperature; height and wind/current speeds - all of these will affect the data on the home screen as described. Below that are options to delete the saved bookings.
## Booking Page
When the “Booking Page” option is clicked, the booking page opens. Below a prompt, a calendar will open, where any date within two months ahead can be selected. Below are options to select outing start and end times - the end time must be after the start, and a date must be selected to book, and the booking cannot clash with other bookings, otherwise the “Book” button will not book, and instead return a prompt to change information. If the booking does not contain these errors, the user will be redirected to the home page, and the booking will appear on the day in the carousel.
## Libraries used
We made frequent use of Flutter libraries in our project:


cupertino_icons - To make use of a number of easily recognisable icons so that the user is not left in any ambiguity over what to do.


fl_chart - To be able to display the current day’s key weather statistics in graphical form.


flutter_svg - To be able to format and display the icons mentioned above


google_fonts - To expand our use of fonts to those used by Google.


http - To fetch any new weather data from the internet.


intl - To set the weather settings to the local ones, and to format dates and times throughout the app.


provider - In order to help asynchronously switch between pages of our app.


table_calendar - In order to import the interactive calendar used to select dates on the booking page.


xml - In order to access information about the CUCBC flag system.