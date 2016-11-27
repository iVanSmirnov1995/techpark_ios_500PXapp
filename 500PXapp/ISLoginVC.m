//
//  ISLoginVC.m
//  500PXapp
//
//  Created by Smirnov Ivan on 22.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISLoginVC.h"

#import "ISAccessToken.h"
#import "ISServerManager.h"
#import "AFOAuth1Client.h"

@interface ISLoginVC ()

@end

@implementation ISLoginVC


//- (id) initWithCompletionBlock:(ASLoginCompletionBlock) completionBlock {
//    
//    self = [super init];
//    if (self) {45
//        self.completionBlock = completionBlock;
//    }
//    return self;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    
    
//    AFOAuth1Client* cl=[[AFOAuth1Client alloc]initWithBaseURL:
//                        [NSURL URLWithString:@"https://api.500px.com" ]
//                            key:@"H6PBYhS5q48HriBNYeNToETzacIg0A89BqkPmQki"
//                            secret:@"zB0X4fpSYpGi2jifqelLkAP3OaBUCVMlVSLJn90j"];
//    
//    
//    
//    [cl authorizeUsingOAuthWithRequestTokenPath:@"v1/oauth/request_token"
//                          userAuthorizationPath:@"v1/oauth/authorize"
//                          callbackURL:[NSURL URLWithString:@"https://500px.com"]
//                                accessTokenPath:@"v1/oauth/access_token" accessMethod:@"POST" scope:nil success:^(AFOAuth1Token *accessToken, id responseObject) {
//                                        
//                                        NSLog(@"%@",accessToken);
//                                        
//                                    } failure:^(NSError *error) {
//                                        
//                                        NSLog(@"%@",error);
//                                        
//                                    }];
//    
//    
    
    
//    
//    AFOAuth1Client *client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@""]key:kConsumerKey secret:kConsumerSecret];
//    [client authorizeUsingOAuthWithRequestTokenPath:@"http://api.XXX.com/oauth/request_token" userAuthorizationPath:@"http://www.XXX.com/oauth/authorize" callbackURL:nil accessTokenPath:@"http://api.XXX.com/oauth/access_token" accessMethod:@"Identity"
//                                            success:^(AFOAuth1Token *accessToken) {
//                                                NSLog(@"successful login");
//                                            } failure:^(NSError *error) {
//                                                NSLog(@"could not login error %@", error);
//                                            }];
    
    
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegete

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"ckvb./");
    
    
//    if ([[[request URL] host] isEqualToString:@"hello.there"]) {
//        
//        ISAccessToken* token = [[ISAccessToken alloc] init];
//        
//        NSString* query = [[request URL] description];
//        
//        NSArray* array = [query componentsSeparatedByString:@"#"];
//        
//        if ([array count] > 1) {
//            query = [array lastObject];
//        }
//        
//        NSArray* pairs = [query componentsSeparatedByString:@"&"];
//        
//        for (NSString* pair in pairs) {
//            
//            NSArray* values = [pair componentsSeparatedByString:@"="];
//            
//            if ([values count] == 2) {
//                
//                NSString* key = [values firstObject];
//                
//                if ([key isEqualToString:@"access_token"]) {
//                    token.token = [values lastObject];
//                } else if ([key isEqualToString:@"expires_in"]) {
//                    
//                    NSTimeInterval interval = [[values lastObject] doubleValue];
//                    
//                    token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
//                    
//                } else if ([key isEqualToString:@"user_id"]) {
//                    
//                    token.userID = [values lastObject];
//                }
//            }
//        }
//        
//        self.webView.delegate = nil;
//        
//        if (self.completionBlock) {
//            self.completionBlock(token);
//        }
//        
//        
//        
//        [self dismissViewControllerAnimated:YES
//                                 completion:nil];
//        
//        return NO;
//    }
//    
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
