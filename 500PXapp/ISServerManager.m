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
@interface ISServerManager()

@property(strong,nonatomic)BDBOAuth1SessionManager *manager;
@property(strong,nonatomic)NSString *accessToken;
@property(strong,nonatomic)NSString *accessTokenSecret;

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

    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.accessToken = [userDefaults objectForKey:@"kaccessToken"];
    self.accessTokenSecret=[userDefaults objectForKey:@"kaccessTokenSecret"];
    
    NSDictionary*param1= [self.manager.requestSerializer OAuthParameters];

    NSDictionary* param2 =
    [NSDictionary dictionaryWithObjectsAndKeys:
     self.accessToken,@"oauth_token",
     nil];
    
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param addEntriesFromDictionary:param1];
    [param addEntriesFromDictionary:param2];
    
    NSString* s=[self baseStringWithMetod:@"GET" baseURL:@"https://api.500px.com/v1/users"
                        param:param];
    
    NSString* signingKey=[NSString stringWithFormat:@"%@&%@",@"wlXOElFUY7hjkHffppk36PyrXdNa44mmr7MseWVL",self.accessTokenSecret];
    
    NSString* oauthSignature=[self HMAC_SHA1_HEX:signingKey dataSt:s];
    
    //s
    NSDictionary* param3 =
    [NSDictionary dictionaryWithObjectsAndKeys:
     oauthSignature,@"oauth_signature",
     nil];
    
    [param addEntriesFromDictionary:param3];

    
    NSURL *URL = [NSURL URLWithString:@"https://api.500px.com/v1/users"];
    [self.manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
         NSLog(@"JSON: %@", responseObject);
        
        ISUser* user=nil;
        
        
      //   NSLog(@"photo : %@", photosArray);
                if (success) {
                    success(user);
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
     @"19667207",@"id",
     @"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI",@"consumer_key",
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
     @"1",@"rpp",
     @"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI",@"consumer_key",
     nil];
    
    NSURL *URL = [NSURL URLWithString:@"https://api.500px.com/v1/photos?feature=popular"];
    [self.manager GET:URL.absoluteString parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
      //  NSLog(@"JSON: %@", responseObject);
        
          NSArray* photosArray = [responseObject objectForKey: @"photos"];
        
        
       // NSLog(@"photo : %@", photosArray);
        if (success) {
            success(photosArray);
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
    
    
    
    
    
    
    
   /* NSDictionary* param =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"popular",@"feature",
     @"1",@"rpp",
     @"XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI",@"consumer_key",
     nil];
    
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.500px.com/"]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:@"https://api.500px.com/v1/photos?feature=popular"
                                                      parameters:param];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        
        //  NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        // NSLog(@"%@",data);
        
        NSArray* photosArray = [data objectForKey: @"photos"];
        if (success)
        {
            success(photosArray);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if(failture) {
            
            failture(error,operation.response.statusCode);
        }
    }];
    
    
    [operation start];
    
    */
    
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

