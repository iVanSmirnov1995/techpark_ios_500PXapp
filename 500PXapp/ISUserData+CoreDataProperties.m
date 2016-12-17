//
//  ISUserData+CoreDataProperties.m
//  
//
//  Created by Smirnov Ivan on 16.12.16.
//
//  This file was automatically generated and should not be edited.
//

#import "ISUserData+CoreDataProperties.h"

@implementation ISUserData (CoreDataProperties)

+ (NSFetchRequest<ISUserData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ISUserData"];
}

@dynamic userID;
@dynamic oauthTokenSecret;
@dynamic name;
@dynamic oauthToken;
@dynamic firstName;
@dynamic lastName;
@dynamic cover;
@dynamic avatar;
@dynamic followersCount;
@dynamic friendsCount;
@dynamic userName;

@end
