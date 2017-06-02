//
//  UserInfo.h
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/10/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

#define theAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@class FriendsInfo;

@class FriendsInfo;

@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * profile_pic;
@property (nonatomic, retain) NSNumber * user_age;
@property (nonatomic, retain) NSString * user_name;
@property (nonatomic, retain) NSString * user_password;
@property (nonatomic, retain) NSSet *friends;
@end

@interface UserInfo (CoreDataGeneratedAccessors)

- (void)addFriendsObject:(FriendsInfo *)value;
- (void)removeFriendsObject:(FriendsInfo *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

+(BOOL)checkUserData:(NSString *)userName andPass:(NSString *)password;

+(void)insertData:(NSDictionary *)infoDic;

+(NSArray *)retrieveAllData;

+(NSArray *)retrieveSpecificData :(NSString *)userName;

+(NSMutableArray *)replaceRecord:(NSMutableDictionary *)userName;

+(void)deleteData:(NSString *)username;

+(void)saveProfileInfo:(NSMutableDictionary *)userData;

+(void)addFriend:(NSDictionary *)friendDic withUser:(NSDictionary *)userDict;

+(NSArray *)getFriendsInfo:(NSString *)userName;

@end
