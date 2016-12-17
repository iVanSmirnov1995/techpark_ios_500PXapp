//
//  ISUser.h
//  500PXapp
//
//  Created by Smirnov Ivan on 02.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISUser : NSObject

@property(assign,nonatomic)long userId;
@property(strong,nonatomic)NSString* firstName;
@property(assign,nonatomic)NSString* lastName;
@property(assign,nonatomic)NSString* username;
@property(strong,nonatomic)NSString* city;
@property(assign,nonatomic)BOOL sex;
@property(assign,nonatomic)NSString* avatar;
@property(assign, nonatomic)NSString* cover;
@property(assign, nonatomic)NSInteger friendsCount;
@property(assign, nonatomic)NSInteger followersCount;
@property(assign, nonatomic)NSString* fullName;

@end
