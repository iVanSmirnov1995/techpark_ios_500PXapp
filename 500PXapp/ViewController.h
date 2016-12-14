//
//  ViewController.h
//  500PXapp
//
//  Created by Smirnov Ivan on 16.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (weak, nonatomic) IBOutlet UIButton *oauthButton;

- (IBAction)enterButton:(UIButton *)sender;
- (IBAction)oauthAction:(UIButton *)sender;

@end
