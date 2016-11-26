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
    // Do any additional setup after loading the view.
    NSString* urlString =
    @"https://api.500px.com/v1/oauth/request_token"
    "oauth_token=TOKEN_HERE&"
    "oauth_token_secret=SECRET_HERE&" // + 2 + 4 + 16 + 131072 + 8192
    "oauth_callback_confirmed=true";
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
   // [self.webView loadRequest:request];
    
    [[ISServerManager sharedManager] autorizeUser:@"" tag:@"" page:1 rpp:1 tags:@[] onSuccess:^(NSArray *photos) {
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
    
    
    
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
