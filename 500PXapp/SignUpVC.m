//
//  SignUpVC.m
//  500PXapp
//
//  Created by Максим Стегниенко on 27.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "SignUpVC.h"

@interface SignUpVC ()

@end

@implementation SignUpVC

-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return  UIStatusBarStyleLightContent;
}





- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    [self.loginField1 setFrame:CGRectMake(25, 142, 331, 75)];
    
    self.loginField1.textAlignment = NSTextAlignmentCenter;
    UIColor *logincolor = [UIColor whiteColor];
    self.loginField1.attributedPlaceholder =
    [[NSMutableAttributedString alloc] initWithString:@"Емайл"
                                           attributes:@{
                                                        NSForegroundColorAttributeName: logincolor,
                                                        NSFontAttributeName : [UIFont fontWithName:@"PingFang-TC-Light" size:18.0],
                                                        NSKernAttributeName :@(0.6)
                                                        }
     ];
    
    [self.passwordField1 setFrame:CGRectMake(25, 238, 331, 75)];
    
    self.passwordField1.textAlignment = NSTextAlignmentCenter;
    UIColor *passwordcolor = [UIColor whiteColor];
    self.passwordField1.attributedPlaceholder =
    [[NSMutableAttributedString alloc] initWithString:@"Имя пользователя или емайл"
                                           attributes:@{
                                                        NSForegroundColorAttributeName: passwordcolor,
                                                        NSFontAttributeName : [UIFont fontWithName:@"PingFang-TC-Light" size:18.0],
                                                        NSKernAttributeName :@(0.6)
                                                        }
     ];
    
    
    
   self.backButton.titleLabel.attributedText =
    [[NSMutableAttributedString alloc] initWithString:@"У меня уже есть аккаунт"
                                           attributes:@{
                                                        NSForegroundColorAttributeName: passwordcolor,
                                                        NSFontAttributeName : [UIFont fontWithName:@"PingFang-TC-Light" size:18.0],
                                                        NSKernAttributeName :@(0.6)
                                                        }
     ];
  
}


#pragma mark - Action

- (IBAction)actionTextField:(UITextField *)sender {
    
    
    
}

- (IBAction)back:(id)sender {
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    if ([self.loginField1 isEqual: textField]) {
        [self.passwordField1 becomeFirstResponder];
    } else {
        [self.loginField1 resignFirstResponder];
        [self.passwordField1 resignFirstResponder];
    }
    return NO;
}





#pragma mark - changeViewPositionFromKeyboard

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.loginField1 resignFirstResponder];
    [self.passwordField1 resignFirstResponder];
    
}







@end
