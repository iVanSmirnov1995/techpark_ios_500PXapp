//
//  ViewController.h
//  500PXapp
//
//  Created by Smirnov Ivan on 16.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

<<<<<<< HEAD
<<<<<<< HEAD
@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@property (weak ,nonatomic) IBOutlet UITextField* loginField;
@property (weak ,nonatomic) IBOutlet UITextField* passwordField;

- (IBAction)actionTextField:(UITextField *)sender;
- (IBAction)enterButton:(UIButton *)sender;
=======
@interface ViewController : UIViewController

>>>>>>> origin/master
=======
@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@property (weak ,nonatomic) IBOutlet UITextField* loginField;
@property (weak ,nonatomic) IBOutlet UITextField* passwordField;
>>>>>>> fb8c30de1a0731aed17dac0bb1540e195168ee12

- (IBAction)actionTextField:(UITextField *)sender;
- (IBAction)enterButton:(UIButton *)sender;

@end
