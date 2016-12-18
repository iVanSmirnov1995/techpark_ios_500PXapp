//
//  MSPhotos.m
//  500PXapp
//
//  Created by Максим Стегниенко on 05.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "MSPhotos.h"

@implementation MSPhotos

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        
        self.photoURL = [responseObject objectForKey:@"cover_url"];
        
        NSString *str = self.photoURL;
        
        
        if (str != (NSString*) [NSNull null]  )
        {
         //   NSLog(@"str !!   %@",str);
            self.imageURL = [NSURL URLWithString:str];
            
        }
        
        
    }
    return self;
}


@end
