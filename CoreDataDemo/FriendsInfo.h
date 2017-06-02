//
//  FriendsInfo.h
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/10/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserInfo;

@interface FriendsInfo : NSManagedObject

@property (nonatomic, retain) NSString * profile_pic;
@property (nonatomic, retain) NSNumber * user_age;
@property (nonatomic, retain) NSString * user_name;
@property (nonatomic, retain) NSSet *alsofriend;
@end

@interface FriendsInfo (CoreDataGeneratedAccessors)

- (void)addAlsofriendObject:(UserInfo *)value;
- (void)removeAlsofriendObject:(UserInfo *)value;
- (void)addAlsofriend:(NSSet *)values;
- (void)removeAlsofriend:(NSSet *)values;

@end
