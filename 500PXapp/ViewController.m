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
#import "ISUserData+CoreDataProperties.h"
#import "ISUser.h"

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
                        
                        ISUserData* userData=[NSEntityDescription insertNewObjectForEntityForName:@"ISUserData"
                            inManagedObjectContext:self.managedObjectContext];
                        
                        
                        if (![user.fullName isKindOfClass:[NSNull class]]) {
                            userData.name=user.fullName;
                        }
                        if (user.userId) {
                            userData.userID=user.userId;
                        }
                        if (![self.oauthToken isKindOfClass:[NSNull class]]) {
                            userData.oauthToken=self.oauthToken;
                        }
                        if (![self.oauthTokenSecret isKindOfClass:[NSNull class]]) {
                            
                            userData.oauthTokenSecret=self.oauthTokenSecret;
                        }
                        if (![user.firstName isKindOfClass:[NSNull class]]) {
                            userData.firstName = user.firstName;
                        }
                        if (![user.lastName isKindOfClass:[NSNull class]]) {
                            userData.lastName = user.lastName;
                        }
                        if (user.followersCount) {
                            userData.followersCount = user.followersCount;
                        }
                      //  userData.friendsCount = user.friendsCount;
                        if (![user.cover isKindOfClass:[NSNull class]]) {
                            
                            userData.cover = user.cover;
                        }
                        
                        userData.avatar = user.avatar;
                        userData.userName = user.username;
                        
                        
                        [self.managedObjectContext save:nil];
                        
                        
                        
                        [[ISServerManager sharedManager]setUser:user];
                        
                        [self dismissViewControllerAnimated:YES completion: ^{
                            self.oauth1Controller = nil;
                            [self.delegate vcDidDismiss:self];
                            
                            
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
