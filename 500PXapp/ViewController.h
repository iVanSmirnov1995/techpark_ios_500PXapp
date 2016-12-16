//
//  ViewController.h
//  500PXapp
//
//  Created by Smirnov Ivan on 16.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISCoreDataViewController.h"

@protocol ISModalDelegate;

@interface ViewController : ISCoreDataViewController <UITextFieldDelegate>

@property (weak, nonatomic) id <ISModalDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (weak, nonatomic) IBOutlet UIButton *oauthButton;

- (IBAction)oauthAction:(UIButton *)sender;

@end

@protocol ISModalDelegate

@required


- (void) vcDidDismiss:(ViewController*) vc;


@end
