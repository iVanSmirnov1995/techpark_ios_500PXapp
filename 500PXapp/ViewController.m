//
//  ViewController.m
//  500PXapp
//
//  Created by Smirnov Ivan on 16.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

<<<<<<< HEAD
@implementation ViewController 

-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return  UIStatusBarStyleLightContent;
}




=======
@implementation ViewController
>>>>>>> origin/master

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
<<<<<<< HEAD
    [self.loginField setFrame:CGRectMake(20, 331, 331, 75)];
    
    self.loginField.textAlignment = NSTextAlignmentCenter;
    UIColor *logincolor = [UIColor whiteColor];
    self.loginField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Имя пользователя или емайл"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: logincolor,
                                                 NSFontAttributeName : [UIFont fontWithName:@"PingFang-TC-Ultralight" size:18.0]
                                                 }
     ];
    
    [self.passwordField setFrame:CGRectMake(20, 423, 331, 75)];
    
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    UIColor *passwordcolor = [UIColor whiteColor];
    self.passwordField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Пароль"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: passwordcolor,
                                                 NSFontAttributeName : [UIFont fontWithName:@"PingFang-TC-Ultralight" size:18.0]
                                                 }
     
     ];
    
 

[self.enterButton setFrame:CGRectMake(22, 515, 330, 45)];
   
}


#pragma mark - Action

- (IBAction)actionTextField:(UITextField *)sender {
    
    
    
}

- (IBAction)enterButton:(UIButton *)sender {
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

=======
    NSLog(@"Hello world");
}


>>>>>>> origin/master
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

<<<<<<< HEAD
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.loginField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -0.5f * keyboardSize.height;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}


=======
>>>>>>> origin/master

@end
