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
@property(strong,nonatomic)NSString* lastName;
@property(strong,nonatomic)NSString* username;
@property(strong,nonatomic)NSString* city;
@property(assign,nonatomic)BOOL sex;
@property(strong,nonatomic)NSString* avatar;
@property(strong, nonatomic)NSString* cover;
@property(assign, nonatomic)NSInteger friendsCount;
@property(assign, nonatomic)NSInteger followersCount;
@property(strong, nonatomic)NSString* fullName;

-(ISUser*)createUserWithResponseObject:(id)responseObject;

@end
