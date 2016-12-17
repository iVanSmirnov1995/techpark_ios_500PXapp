//
//  MyPageVC.h
//  500PXapp
//
//  Created by user on 20.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISCoreDataViewController.h"

@interface MyPageVC :  ISCoreDataViewController <UITextFieldDelegate>

@property (assign, nonatomic) NSInteger userID;

@end
