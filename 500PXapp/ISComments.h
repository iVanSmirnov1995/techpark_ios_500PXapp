//
//  ISComments.h
//  500PXapp
//
//  Created by Smirnov Ivan on 18.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISUser.h"

@interface ISComments : NSObject

@property(strong,nonatomic)NSString* body;
@property(assign,nonatomic)NSString* date;
@property(assign,nonatomic)ISUser* user;

@end
