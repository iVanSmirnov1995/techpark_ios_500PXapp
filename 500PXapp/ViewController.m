//
//  ViewController.m
//  500PXapp
//
//  Created by Smirnov Ivan on 16.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ViewController.h"
#import "ISServerManager.h"
#import "OAuth1Controller.h"
#import "LoginWebViewController.h"
#import "ISTabBarVC.h"

@interface ViewController ()
@property (nonatomic, strong) OAuth1Controller *oauth1Controller;
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *oauthTokenSecret;

@end

@implementation ViewController

-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return  UIStatusBarStyleLightContent;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


#pragma mark - Action




- (IBAction)oauthAction:(UIButton *)sender {
    
    [self loginTapped];
 
}




#pragma mark - changeViewPositionFromKeyboard

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (void)loginTapped
{
    LoginWebViewController *loginWebViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginWebViewController"];
    
    [self presentViewController:loginWebViewController
                       animated:YES
                     completion:^{
                         
                         [self.oauth1Controller loginWithWebView:loginWebViewController.webView completion:^(NSDictionary *oauthTokens, NSError *error) {
                             if (!error) {
                                 // Store your tokens for authenticating your later requests, consider storing the tokens in the Keychain
                                 self.oauthToken = oauthTokens[@"oauth_token"];
                                  self.oauthTokenSecret = oauthTokens[@"oauth_token_secret"];
                                 NSLog(@"%@",self.oauthTokenSecret);
                                 
                                 [[ISServerManager sharedManager]setOauthTokenSecret:self.oauthTokenSecret];
                                 [[ISServerManager sharedManager]setOauthToken:self.oauthToken];
                                 
                    [[ISServerManager sharedManager]getUserOnSuccess:^(ISUser *user) {
                        
                        NSLog(@"%@",user);
                        
                        [[ISServerManager sharedManager]setUser:user];
                        
                        [self dismissViewControllerAnimated:YES completion: ^{
                            self.oauth1Controller = nil;
                            
                            ISTabBarVC* vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ISTabBarVC"];
                            [self presentViewController:vc animated:YES completion: nil];
                            
                            
                            
                        }];
                        
                        
                    } onFailure:^(NSError *error, NSInteger statusCode) {
                        
                    }];
                                 
                             }
                             else
                             {
                                 NSLog(@"Error authenticating: %@", error.localizedDescription);
                             }

                         }];
                     }];
}


- (OAuth1Controller *)oauth1Controller
{
    if (_oauth1Controller == nil) {
        _oauth1Controller = [[OAuth1Controller alloc] init];
    }
    return _oauth1Controller;
}



@end
