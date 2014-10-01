//
//  MainViewController.h
//  Evil-Hangman-iOS
//
//  Created by Olaf Van Houten on 09/09/14.
//  Copyright (c) 2014 Olaf van Houten. All rights reserved.
//

#import "FlipsideViewController.h"
#import "GameObject.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIAlertViewDelegate>

@property GameObject * game;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allKeyboardButtons;
@property (strong, nonatomic) IBOutlet UIImageView *progressImage;

- (IBAction)keyboardButton:(UIButton *)sender;

@end
