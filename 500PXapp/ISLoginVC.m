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

@property(strong,nonatomic)NSString* token;
@property(strong,nonatomic)NSString* tokenSecret;


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
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegete


#pragma mark-step3

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
 }

    
 //   [self finishedAthourizationProcessWithUserId:userId AccessToken:params[@"oauth_token"] AccessTokenSecret:params[@"oauth_token_secret"]];



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
