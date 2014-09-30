//
//  FlipsideViewController.h
//  Evil-Hangman-iOS
//
//  Created by Olaf Van Houten on 09/09/14.
//  Copyright (c) 2014 Olaf van Houten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameObject.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;

@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) GameObject * game;

- (IBAction)done:(id)sender;

- (IBAction)changeWordlength:(UISlider *)sender;

- (IBAction)changeDisableLetters:(UISwitch *)sender;

- (IBAction)changeTotalTries:(UISlider *)sender;

- (IBAction)resetGame:(UIButton *)sender;

@end
