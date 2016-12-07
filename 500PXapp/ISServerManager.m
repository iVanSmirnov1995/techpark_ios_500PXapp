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

@interface ISServerManager()

@property(strong,nonatomic)BDBOAuth1SessionManager *manager;
@property(strong,nonatomic)NSString *accessToken;
@property(strong,nonatomic)NSString *accessTokenSecret;
@property(strong,nonatomic)ISUser* user;

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
        self.manager = [[BDBOAuth1SessionManager alloc] initWithBaseURL:url
            consumerKey:@"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI"
            consumerSecret:@"wlXOElFUY7hjkHffppk36PyrXdNa44mmr7MseWVL"];
        
        
    }
    return self;
}


-(BDBOAuth1SessionManager*)loginUserOnSuccess:(void(^)(BDBOAuth1Credential *requestToken)) success
onFailure:(void(^)(NSError* error))failture{
    
    
    NSURL *callbackURL=[NSURL URLWithString:@"pxapp://success"];//pxapp://success
    
    
    [self.manager fetchRequestTokenWithPath:@"oauth/request_token"
                             method:@"POST" callbackURL:callbackURL
                              scope:nil
                            success:^(BDBOAuth1Credential *requestToken) {
                                
                                [self getUserOnSuccess:^(ISUser *user) {
                                    
                                    
                                    
                                    
                                } onFailure:^(NSError *error, NSInteger statusCode) {
                                    NSLog(@"%@",error);
                                }];
                                
                                
                                
                                if (success) {
                                    success(requestToken);
                                }
                                
                                
                            } failure:^(NSError *error) {
                                
                                if (failture) {
                                    failture(error);
                                }
                                
                            }];
    return self.manager;
}





-(void)getUserOnSuccess:(void(^)(ISUser* user)) success
                 onFailure:(void(^)(NSError* error,NSInteger statusCode))failture {


    
    NSURL *URL = [NSURL URLWithString:@"https://api.500px.com/v1/users"];
    [self.manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
       //  NSLog(@"JSON: %@", responseObject);
        ISUser* user=[[ISUser alloc]init];
         NSDictionary* userDic = [responseObject objectForKey: @"user"];
        user.firstName=[userDic objectForKey:@"firstname"];
        user.lastName=[userDic objectForKey:@"lastname"];
        user.sex=[[userDic objectForKey:@"sex"]floatValue];
        user.city=[userDic objectForKey:@"city"];
        user.avatar=[[[userDic objectForKey:@"avatars"]objectForKey:@"small"] objectForKey:@"https"];
        user.userId=[[userDic objectForKey:@"id"]longValue];
        user.username=[userDic objectForKey:@"username"];
        self.user=user;
        
                if (success) {
                    success(user);
                }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    
    
}



-(void)getUserFriendsPhotoNewsOnSuccess:(void(^)(NSMutableArray* newsAr)) success
              onFailure:(void(^)(NSError* error,NSInteger statusCode))failture {
    
    
    NSString* re=[NSString stringWithFormat:
  @"https://api.500px.com/v1/photos?feature=fresh_today&user_id=%ld&sort=created_at&image_size=4&include_store=store_download&include_states=voted",self.user.userId];
    
    
    
    NSURL *URL = [NSURL URLWithString:re];
    
    
    
    
    [self.manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
      //  NSLog(@"%@",URL);
          NSLog(@"JSON: %@", responseObject);
        
        NSArray* newsAr=[responseObject objectForKey: @"photos"];
        NSMutableArray* modelNewsAr=[NSMutableArray array];
        
        for (NSDictionary* newsDic in newsAr) {
            
            ISNewsFeedModel* news=[[ISNewsFeedModel alloc]init];
            NSDictionary* userDic = [newsDic objectForKey: @"user"];
         //   NSLog(@"%@",userDic);
            
            news.userName=[userDic objectForKey:@"fullname"];
            news.userID=[[userDic objectForKey:@"id"]integerValue];
            news.userImageName=[[[userDic objectForKey:@"avatars"]objectForKey:@"small"] objectForKey:@"https"];
            news.photoID=[[newsDic objectForKey:@"id"]longValue];
            news.imageName=[newsDic objectForKey:@"image_url"];
            
        //    NSLog(@"%@",[newsDic objectForKey:@"cover_url"]);
            
            news.data=[newsDic objectForKey:@"created_at"];
            news.countLike=[newsDic objectForKey:@"converted"];
            
            
            
            [modelNewsAr addObject:news];
            
        }
        
        
        if (success) {
            success(modelNewsAr);
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];

    
    
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
    // NSLog(self.accessToken);
    
    NSDictionary* param =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"popular",@"feature",
     @"12",@"rpp",
     @"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI",@"consumer_key",
     nil];
    
    /* NSDictionary* param1 =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"popular",@"feature",
     @"10",@"rpp",
     @"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI",@"oauth_token",
     nil];
    */

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




-(void)autorizeUser:(NSString*)term tag:(NSString*)tag
               page:(NSInteger)page rpp:(NSInteger)rpp
               tags:(NSArray*)tags
          onSuccess:(void(^)(NSArray* photos)) success
          onFailure:(void(^)(NSError* error,NSInteger statusCode))failure{

    
    
}


-(void)GetUser:(NSString*)term tag:(NSString*)tag
               page:(NSInteger)page rpp:(NSInteger)rpp
               tags:(NSArray*)tags
          onSuccess:(void(^)(NSArray* photos)) success
          onFailure:(void(^)(NSError* error,NSInteger statusCode))failure{
    
    
    
  //  https://api.500px.com/v1/users
    
    
    
}


- (NSString*) HMAC_SHA1_HEX:(NSString *)hmacKey dataSt:(NSString*)st{
    
    
    NSData * secretData = [hmacKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData * baseData = [st dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[20] = {0};
    CCHmac(kCCHmacAlgSHA1, secretData.bytes, secretData.length,
           baseData.bytes, baseData.length, digest);
    
    NSData * signatureData = [NSData dataWithBytes:digest length:20];
    return [signatureData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
}


- (NSString*) baseStringWithMetod:(NSString *)metod
                          baseURL:(NSString*)URL param:(NSDictionary*)par{

    NSString * url = [URL URLEncode];
    
    NSString * parameters;
    
    NSString * oauth_consumer_key =[[par objectForKey:@"oauth_consumer_key"]URLEncode];
    
    NSString * oauth_nonce = [[par objectForKey:@"oauth_nonce"]URLEncode];
    NSString * oauth_signature_method = [@"HMAC-SHA1"URLEncode];
    NSString * oauth_timestamp = [[par objectForKey:@"oauth_timestamp"]URLEncode];
    
    NSString * oauth_version = [@"1.0" URLEncode];
    
    NSString * oauth_token = [[par objectForKey:@"oauth_token"]URLEncode];

    
    NSArray * params = [NSArray arrayWithObjects:
                        [NSString stringWithFormat:@"%@%%3D%@", @"oauth_consumer_key", oauth_consumer_key],
                        [NSString stringWithFormat:@"%@%%3D%@", @"oauth_nonce", oauth_nonce],
                        [NSString stringWithFormat:@"%@%%3D%@", @"oauth_signature_method", oauth_signature_method],
                         [NSString stringWithFormat:@"%@%%3D%@", @"oauth_timestamp", oauth_timestamp],
                         [NSString stringWithFormat:@"%@%%3D%@", @"oauth_token", oauth_token],
                        [NSString stringWithFormat:@"%@%%3D%@", @"oauth_version", oauth_version],
                        nil];
    
    
//    NSArray *keys = [par allKeys];
//    for (id key in keys)
//    {
//        params = [params arrayByAddingObject:[[NSString stringWithFormat:@"%@=%@",
//                 [key URLEncode], [[par valueForKey:key] URLEncode]] URLEncode]];
//        
//    }
    
    //sort paramaters lexicographically
    params = [params sortedArrayUsingSelector:@selector(compare:)];
    
    parameters = [params componentsJoinedByString:@"%26"];
    
    NSArray * baseComponents = [NSArray arrayWithObjects:
                                metod,
                                url,    //The URL you're requesting, *not* including any GET       parameters
                                parameters,
                                nil];
    
    NSString * baseString = [baseComponents componentsJoinedByString:@"&"];
    
    return baseString;
}




@end

