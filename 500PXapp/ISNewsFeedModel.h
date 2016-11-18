//
//  ISNewsFeedModel.h
//  500PXapp
//
//  Created by Smirnov Ivan on 18.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ISNewsFeedModel : NSObject


@property(strong,nonatomic)NSString* imageName;
@property(strong,nonatomic)NSString* userName;
@property(strong,nonatomic)NSString* userImageName;
@property(strong,nonatomic)NSString* data;
@property(strong,nonatomic)NSString* countLike;
@property(strong,nonatomic)NSString* lastComent;


@end
