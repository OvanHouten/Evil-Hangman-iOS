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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Flipside View

/*
 *	Start a new game if the user is done with the flipside and pressed the resetgame button.
 */
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
	
	if([self.game.settings boolForKey:@"ResetGame"] == YES) {
		[self startNewGame];
	}
}

/*
 *	Before segue, we want to give our Flipside a pointer to the game object. This way it can acces the settings.
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([[segue identifier] isEqualToString:@"showAlternate"]) {
		[[segue destinationViewController] setDelegate:self];
		FlipsideViewController * controller = (FlipsideViewController *)segue.destinationViewController;
		controller.game = self.game;
	}
}

/*
 *	Action for when a keyboard button is pressed. Triggers the game object to check input. If the game has been won or lost, the player recieves a popup alert.
 */
- (IBAction)keyboardButton:(UIButton *)sender {
	if([self.game.settings boolForKey:@"DisableLetters"] == YES) {
		sender.enabled = NO;
	}
	
	// Check if the user has won or lost. Disable buttons and ask for a new game if this is the case.
	if([self.game checkInput:[sender.titleLabel.text characterAtIndex:0]]) {
		for(int i = 0; i < self.allKeyboardButtons.count; i++) {
			UIButton * button = [self.allKeyboardButtons objectAtIndex:i];
			button.enabled = NO;
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Won!!!" message:@"Would you like another try?" delegate:self cancelButtonTitle:@"No, thanks." otherButtonTitles:@"Yes, please.", nil];
		[alert show];
	}
	else if([self.game.settings boolForKey:@"GameLost"]) {
		for(int i = 0; i < self.allKeyboardButtons.count; i++) {
			UIButton * button = [self.allKeyboardButtons objectAtIndex:i];
			button.enabled = NO;
		}
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Lost :(" message:@"Would you like another try?" delegate:self cancelButtonTitle:@"No, thanks." otherButtonTitles:@"Yes, please.", nil];
		[alert show];
	}

	// Update the image
	self.progressImage.image = [UIImage imageNamed:[NSMutableString stringWithFormat:@"Hangman_progress_%ld", (long)[self.game.settings integerForKey:@"IndexImage"]]];
	self.wordLabel.text = self.game.currentWord;
}

/*
 *	When a user presses the second button (index 1) start a new game. This is the case for both popup alerts on this view.
 */
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if(buttonIndex == 1) {
		[self startNewGame];
	}
}

/*
 *	When starting a new game, reset some settings in case they have been set. Reset the Image. Re-enable all buttons, and then create the game object.
 */
- (void)startNewGame {
	self.game = [[GameObject alloc] init];

	[self.game.settings setBool:NO forKey:@"ResetGame"];
	[self.game.settings setBool:NO forKey:@"GameLost"];
	[self.game.settings setInteger:0 forKey:@"IndexImage"];
	[self.game.settings synchronize];
	
	for(int i = 0; i < self.allKeyboardButtons.count; i++) {
		UIButton * button = [self.allKeyboardButtons objectAtIndex:i];
		button.enabled = YES;
	}
	
	self.progressImage.image = [UIImage imageNamed:@"Hangman_progress_0"];
	self.wordLabel.text = self.game.currentWord;
}
@end
