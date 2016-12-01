//
//  ISServerManager.h
//  500PXapp
//
//  Created by Smirnov Ivan on 22.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISServerManager : NSObject

+(ISServerManager*) sharedManager;


-(void)getBlog;


-(void)autorizeUser:(NSString*)term tag:(NSString*)tag
                    page:(NSInteger)page rpp:(NSInteger)rpp
                    tags:(NSArray*)tags
               onSuccess:(void(^)(NSArray* photos)) success
               onFailure:(void(^)(NSError* error,NSInteger statusCode))failure;


-(void)getPopularPhotosOnSuccess:(void(^)(NSArray* photos)) success
                       onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;




-(void)getPhotosWithTerm:(NSString*)term tag:(NSString*)tag
                    page:(NSInteger)page rpp:(NSInteger)rpp
                    tags:(NSArray*)tags
               onSuccess:(void(^)(NSArray* photos)) success
               onFailure:(void(^)(NSError* error,NSInteger statusCode))failure;

@end
