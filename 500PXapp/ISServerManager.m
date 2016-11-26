//
//  ISServerManager.m
//  500PXapp
//
//  Created by Smirnov Ivan on 22.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISServerManager.h"
#import "AFNetworking.h"
//#import "AFOAuth1Client.h"

@interface ISServerManager()


@end


@implementation ISServerManager

+(ISServerManager*) sharedManager{
    
    static ISServerManager* manager=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager=[[ISServerManager alloc]init];
        
    });
    
    return manager;
}


-(void)autorizeUser:(NSString*)term tag:(NSString*)tag
               page:(NSInteger)page rpp:(NSInteger)rpp
               tags:(NSArray*)tags
          onSuccess:(void(^)(NSArray* photos)) success
          onFailure:(void(^)(NSError* error,NSInteger statusCode))failure{
    
    
    
    
    
}



-(void)getBlog{
    
    
}







-(void)getPhotosWithTerm:(NSString*)term tag:(NSString*)tag
                    page:(NSInteger)page rpp:(NSInteger)rpp
                    tags:(NSArray*)tags
               onSuccess:(void(^)(NSArray* photos)) success
               onFailure:(void(^)(NSError* error,NSInteger statusCode))failure{
    
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:
                         term,@"term",tag,@"tag",
                         @(page),@"page",@(rpp),@"rpp",
                         tags,@"tags"
                         ,@"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI",@"consumer_key", nil];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    
}


@end
