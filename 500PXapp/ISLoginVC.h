//
//  ISLoginVC.h
//  500PXapp
//
//  Created by Smirnov Ivan on 22.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISAccessToken;

@interface ISLoginVC : UIViewController

typedef void(^ASLoginCompletionBlock)(ISAccessToken* token);

@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (id) initWithCompletionBlock:(ASLoginCompletionBlock) completionBlock;


@end
