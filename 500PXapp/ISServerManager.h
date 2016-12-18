//
//  ISServerManager.h
//  500PXapp
//
//  Created by Smirnov Ivan on 22.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//
//#import <CommonCrypto/CommonHMAC.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ISUser,BDBOAuth1Credential,BDBOAuth1SessionManager,ISNewsFeedModel;
@interface ISServerManager : UIViewController


@property(strong,nonatomic)NSString *oauthToken;
@property(strong,nonatomic)NSString *oauthTokenSecret;
@property(strong,nonatomic)ISUser* user;
@property(assign,nonatomic)NSInteger userID;


+(ISServerManager*) sharedManager;

-(BDBOAuth1SessionManager*)loginUserOnSuccess:(void(^)(BDBOAuth1Credential *requestToken)) success
                                    onFailure:(void(^)(NSError* error))failture;





-(void)getPopularPhotosOnSuccess:(void(^)(NSArray* photos)) success
                       onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;

-(void)getUserFriendsPhotoNewsOnSuccess:(void(^)(NSMutableArray* newsAr)) success
                              onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;

-(void)getPhotosWithTerm:(NSString*)term tag:(NSString*)tag
                    page:(NSInteger)page rpp:(NSInteger)rpp
                    tags:(NSArray*)tags
               onSuccess:(void(^)(NSArray* photos)) success
               onFailure:(void(^)(NSError* error,NSInteger statusCode))failure;

-(void)getFolowerOnSuccess:(void(^)(NSArray* folowers)) success
                 onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;

-(void)getUserOnSuccess:(void(^)(ISUser* user)) success
              onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;

-(void) getFollowersOnUserID:(NSInteger)userID
                    withPage:(NSInteger)page
                   onSuccess:(void(^)(NSArray* followers))success
                   onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;

-(void) getFriendsOnUserID:(NSInteger)userID
                  withPage:(NSInteger)page
                 onSuccess:(void(^)(NSArray* followers))success
                 onFailure:(void(^)(NSError* error,NSInteger statusCode))failture;

-(void) getUserOnID:(NSInteger)userID
          OnSuccess:(void (^)(ISUser *))success
          onFailure:(void (^)(NSError *, NSInteger))failture;


@end
