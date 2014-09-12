Evil-Hangman-iOS
================

Evil hangman is similar to hangman. However you play against a computer that cheats.
This repository is for an iphone app of this game.

Cheating in hangman is done whenever the guesser guesses a letter. The computer will calculate if there are more words 
with or without the guessed letter. It will then proceed to choose the biggest list. If the guesser chooses a letter 
which most remaining words contain, then the computer will calculate what the optimal spot is/spots are for this letter.
It will again choose the list with the most remaining words, increasing his chances for the next guess. However, if 
you were to choose a letter that is in the minority of the remaining words, the computer will say your guess is wrong.

The app will consist of at least two screens.
  * The Game screen: where the user spends most of his/her time playing the game.
  * The Settings screen: adjustible settings for a better user experience.

The game screen
---------------

The game screen will be as minimalistic as possible. Hangman is not a complicated game, so no need to make it look 
like it is. It probably won't contain any more than this:
  * Progress of the hanging
  * Used letters
  * Progress of the word
  * Keyboard for input (maybe only consisting of the 26 letters).

The Settings screen
-------------------

The settings screen will be for users to adjust the look of the app, and maybe small changes in the gameplay. I'm
thinking about settings like these:
  * Theme of the app, being able to adjust some colors might be fun.
  * Turn on/off used letters. To make the game slightly harder one could turn this of, and won't have a history of the guessed letters.
  * Turn on/off cheat mode. Regular hangman with a fixed word choosen by the computer, or evil hangman with an everchanging word.
  * Word length. Random or fixed word length.

The App
-------

 * The app will be built from the Utility App Template, because I have one main screen, and one settings screen.
 * The Keyboard will be made from 26 buttons, not a UITextfield, since I only want letters, and just one at a time as input.
 * The progress of the hanging will be shown through 10 images, that increment everytime a wrong anwser is given.
 * The Settingsscreen will be a list, like the settings app on the iphone.

Layout
------

![Rough Layout of Evil Hangman](https://github.com/OvanHouten/Evil-Hangman-iOS/blob/master/doc/BasicAppLayout.png)
