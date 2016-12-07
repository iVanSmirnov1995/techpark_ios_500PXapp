//
//  ISLoginVC.m
//  500PXapp
//
//  Created by Smirnov Ivan on 22.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISLoginVC.h"

#import "BDBOAuth1SessionManager.h"
#import "ISServerManager.h"
#import "ISUser.h"
#import "ISLoginVC.h"

@interface ISLoginVC ()

@property(strong,nonatomic)BDBOAuth1SessionManager* manager;

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
    
    
    self.manager=[[ISServerManager sharedManager]loginUserOnSuccess:^(BDBOAuth1Credential *requestToken) {
        
        NSString *authURLString = [@"https://api.500px.com/v1/oauth/authorize" stringByAppendingFormat:@"?oauth_token=%@", requestToken.token];
        
        
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:
                                   [NSURL URLWithString:authURLString]]];
        
        
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:authURLString] options:nil completionHandler:nil];
        
        
    } onFailure:^(NSError *error) {
        
        NSLog(@"1 %@",error);
        
    }];

    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegete

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    
    
    
    NSLog(@"%@",[[request URL] description]);
    
    
    
    
    
    BDBOAuth1Credential* requestToken=[BDBOAuth1Credential credentialWithQueryString:
                                       request.URL.query];
    
    
    
    [self.manager fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST"
                              requestToken:requestToken success:^(BDBOAuth1Credential *accessToken) {
                                  
                                  
                                  [[ISServerManager sharedManager]getUserOnSuccess:^(ISUser *user) {
                                      

                                      
                                      
                                  } onFailure:^(NSError *error, NSInteger statusCode) {
                                      NSLog(@"user id error %@",error);
                                  } ];
                                  
                                  
                                  
                              } failure:^(NSError *error) {
                                  
                                  NSLog(@"2 %@",error.localizedDescription);
                                  
                              }];
     
    
    
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
