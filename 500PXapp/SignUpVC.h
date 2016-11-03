//
//  SignUpVC.h
//  500PXapp
//
//  Created by Максим Стегниенко on 27.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpVC : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)actionTextField:(UITextField*)sender;

@end
