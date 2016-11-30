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


/*Consumer Key: XyuX14AQBpiWjfUcRyXA2jyB5ensjjJD6gBFcGHI
 Consumer Secret: wlXOElFUY7hjkHffppk36PyrXdNa44mmr7MseWVL
 */
// https://api.500px.com/v1/photos?feature=popular
// https://api.500px.com/v1/photos?feature=editors&page=2&consumer_key=YOUR_CONSUMER_KEY_HERE.
//popular


-(void)getPopularPhotos:(NSInteger*) count
              onSuccess:(void(^)(NSArray* photos)) success
              onFailure:(void(^)(NSError* error,NSInteger statusCode))failture {


    NSDictionary* param =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"popular",@"feature",
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
        
        NSArray* photosArray = [data objectForKey: @"photos"];
        
      //  NSLog(@"%@",photosArray);
        if (success) {
            success(photosArray);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if(failture) {
            
            failture(error,operation.response.statusCode);
        }
    }];
    
    [operation start];
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
    
    
    
 
    
    
    

    
}


@end
