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
@property(assign,nonatomic)NSInteger userID;
@property(assign,nonatomic)long photoID;
@property(strong,nonatomic)NSString* userImageName;
@property(strong,nonatomic)NSDate* data;
@property(assign,nonatomic)NSInteger countLike;
@property(strong,nonatomic)NSString* lastComent;


@end
