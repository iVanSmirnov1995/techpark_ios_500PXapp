//
//  ISUserData+CoreDataProperties.h
//  
//
//  Created by Smirnov Ivan on 16.12.16.
//
//  This file was automatically generated and should not be edited.
//

#import "ISUserData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ISUserData (CoreDataProperties)

+ (NSFetchRequest<ISUserData *> *)fetchRequest;

@property (nonatomic) int64_t userID;
@property (nullable, nonatomic, copy) NSString *oauthTokenSecret;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *oauthToken;
@property (nullable, nonatomic, copy) NSString* firstName;
@property (nullable, nonatomic, copy) NSString* lastName;
@property (nullable, nonatomic, copy) NSString* cover;
@property (nullable, nonatomic, copy) NSString* avatar;
@property (nullable, nonatomic, copy) NSString* userName;
@property (nonatomic) int64_t followersCount;
@property (nonatomic) int64_t friendsCount;

@end

NS_ASSUME_NONNULL_END
