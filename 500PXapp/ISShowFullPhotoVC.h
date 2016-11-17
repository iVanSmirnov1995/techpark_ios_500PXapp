//
//  ISShowFullPhotoVC.h
//  500PXapp
//
//  Created by Smirnov Ivan on 17.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISShowFullPhotoVC : UIViewController

@property(assign,nonatomic)NSInteger pageIndex;

@property (weak, nonatomic) IBOutlet UIImageView *photo;



@end
