//
//  ISServerManager.m
//  500PXapp
//
//  Created by Smirnov Ivan on 22.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISServerManager.h"
#import "AFNetworking.h"

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
    [manager GET:@"https://api.500px.com/v1/photos/search" parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSArray* dictsArray = [responseObject objectForKey:@"response"];
        
        if (success) {
            success(dictsArray);
        }
        
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (failure) {
         //   failure(error, operation.response.statusCode);
        }
        
        
        
    }];
    
}


@end
