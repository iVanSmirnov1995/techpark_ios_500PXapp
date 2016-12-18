//
//  ISUser.m
//  500PXapp
//
//  Created by Smirnov Ivan on 02.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISUser.h"

@implementation ISUser

-(ISUser*)createUserWithResponseObject:(id)responseObject{
    
    ISUser* user=[[ISUser alloc]init];
    NSDictionary* userDic = [responseObject objectForKey: @"user"];
    user.firstName=[userDic objectForKey:@"firstname"];
    user.lastName=[userDic objectForKey:@"lastname"];
    user.sex=[[userDic objectForKey:@"sex"]floatValue];
    user.city=[userDic objectForKey:@"city"];
    user.avatar=[[[userDic objectForKey:@"avatars"]objectForKey:@"small"] objectForKey:@"https"];
    user.userId=[[userDic objectForKey:@"id"]longValue];
    user.username=[userDic objectForKey:@"username"];
    user.cover = [userDic objectForKey:@"cover_url"];
    user.friendsCount = [[userDic objectForKey:@"friends_count"] integerValue];
    user.followersCount = [[userDic objectForKey:@"followers_count"] integerValue];
    user.fullName = [ userDic objectForKey:@"full_name"];
    return user;
    
    
}


@end
