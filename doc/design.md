Design Doc
==========

MVC
---
I will use the MVC structure common in iOS applications. This stands for Model-View-Controller. With this structure
you are able to separate concerns, since each of the components deal with their own problems.

The View
--------
The View typically deals with what the user sees. Background, buttons, sliders etc. It should update accordingly to
your actions which are done by the Model.

Model
-----
The Model is the component in the app that interacts with a database, or an internet connection. Here lies the actual
logic of the application.

Controller
----------
The Controller is the part that communicates with the View and the Model and passes information between these two
components. When one interacts with the View, this actually triggers something in the Controller.


Keyboard
--------
![Rough Layout of Evil Hangman](https://github.com/OvanHouten/Evil-Hangman-iOS/blob/master/doc/BasicAppLayout.png)

The keyboard will exist of small square UIButtons of equal size. I do not want to fiddle around with the Textfield
keyboard, and I want to be able to turn of used letters. It makes input checking a lot easier, since no numbers, 
special charachters or multiple characters can't be used.

The progress of the hanging is shown through simple image files. There is no need to generate these, since I can 
easily create 10 images myself in an image-editor,

The button on the top-right will flip the view to the settings view. To go back one presses the button on the top-left
of the settings view.

The settingsview will consist of basic UI elements like buttons, switches, sliders etc. These will control multiple
settings with among them at least the following: word-length, reset game, show used letters.
