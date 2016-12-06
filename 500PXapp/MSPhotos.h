//
//  MSPhotos.h
//  500PXapp
//
//  Created by Максим Стегниенко on 05.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MSPhotos : NSObject

@property (strong, nonatomic) NSString* photoURL;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageURL;

- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end
