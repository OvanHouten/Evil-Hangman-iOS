//
//  FlipsideViewController.m
//  Evil-Hangman-iOS
//
//  Created by Olaf Van Houten on 09/09/14.
//  Copyright (c) 2014 Olaf van Houten. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@property (weak, nonatomic) IBOutlet UISlider *wordLength;
@property (weak, nonatomic) IBOutlet UISlider *totalTries;
@property (weak, nonatomic) IBOutlet UISwitch *disableLetters;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTriesLabel;

@end

@implementation FlipsideViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.disableLetters.on = [self.game.settings boolForKey:@"DisableLetters"];
	self.wordLength.value = [self.game.settings integerForKey:@"Wordlength"];
	self.wordLengthLabel.text = [NSString stringWithFormat:@"Length of words: %d", (int)self.wordLength.value];
	self.totalTries.value = [self.game.settings integerForKey:@"TotalTries"];
	self.totalTriesLabel.text = [NSString stringWithFormat: @"Total tries: %d", (int)self.totalTries.value];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)changeDisableLetters:(UISwitch *)sender {
	[self.game.settings setBool:sender.on forKey:@"DisableLetters"];
	[self.game.settings synchronize];
}

- (IBAction)changeWordlength:(UISlider *)sender {
	[self.game.settings setInteger:(int)sender.value forKey:@"Wordlength"];
	[self.game.settings synchronize];
	self.wordLengthLabel.text = [NSString stringWithFormat: @"Length of words: %d", (int)self.wordLength.value];
}

- (IBAction)changeTotalTries:(UISlider *)sender {
	[self.game.settings setInteger:(int)sender.value forKey:@"TotalTries"];
	[self.game.settings synchronize];
	self.totalTriesLabel.text = [NSString stringWithFormat: @"Total tries: %d", (int)self.totalTries.value];
}

- (IBAction)resetGame:(UIButton *)sender {
	[self.game.settings setBool:YES forKey:@"ResetGame"];
	[self.game.settings synchronize];
}

@end