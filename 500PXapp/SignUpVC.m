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
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.loginField setFrame:CGRectMake(25, 142, 331, 75)];
    
    self.loginField.textAlignment = NSTextAlignmentCenter;
    UIColor *logincolor = [UIColor whiteColor];
    self.loginField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Емайл"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: logincolor,
                                                 NSFontAttributeName : [UIFont fontWithName:@"PingFang-TC-Ultralight" size:18.0]
                                                 }
     ];
    
    [self.passwordField setFrame:CGRectMake(25, 238, 331, 75)];
    
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    UIColor *passwordcolor = [UIColor whiteColor];
    self.passwordField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Создать пароль"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: passwordcolor,
                                                 NSFontAttributeName : [UIFont fontWithName:@"PingFang-TC-Ultralight" size:18.0]
                                                 }
     
     ];
    
    
    
   
    
}


#pragma mark - Action


- (IBAction)actionTextField:(UITextField *)sender {
    
    
    
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    if ([self.loginField isEqual: textField]) {
        [self.passwordField becomeFirstResponder];
    } else {
        [self.loginField resignFirstResponder];
        [self.passwordField resignFirstResponder];
    }
    return NO;
}





#pragma mark - changeViewPositionFromKeyboard

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.loginField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
}







@end
