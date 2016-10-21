//
//  ISNewsFeedModel.h
//  500PXapp
//
//  Created by Smirnov Ivan on 18.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ISNewsFeedModel : NSObject

@property(strong,nonatomic)UIImage* image;
@property(strong,nonatomic)NSString* userName;
@property(strong,nonatomic)UIImage* userImage;
@property(strong,nonatomic)NSString* data;
@property(strong,nonatomic)NSString* countLike;


@end
