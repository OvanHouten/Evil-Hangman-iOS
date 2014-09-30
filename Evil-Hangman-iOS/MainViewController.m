//
//  MainViewController.m
//  Evil-Hangman-iOS
//
//  Created by Olaf Van Houten on 09/09/14.
//  Copyright (c) 2014 Olaf van Houten. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <NSFileManagerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self startNewGame];
//	self.game = [[GameObject alloc] init];
//	self.wordLabel.text = self.game.currentWord;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
	
	if([self.game.settings boolForKey:@"ResetGame"] == YES) {
		[self startNewGame];
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([[segue identifier] isEqualToString:@"showAlternate"]) {
		[[segue destinationViewController] setDelegate:self];
		FlipsideViewController * controller = (FlipsideViewController *)segue.destinationViewController;
		controller.game = self.game;
	}
}

- (IBAction)keyboardButton:(UIButton *)sender {
	if([self.game.settings boolForKey:@"DisableLetters"] == YES) {
		sender.enabled = NO;
	}
	if([self.game checkInput:[sender.titleLabel.text characterAtIndex:0]]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Won!!!" message:@"Would you like another try?" delegate:self cancelButtonTitle:@"No, thanks." otherButtonTitles:@"Yes, please.", nil];
		[alert show];
	}
	else if([self.game.settings boolForKey:@"GameLost"]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Lost :(" message:@"Would you like another try?" delegate:self cancelButtonTitle:@"No, thanks." otherButtonTitles:@"Yes, please.", nil];
		[alert show];
	}
	
	self.wordLabel.text = self.game.currentWord;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1) {
		[self startNewGame];
	}
}

- (void)startNewGame {
	[self.game.settings setBool:NO forKey:@"ResetGame"];
	[self.game.settings setBool:NO forKey:@"GameLost"];
	[self.game.settings synchronize];
	
	for(int i = 0; i < self.allKeyboardButtons.count; i++) {
		UIButton * button = [self.allKeyboardButtons objectAtIndex:i];
		button.enabled = YES;
	}
	self.game = [[GameObject alloc] init];
	self.wordLabel.text = self.game.currentWord;
}
@end
