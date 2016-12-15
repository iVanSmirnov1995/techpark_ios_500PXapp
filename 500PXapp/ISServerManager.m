//
//  ISServerManager.m
//  500PXapp
//
//  Created by Smirnov Ivan on 22.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//
#import	<CommonCrypto/CommonHMAC.h>
#import	<CommonCrypto/CommonDigest.h>


#import "ISServerManager.h"
#import "AFNetworking.h"
#import "ISNewsFeedModel.h"
#import "ISUser.h"
#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1RequestSerializer.h"
#import "NSString+URLEncode.h"
#import "MSPhotos.h"
#import "ISNewsFeedModel.h"
#import "OAuth1Controller.h"


@interface ISServerManager()

@property(strong,nonatomic)AFHTTPSessionManager *manager;

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


- (id)init
{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"https://api.500px.com/v1/"];
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        
        
    }
    return self;
}



-(void)getUserOnSuccess:(void(^)(ISUser* user)) success
                 onFailure:(void(^)(NSError* error,NSInteger statusCode))failture {


    
    
    NSString *path = @"/users/";
 NSDictionary *parameters = @{@"api_key" : @"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI"};
    
    
    // Build authorized request based on path, parameters, tokens, timestamp etc.
    NSURLRequest *preparedRequest = [OAuth1Controller preparedRequestForPath:path
                                                                  parameters:parameters
                                                                  HTTPmethod:@"GET"
                                                                  oauthToken:self.oauthToken
                                                                 oauthSecret:self.oauthTokenSecret];
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:preparedRequest
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                    
                                      
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        

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
                                      user.friendsCount = [userDic objectForKey:@"friends_count"];
                                      user.followersCount = [userDic objectForKey:@"followers_count"];
                self.user=user;
                
                    if (success) {
                      success(user);
                        }
                                      
                                      
                                  }];
    
    [task resume];
    
    
    
    
    
    
}



-(void)getUserFriendsPhotoNewsOnSuccess:(void(^)(NSMutableArray* newsAr)) success
              onFailure:(void(^)(NSError* error,NSInteger statusCode))failture {
    
    
    NSString* path=[NSString stringWithFormat:
  @"/photos?feature=fresh_today&user_id=%ld&sort=created_at&image_size=4&include_store=store_download&include_states=voted&consumer_key=XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI",self.user.userId];
    

    
    
    // Build authorized request based on path, parameters, tokens, timestamp etc.
    NSURLRequest *preparedRequest = [OAuth1Controller preparedRequestForPath:path
                                                                  parameters:nil
                                                                  HTTPmethod:@"GET"
                                                                  oauthToken:self.oauthToken
                                                                 oauthSecret:self.oauthTokenSecret];
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:preparedRequest
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      
                    id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      
                    NSArray* newsAr=[responseObject objectForKey: @"photos"];
                    NSMutableArray* modelNewsAr=[NSMutableArray array];
                                      
                    for (NSDictionary* newsDic in newsAr) {
                        
                    ISNewsFeedModel* news=[[ISNewsFeedModel alloc]init];
                    NSDictionary* userDic = [newsDic objectForKey: @"user"];
                                          
                    news.userName=[userDic objectForKey:@"fullname"];
                    news.userID=[[userDic objectForKey:@"id"]integerValue];
                    news.userImageName=[[[userDic objectForKey:@"avatars"]objectForKey:@"small"] objectForKey:@"https"];
                    news.photoID=[[newsDic objectForKey:@"id"]longValue];
                    news.imageName=[newsDic objectForKey:@"image_url"];
                    news.data=[newsDic objectForKey:@"created_at"];
                    news.countLike=[[newsDic objectForKey:@"converted"]integerValue];
                                          [modelNewsAr addObject:news];
                                      }
                                      
                                      if (success) {
                                          success(modelNewsAr);
                                      }
                                      
                                      
                                  }];
    
    [task resume];
    
    
}

/*Consumer Key: XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI
 Consumer Secret: wlXOElFUY7hjkHffppk36PyrXdNa44mmr7MseWVL
 */
// https://api.500px.com/v1/photos?feature=popular
// https://api.500px.com/v1/photos?feature=editors&page=2&consumer_key=YOUR_CONSUMER_KEY_HERE.
//popular

-(void)getFolowerOnSuccess:(void(^)(NSArray* news)) success
                       onFailure:(void(^)(NSError* error,NSInteger statusCode))failture {
    NSDictionary* param =
    [NSDictionary dictionaryWithObjectsAndKeys:
    @(self.user.userId),@"id",
     nil];

    NSURL *URL = [NSURL URLWithString:@"https://api.500px.com/v1/users/173/followers"];
    [self.manager GET:URL.absoluteString parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
         // NSLog(@"JSON: %@", responseObject);
        for (int i=0; i<20; i++) {
            
            
            NSArray* followers = [responseObject objectForKey: @"followers"];
          //  NSLog(@"%@",[followers objectAtIndex:i]);
        }
        

        
        
        // NSLog(@"photo : %@", photosArray);
//        if (success) {
//            success(followers);
//        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}


-(void)getPopularPhotosOnSuccess:(void(^)(NSArray* photos)) success
                       onFailure:(void(^)(NSError* error,NSInteger statusCode))failture {

    NSDictionary* param =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"popular",@"feature",
     @"12",@"rpp",
     @"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI",@"consumer_key",
     nil];
    

    NSURL *URL = [NSURL URLWithString:@"https://api.500px.com/v1/photos?feature=popular"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     dispatch_async(dispatch_get_main_queue(), ^{
    
    [manager GET:URL.absoluteString parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
      
       // NSLog(@"JSON: %@", responseObject);
        
        NSArray* photosArray = [responseObject objectForKey: @"photos"];
        NSMutableArray *array = [NSMutableArray array];
        // NSLog(@"photo : %@", photosArray);
        
        
        
        for (int i = 0;i<photosArray.count;i++ )
        {
         
            NSDictionary *dict = [[photosArray objectAtIndex:i] objectForKey:@"user"];
            MSPhotos* msp = [[MSPhotos alloc] initWithServerResponse:dict];
            [array addObject:msp.photoURL];
            
        }
        
        if (success) {
            success(array);
        }
       
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
});
    
    
}

-(void) getMyAccountOnSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.manager GET:@"users"
           parameters:nil progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
              }];
}












@end

