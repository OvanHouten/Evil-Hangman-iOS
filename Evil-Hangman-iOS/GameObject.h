//
//  GameObject.h
//  Evil-Hangman-iOS
//
//  Created by Olaf Van Houten on 24/09/14.
//  Copyright (c) 2014 Olaf van Houten. All rights reserved.
//

#ifndef Evil_Hangman_iOS_GameObject_h
#define Evil_Hangman_iOS_GameObject_h

#import "WordList.h"

@class GameObject;

@interface GameObject : NSObject

@property NSMutableString * currentWord;

@property WordList * list;

- (id)init;

- (NSMutableString *)checkInput:(char)input;

- (NSMutableString *)createHangmanWord:(NSString *)word withInput:(char)input;

- (BOOL)updateObfuscatedWord:(NSMutableString *)word withInput:(char)input;

@end

#endif
