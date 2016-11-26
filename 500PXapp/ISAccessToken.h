//
//  ISAccessToken.h
//  500PXapp
//
//  Created by Smirnov Ivan on 24.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISAccessToken : NSObject

@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) NSDate* expirationDate;
@property (strong, nonatomic) NSString* userID;


@end
