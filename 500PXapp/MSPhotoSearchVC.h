//
//  MSPhotoSearchVC.h
//  500PXapp
//
//  Created by Максим Стегниенко on 18.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSPhotoSearchVC : UIViewController
- (IBAction)backbutton:(id)sender;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;


@property (weak, nonatomic) IBOutlet UIImageView *imagePhoto;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak,nonatomic)  NSString *str;
@property (weak,nonatomic) NSURL *url;

@property (assign, nonatomic) BOOL hasFixedHeight;


@end
