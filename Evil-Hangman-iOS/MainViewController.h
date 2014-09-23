//
//  MainViewController.h
//  Evil-Hangman-iOS
//
//  Created by Olaf Van Houten on 09/09/14.
//  Copyright (c) 2014 Olaf van Houten. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

- (IBAction)keyboardButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@end
