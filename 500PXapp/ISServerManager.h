//
//  ISServerManager.h
//  500PXapp
//
//  Created by Smirnov Ivan on 22.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//
//#import <CommonCrypto/CommonHMAC.h>
#import <Foundation/Foundation.h>

@class ISUser,BDBOAuth1Credential,BDBOAuth1SessionManager,ISNewsFeedModel;
@interface ISServerManager : NSObject

+(ISServerManager*) sharedManager;

-(BDBOAuth1SessionManager*)loginUserOnSuccess:(void(^)(BDBOAuth1Credential *requestToken)) success
                                    onFailure:(void(^)(NSError* error))failture;

-(void)getBlog;


-(void)autorizeUser:(NSString*)term tag:(NSString*)tag
                    page:(NSInteger)page rpp:(NSInteger)rpp
                    tags:(NSArray*)tags
               onSuccess:(void(^)(NSArray* photos)) success
               onFailure:(void(^)(NSError* error,NSInteger statusCode))failure;


-(void)getPopularPhotosOnSuccess:(void(^)(NSArray* photos)) success
                       onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;

-(void)getUserFriendsPhotoNewsOnSuccess:(void(^)(NSMutableArray* newsAr)) success
                              onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;


-(void)getPhotosWithTerm:(NSString*)term tag:(NSString*)tag
                    page:(NSInteger)page rpp:(NSInteger)rpp
                    tags:(NSArray*)tags
               onSuccess:(void(^)(NSArray* photos)) success
               onFailure:(void(^)(NSError* error,NSInteger statusCode))failure;

-(void)getFolowerOnSuccess:(void(^)(NSArray* news)) success
                 onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;

-(void)getUserOnSuccess:(void(^)(ISUser* user)) success
              onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;


@end
