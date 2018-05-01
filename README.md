# MovieDB

First of all take a pull from master branch. After that you need to install the pods to run the project.

Once you install the pods then run the project from Xcode latest version 9.3.

There you will see two main screens

Movie list view controller 
Movie detail view controller.

As the name suggests in movie list view controller you will be able to see latest releases. Once you will click on any movie that will take you to it's detail view controller.

In movie detail view controller you can see more detailed information with large image.

I have used following API : https://api.themoviedb.org/3/movie/now_playing

Architecture used : MVC

I could have done few more animations and provide more information like budget,running and other parameters from API.

Implemeted Sqlite database for offline support. Added pagination as well so once you will scroll through API call will be executed on the last visible cell of tableview. Then it will add new data into database and reload the table.

Could have add few more placeholders when we dont receieve backdrop path or any image from API.



