//
//  GameObject.m
//  Evil-Hangman-iOS
//
//  Created by Olaf Van Houten on 24/09/14.
//  Copyright (c) 2014 Olaf van Houten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface GameObject () {
	NSMutableArray * remainingWords;
	NSInteger wordLength;
	NSInteger currentTries;
	NSInteger totalTries;
	BOOL disableLetters;
}

@end

@implementation GameObject

/*
 *	The init method of GameObject. Sets various variables for from settings, also reloads the words, with possibly a new length.
 */
- (id)init {
	self = [super init];
	
	// Get the user settings from the plist
	NSString * path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
	NSDictionary * dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
	self.settings = [NSUserDefaults standardUserDefaults];
	[self.settings registerDefaults:dictionary];
	
	// Set the settings in our game object
	wordLength = [self.settings integerForKey:@"Wordlength"];
	disableLetters = [self.settings boolForKey:@"DisableLetters"];
	totalTries = [self.settings integerForKey:@"TotalTries"];
	currentTries = 0;
	
	// Create our obfuscated word
	self.currentWord = [[NSMutableString alloc] init];
	for(int i = 0; i < wordLength; i++) {
		[self.currentWord appendString:@"_"];
	}
	
	// Load part of the english word list into an array
	path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
	NSMutableArray * englishWords = [NSMutableArray arrayWithContentsOfFile:path];
	remainingWords = [[NSMutableArray alloc] init];
	
	// Add only the words that conform the length set by the user
	for (int i = 0; i < englishWords.count; i++) {
		if([[englishWords objectAtIndex:i] length] == wordLength) {
			[remainingWords addObject:[englishWords objectAtIndex:i]];
		}
	}
	
	return self;
}

/*
 *	Whenever a keyboard button is pressed, this method will be called. It creates a new array of words according to user input
 *	The goal of the method is to pick the longest array, while still staying truthfull to the rules of hangman.
 */
- (BOOL)checkInput:(char)input {
	NSMutableArray * sortArray = [[NSMutableArray alloc] init];
	[sortArray addObject:[NSMutableArray arrayWithObject:self.currentWord]];
	NSMutableString * tempWord = [[NSMutableString alloc] init];
	BOOL notFound;
	
	// Loop through all the remaining words. First word is the obfuscated word so we start at index 1
	for(int i = 1; i < remainingWords.count; i++) {
		// Create a word from the remaining list as if it was obfuscated.
		tempWord = [self createHangmanWord:[remainingWords objectAtIndex:i] withInput:input];
		notFound = YES;
		// Loop through all arrays to find one with same obfuscation, and add to it if found.
		for(int j = 0; j < sortArray.count; j++) {
			if([tempWord isEqualToString:[[sortArray objectAtIndex:j] objectAtIndex:0]]) {
				[[sortArray objectAtIndex:j] addObject:[remainingWords objectAtIndex:i]];
				notFound = NO;
			}
		}
		
		// If the same obfuscation is not found, add a new list, with the obfuscated word at index 0.
		// This reduces time of completion, since we don't need to recalculate the obfuscated word over and over
		if(notFound) {
			NSMutableArray * newArray = [[NSMutableArray alloc] init];
			[newArray addObject:tempWord];
			[newArray addObject:[remainingWords objectAtIndex:i]];
			[sortArray addObject:newArray];
		}
	}
	
	// Look for the size of the longest lists.
	int longestArraySize = 0;
	for(int i = 0; i < sortArray.count; i++) {
		if([[sortArray objectAtIndex:i] count] > longestArraySize) {
			longestArraySize = [[sortArray objectAtIndex:i] count];
		}
	}
	
	// Now we only look at the longest lists, and search for one with the least revealed letters.
	NSMutableArray * leastLetterArray = [[NSMutableArray alloc] init];
	int leastLetters = 100;
	for(int i = 0; i < sortArray.count; i++) {
		if([[sortArray objectAtIndex:i] count] == longestArraySize) {
			if([self revealedCharInWord:[[sortArray objectAtIndex:i] objectAtIndex:0]] < leastLetters) {
				leastLetters = [self revealedCharInWord:[[sortArray objectAtIndex:i] objectAtIndex:0]];
				leastLetterArray = [sortArray objectAtIndex:i];
			}
		}
	}
	
	remainingWords = leastLetterArray;
	
	return [self updateObfuscatedWord:[leastLetterArray objectAtIndex:0] withInput:input];
}

/*
 *	Create a word with new letters revealed, if a letter has been guessed correctly.
 *	If the word has been guessed, the method will return YES, if not it wil return NO.
 *	It also checks if the maximum allowed guesses is reached.
 */
- (BOOL)updateObfuscatedWord:(NSMutableString *)word withInput:(char)input {
	NSMutableString * newWord = [[NSMutableString alloc] init];
	int count = 0;
	
	for(int i = 0; i < self.currentWord.length; i++) {
		if([self.currentWord characterAtIndex:i] != '_') {
			[newWord appendFormat:@"%c" , [self.currentWord characterAtIndex:i]];
		}
		else {
			if([word characterAtIndex:i] != '_') {
				[newWord appendFormat:@"%c" , input];
			}
			else {
				[newWord appendString:@"_"];
				count++;
			}
		}
	}
	
	// A user guessed wrong, if the new word happens to be the same as the word on screen.
	if([self.currentWord isEqualToString:newWord]) {
		currentTries++;
		
		[self.settings setInteger:floor(currentTries / (totalTries * 1.0F) * 10) forKey:@"IndexImage"];
		
		// The game is lost whenever currentTries is equal or exceeded by totalTries
		if(currentTries >= totalTries) {
			// Set a random word whenever the game is lost from the remaining, 1 is the lower bound, index 0 has no real word, but our comparison word
			// The length of the list is the upperbound of our range.
			int randomIndex = 1 + arc4random() % (remainingWords.count - 1);
			self.currentWord = [remainingWords objectAtIndex:randomIndex];
			
			[self.settings setBool:YES forKey:@"GameLost"];
			[self.settings synchronize];
		}
	}
	else {
		self.currentWord = newWord;
	}
	
	// If there are no more empty spots left, the gam is won and YES will be returned.
	if(count == 0) {
		return YES;
	}
	return NO;
}

/*
 *	Used to compare words, to decide in what group they belong.
 */
- (NSMutableString *)createHangmanWord:(NSString *)word withInput:(char)input {
	NSMutableString * newWord = [[NSMutableString alloc] init];
	
	for(int i = 0; i < word.length; i++) {
		if([word characterAtIndex:i] == input) {
			[newWord appendString:@"X"];
		}
		else {
			[newWord appendString:@"_"];
		}
	}
	
	return newWord;
}

/*
 *	Used to check what wordlist has the least revealed letters, whenever they contain the same amount of words.
 */
- (int)revealedCharInWord: (NSString *)word {
	int count = 0;
	
	for(int i = 0; i < word.length; i++) {
		if([word characterAtIndex:i] == 'X') {
			count++;
		}
	}
	
	return count;
}

@end