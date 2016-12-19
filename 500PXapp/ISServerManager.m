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
#import "ISComments.h"


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
                 
            ISUser* user=[[ISUser alloc]createUserWithResponseObject:responseObject];
                                      
                                      
                self.user=user;
                
                    if (success) {
                      success(user);
                        }
                }];
    
    [task resume];
}

-(void)POSTLike:(BOOL)like PhotoWithId:(NSInteger)photoId OnSuccess:(void(^)(NSMutableArray* coments)) success onFailure:(void(^)(NSError* error,NSInteger statusCode))failture{
    
    NSString* val=[NSString stringWithFormat:@"%d",like];
    NSString* path=[NSString stringWithFormat:@"/photos/%ld/vote",(long)photoId];
    NSDictionary *parameters = @{@"vote":val,@"api_key" : @"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI"};
    
    
    // Build authorized request based on path, parameters, tokens, timestamp etc.
    NSURLRequest *preparedRequest = [OAuth1Controller preparedRequestForPath:path
                                                                  parameters:parameters
                                                                  HTTPmethod:@"POST"
                                                                  oauthToken:self.oauthToken
                                                                 oauthSecret:self.oauthTokenSecret];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:preparedRequest
                                            completionHandler:
                                ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      
                                      id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      
                                      NSArray* comAr=[responseObject objectForKey: @"comments"];
                                      
                                      NSMutableArray* inArray=[NSMutableArray array];
                                      
                                      for (NSDictionary* d in comAr) {
                                          
                                          ISComments* comment=[[ISComments alloc]init];
                                          comment.body=[d objectForKey:@"body"];
                                          comment.date=[d objectForKey:@"created_at"];
                                          
                                          ISUser* user=[[ISUser alloc]createUserWithResponseObject:d];
                                          comment.user=user;
                                          
                                          [inArray addObject:comment];
                                      }
                                      
                                      if (success) {
                                          
                                          success(inArray);
                                      }
                                  }];
    
    [task resume];
 
    
}




-(void)getPhotoComentsWithId:(NSInteger)photoId OnSuccess:(void(^)(NSMutableArray* coments)) success onFailure:(void(^)(NSError* error,NSInteger statusCode))failture{
    
    NSString* path=[NSString stringWithFormat:@"/photos/%ld/comments",(long)photoId];
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
            
            NSArray* comAr=[responseObject objectForKey: @"comments"];
                                      
            NSMutableArray* inArray=[NSMutableArray array];
                                      
            for (NSDictionary* d in comAr) {
                                      
            ISComments* comment=[[ISComments alloc]init];
            comment.body=[d objectForKey:@"body"];
            comment.date=[d objectForKey:@"created_at"];
                
           ISUser* user=[[ISUser alloc]createUserWithResponseObject:d];
                comment.user=user;
             
                [inArray addObject:comment];
            }
                                      
                if (success) {
                    
                    success(inArray);
                    }
                }];
    
         [task resume];
    
}




-(void)getUserFriendsPhotoNewsOnSuccess:(void(^)(NSMutableArray* newsAr)) success
              onFailure:(void(^)(NSError* error,NSInteger statusCode))failture {
    
    
    NSString* path=[NSString stringWithFormat:
  @"/photos?feature=user_friends&user_id=%ld&rpp=50&sort=created_at&image_size=4&include_store=store_download&include_states=voted&consumer_key=XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI",self.user.userId];
    
  //  NSLog(@"%ld",self.user.userId);

    
    
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
                    news.liked=[[newsDic objectForKey:@"voted"]boolValue];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
                    NSDate* date = [dateFormatter dateFromString:
                                 [newsDic objectForKey:@"created_at"]];
                        
                    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                    [dateFormatter1 setDateFormat:@"MMM d, yyyy HH:mm"];
                    news.data = [dateFormatter1 stringFromDate:date];
                        
                    news.countLike=[[newsDic objectForKey:@"votes_count"]integerValue];
                    news.countComent=[[newsDic objectForKey:@"comments_count"]integerValue];
                        
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

-(void)getFolowerOnSuccess:(void(^)(NSArray* folowers)) success
                       onFailure:(void(^)(NSError* error,NSInteger statusCode))failture {
    NSDictionary* param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @(self.user.userId),@"id",
                           nil];

    NSURL *URL = [NSURL URLWithString:@"https://api.500px.com/v1/users/173/followers"];
//    NSURL *URL = [NSURL URLWithString:[NSString
//                                       stringWithFormat:
//                                       @"https://api.500px.com/v1/users/%ld/followers",
//                                       self.user.userId]];
    [self.manager GET:URL.absoluteString parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
          NSLog(@"JSON: %@", responseObject);
//        for (int i=0; i<20; i++) {
        
            
            NSArray* followers = [responseObject objectForKey: @"followers"];
          //  NSLog(@"%@",[followers objectAtIndex:i]);
//        }
        

        
        
        // NSLog(@"photo : %@", photosArray);
        if (success) {
            success(followers);
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}


-(void)getPopularPhotosOnSuccess:(void(^)(NSArray* photos)) success
                       onFailure:(void(^)(NSError* error,NSInteger statusCode))failture {

    NSDictionary* param =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"popular",@"feature",
     @"20",@"rpp",
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
            //NSLog(@"%@",dict);
            MSPhotos* msp = [[MSPhotos alloc] initWithServerResponse:dict];
            
            if (msp.photoURL != (NSString*) [NSNull null]) {
                
                [array addObject:msp];
            }
        }

        
        if (success) {
            success(array);
        }
       
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
});
    
    
}

#pragma mark - my requests

-(void) getFollowersOnUserID:(NSInteger) userID
                    withPage:(NSInteger) page
                   onSuccess:(void(^)(NSArray* followers, NSInteger followersCount)) success
                   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* param = @{@"page":@(page)};
    
    NSURL *URL = [NSURL URLWithString:[NSString
                                       stringWithFormat:
                                       @"https://api.500px.com/v1/users/%ld/followers",
                                       userID]];
    
    [self.manager GET:URL.absoluteString
           parameters:param progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
                  NSLog(@"JSON: %@", responseObject);
                  NSArray* followers = [responseObject objectForKey:@"followers"];
                  NSInteger followersCount = [[responseObject objectForKey:@"followers_count"] integerValue];
                  if(success){
                      success(followers, followersCount);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
              }];
    
}

-(void) getFriendsOnUserID:(NSInteger) userID
                   withPage:(NSInteger) page
                  onSuccess:(void(^)(NSArray*, NSInteger)) success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* param = @{@"page":@(page),
                            @"consumer_key":@"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI"};
    
    NSURL *URL = [NSURL URLWithString:[NSString
                                       stringWithFormat:
                                       @"https://api.500px.com/v1/users/%ld/friends",
                                       userID]];
    
    [self.manager GET:URL.absoluteString
           parameters:param progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
                  NSLog(@"JSON: %@", responseObject);
                  NSArray* friends = [responseObject objectForKey:@"friends"];
                  NSInteger friendsCount = [[responseObject objectForKey:@"friends_count"] integerValue];
                  if(success){
                      success(friends, friendsCount);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSLog(@"ERROR %@", error);
              }];
}

-(void) getUserOnID:(NSInteger)userID
          onSuccess:(void (^)(ISUser *))success
          onFailure:(void (^)(NSError *, NSInteger))failure {
    
    NSDictionary* param = @{@"id":@(userID),
                            @"consumer_key":@"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI"};
    
    NSURL *URL = [NSURL URLWithString: @"https://api.500px.com/v1/users/show"];
    
    [self.manager GET:URL.absoluteString
           parameters:param progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  ISUser* user = [[ISUser alloc] init];
                  NSDictionary* userDic = [responseObject objectForKey:@"user"];
                  
                  user.firstName=[userDic objectForKey:@"firstname"];
                  user.lastName=[userDic objectForKey:@"lastname"];
//                  user.sex=[[userDic objectForKey:@"sex"]floatValue];
                  user.city=[userDic objectForKey:@"city"];
                  user.avatar=[[[userDic objectForKey:@"avatars"]objectForKey:@"small"] objectForKey:@"https"];
                  user.userId=[[userDic objectForKey:@"id"]longValue];
                  user.username=[userDic objectForKey:@"username"];
                  user.cover = [userDic objectForKey:@"cover_url"];
                  user.friendsCount = [[userDic objectForKey:@"friends_count"] integerValue];
                  user.followersCount = [[userDic objectForKey:@"followers_count"] integerValue];
                  user.fullName = [ userDic objectForKey:@"full_name"];
                  self.user=user;
                  
                  if (success) {
                      success(user);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
              }];

}

-(void) getPhotosOnUserID: (NSInteger) userID
                 withPage: (NSInteger) page
                onSuccess: (void (^)(NSArray *, NSInteger))success
                onFailure: (void (^)(NSError *, NSInteger))failure {
    
    NSDictionary* param = @{@"feature": @"user",
                            @"user_id": @(userID),
                            @"page": @(page),
                            @"image_size": @"3,600",
                            @"consumer_key": @"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI"};
    
    NSURL *URL = [NSURL URLWithString: @"https://api.500px.com/v1/photos"];
    
    [self.manager GET:URL.absoluteString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        
        NSArray* photos = [responseObject objectForKey:@"photos"];
        NSInteger photosCount = [[responseObject objectForKey:@"total_items"] integerValue];
        
        if(success) {
            success(photos, photosCount);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

-(void) getGalleriesOnUserID: (NSInteger) userID
                      onPage: (NSInteger) page
                   onSuccess: (void(^)(NSArray*, NSInteger)) success
                     onError: (void(^)(NSError*, NSInteger)) failure {
    
    NSURL* URL = [NSURL URLWithString:
                  [NSString stringWithFormat:
                   @"https://api.500px.com/v1/users/%@/galleries", @(userID)]];
    
    NSDictionary* param = @{@"privace": @"public",
                            @"page": @(page),
                            @"consumer_key": @"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI"};
    [self.manager GET:URL.absoluteString
           parameters:param progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
                  NSLog(@"%@", responseObject);
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              }];
                            
}










@end

