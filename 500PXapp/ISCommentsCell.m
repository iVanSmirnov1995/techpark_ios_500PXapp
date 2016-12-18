//
//  ISCommentsCell.m
//  500PXapp
//
//  Created by Smirnov Ivan on 18.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISCommentsCell.h"
#import "ISComments.h"
#import "ISUser.h"
#import "UIImageView+AFNetworking.h"

@implementation ISCommentsCell



- (void)prepareForReuse {
    self.userAvatar = nil;
    self.name=nil;
    self.comment=nil;
}



@end
