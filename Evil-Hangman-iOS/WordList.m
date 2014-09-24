//
//  WordList.m
//  Evil-Hangman-iOS
//
//  Created by Olaf Van Houten on 24/09/14.
//  Copyright (c) 2014 Olaf van Houten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordList.h"

@interface WordList ()

@end

@implementation WordList

- (WordList *)init {
    self.words = [[NSMutableArray alloc] init];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    NSMutableArray * dictionary = [NSMutableArray arrayWithContentsOfFile:path];
    int length = 24;
    
    for (int i = 0; i < dictionary.count; i++) {
        if([[dictionary objectAtIndex:i] length] == length) {
            [self.words addObject:[dictionary objectAtIndex:i]];
            NSLog(@"%@", [dictionary objectAtIndex:i]);
        }
    }
    
    NSLog(@"%d", self.words.count);
    
    return self;
}

@end