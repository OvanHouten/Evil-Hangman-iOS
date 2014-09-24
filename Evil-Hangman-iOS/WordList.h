//
//  WordList.h
//  Evil-Hangman-iOS
//
//  Created by Olaf Van Houten on 24/09/14.
//  Copyright (c) 2014 Olaf van Houten. All rights reserved.
//

#ifndef Evil_Hangman_iOS_WordList_h
#define Evil_Hangman_iOS_WordList_h

@class WordList;

@interface WordList : NSObject

@property NSMutableArray * words;

- (WordList *)init;

@end

#endif
