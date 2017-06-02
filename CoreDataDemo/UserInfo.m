//
//  UserInfo.m
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/10/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import "UserInfo.h"
#import "FriendsInfo.h"


@implementation UserInfo

@dynamic profile_pic;
@dynamic user_age;
@dynamic user_name;
@dynamic user_password;
@dynamic friends;

+(BOOL)checkUserData:(NSString *)userName andPass:(NSString *)password
{
    NSEntityDescription *entity= [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:theAppDelegate.managedObjectContext];
    
    NSFetchRequest *dataRequest=[[NSFetchRequest alloc] init];
    dataRequest.returnsObjectsAsFaults=NO;
    [dataRequest setEntity:entity];
    NSError *err;
    NSArray *fetchedArray=[theAppDelegate.managedObjectContext executeFetchRequest:dataRequest error:&err];
    if (fetchedArray.count>0) {
        
        for (int i=0; i<fetchedArray.count; i++) {
            
            if ([[[fetchedArray objectAtIndex:i] valueForKey:@"user_name"] isEqualToString:userName] && [[[fetchedArray objectAtIndex:i] valueForKey:@"user_password"] isEqualToString:password]) {
                
                return YES;
            }
            
        }
    }
    
    
    return false;
    
    
}

+(void)insertData:(NSDictionary *)infoDic
{
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:theAppDelegate.managedObjectContext];
    NSFetchRequest *dataRequest=[[NSFetchRequest alloc] init];
    dataRequest.returnsObjectsAsFaults=NO;
    [dataRequest setEntity:entity];
    NSError *err;
    NSArray *fetchedArray=[theAppDelegate.managedObjectContext executeFetchRequest:dataRequest error:&err];
    
    for (int i=0; i<fetchedArray.count; i++) {
        
        if ([[[fetchedArray objectAtIndex:i] valueForKey:@"user_name"] isEqualToString:[infoDic valueForKey:@"user_name"]]) {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"User Name Issue" message:@"Choose Another User Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
    }
    
    
    
    NSManagedObject *managedObject=[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:theAppDelegate.managedObjectContext];
    
    [managedObject setValue:[infoDic valueForKey:@"user_name"] forKey:@"user_name"];
    [managedObject setValue:[infoDic valueForKey:@"user_password"] forKey:@"user_password"];
    [managedObject setValue:[NSNumber numberWithInteger:[[infoDic valueForKey:@"user_age"] integerValue]] forKey:@"user_age"];
    [managedObject setValue:[infoDic valueForKey:@"profile_pic"] forKey:@"profile_pic"];
    
    
    
    
    [theAppDelegate saveContext];
    
}

+(NSArray *)retrieveAllData
{
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:theAppDelegate.managedObjectContext];
    
    NSFetchRequest *dataRequest=[[NSFetchRequest alloc] init];
    dataRequest.returnsObjectsAsFaults=NO;
    [dataRequest setEntity:entity];
    NSError *err;
    NSArray *fetchedArray=[theAppDelegate.managedObjectContext executeFetchRequest:dataRequest error:&err];
    
    return fetchedArray;
}

+(NSMutableArray *)replaceRecord:(NSMutableDictionary *)userData
{
    NSMutableArray *recordArray=[[NSMutableArray alloc] init];
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:theAppDelegate.managedObjectContext];
    NSFetchRequest *dataRequest=[[NSFetchRequest alloc] init];
    dataRequest.returnsObjectsAsFaults=NO;
    [dataRequest setEntity:entity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user_name=%@",[userData valueForKey:@"prev_user_name"]];
    [dataRequest setPredicate:predicate];
    NSError *err;
    NSArray *updateArray=[theAppDelegate.managedObjectContext executeFetchRequest:dataRequest error:&err];
    NSManagedObject *mgd=[updateArray objectAtIndex:0];
    [mgd setValue:[userData valueForKey:@"user_name"] forKey:@"user_name"];
    [mgd setValue:[userData valueForKey:@"user_password"] forKey:@"user_password"];
    [mgd setValue:[NSNumber numberWithInteger:[[userData valueForKey:@"user_age"] integerValue]] forKey:@"user_age"];
    [theAppDelegate saveContext];
    
    return recordArray;
}

+(void)saveProfileInfo:(NSMutableDictionary *)userData
{
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:theAppDelegate.managedObjectContext];
    NSFetchRequest *dataRequest=[[NSFetchRequest alloc] init];
    dataRequest.returnsObjectsAsFaults=NO;
    [dataRequest setEntity:entity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user_name=%@",[userData valueForKey:@"user_name"]];
    [dataRequest setPredicate:predicate];
    NSError *err;
    NSArray *updateArray=[theAppDelegate.managedObjectContext executeFetchRequest:dataRequest error:&err];
    NSManagedObject *mgd=[updateArray objectAtIndex:0];
    
    [mgd setValue:[userData valueForKey:@"profile_pic"] forKey:@"profile_pic"];
    
    NSSet *getFriendStatus=[mgd valueForKeyPath:@"friends"];
    
    [theAppDelegate saveContext];
}

+(NSArray *)retrieveSpecificData :(NSString *)userName
{
    
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:theAppDelegate.managedObjectContext];
    NSFetchRequest *dataRequest=[[NSFetchRequest alloc] init];
    dataRequest.returnsObjectsAsFaults=NO;
    [dataRequest setEntity:entity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user_name=%@",userName];
    [dataRequest setPredicate:predicate];
    NSError *err;
    NSArray *dataArray=[theAppDelegate.managedObjectContext executeFetchRequest:dataRequest error:&err];
    
    return dataArray;
}

+(void)deleteData:(NSString *)username
{
    
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:theAppDelegate.managedObjectContext];
    NSFetchRequest *dataRequest=[[NSFetchRequest alloc] init];
    dataRequest.returnsObjectsAsFaults=NO;
    [dataRequest setEntity:entity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user_name=%@",username];
    [dataRequest setPredicate:predicate];
    NSError *err;
    NSArray *updateArray=[theAppDelegate.managedObjectContext executeFetchRequest:dataRequest error:&err];
    NSManagedObject *mgd=[updateArray objectAtIndex:0];
    
    [theAppDelegate.managedObjectContext deleteObject:mgd];
    
    [theAppDelegate saveContext];
}

+(void)addFriend:(NSDictionary *)friendDic withUser:(NSDictionary *)userDict
{
    NSLog(@"%@",[friendDic valueForKey:@"user_name"]);
    
    //NSSet *personsFriends = [aPerson valueForKeyPath:@"friends.friend"];
    
    // Create a Child Person
    
    NSEntityDescription *entityFriend=[NSEntityDescription entityForName:@"FriendsInfo" inManagedObjectContext:theAppDelegate.managedObjectContext];
    NSEntityDescription *entityUser=[NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:theAppDelegate.managedObjectContext];
    
    NSManagedObject *newFreind = [[NSManagedObject alloc] initWithEntity:entityFriend insertIntoManagedObjectContext:theAppDelegate.managedObjectContext];
    
    
    
    // enter record to add relationship
    [newFreind setValue:[friendDic valueForKey:@"user_name"] forKey:@"user_name"];
    [newFreind setValue:[friendDic valueForKey:@"user_age"] forKey:@"user_age"];
    [newFreind setValue:[friendDic valueForKey:@"profile_pic"] forKey:@"profile_pic"];
    
    NSFetchRequest *dataRequest=[[NSFetchRequest alloc] init];
    dataRequest.returnsObjectsAsFaults=NO;
    [dataRequest setEntity:entityUser];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user_name=%@",[userDict valueForKey:@"user_name"]];
    [dataRequest setPredicate:predicate];
    NSError *err;
    NSArray *dataArray=[theAppDelegate.managedObjectContext executeFetchRequest:dataRequest error:&err];
    NSManagedObject *userObj=[dataArray objectAtIndex:0];
    
    
    
    
    
    
    
    
    
    // Create Relationship
    NSMutableSet *friend = [userObj mutableSetValueForKey:@"friends"];
    [friend addObject:newFreind];
    
    
    
    NSManagedObject *newFreindReverse = [[NSManagedObject alloc] initWithEntity:entityFriend insertIntoManagedObjectContext:theAppDelegate.managedObjectContext];
    
    
    
    // enter record to add relationship
    [newFreindReverse setValue:[userDict valueForKey:@"user_name"] forKey:@"user_name"];
    [newFreindReverse setValue:[userDict valueForKey:@"user_age"] forKey:@"user_age"];
    [newFreindReverse setValue:[userDict valueForKey:@"profile_pic"] forKey:@"profile_pic"];
    
    
    NSPredicate *predicateReverse=[NSPredicate predicateWithFormat:@"user_name=%@",[friendDic valueForKey:@"user_name"]];
    [dataRequest setPredicate:predicateReverse];
    NSArray *dataArrayReverse=[theAppDelegate.managedObjectContext executeFetchRequest:dataRequest error:&err];
    NSManagedObject *userObjReverse=[dataArrayReverse objectAtIndex:0];
    
    
    NSMutableSet *friendReverse = [userObjReverse mutableSetValueForKey:@"friends"];
    [friendReverse addObject:newFreindReverse];
    
    [theAppDelegate saveContext];
    
    
}

+(NSArray *)getFriendsInfo:(NSString *)userName
{
    
    
    NSEntityDescription *entityUser=[NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:theAppDelegate.managedObjectContext];
    NSFetchRequest *dataRequest=[[NSFetchRequest alloc] init];
    dataRequest.returnsObjectsAsFaults=NO;
    [dataRequest setEntity:entityUser];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user_name=%@",userName];
    [dataRequest setPredicate:predicate];
    NSError *err;
    NSArray *dataArray=[theAppDelegate.managedObjectContext executeFetchRequest:dataRequest error:&err];
    NSManagedObject *userObj=[dataArray objectAtIndex:0];
    
//    NSSet *personsFriends = [userObj valueForKeyPath:@"friends.alsofriend"];
//    NSArray *fndArray=[personsFriends allObjects];
    
    NSSet *personsFriends2 = [userObj valueForKeyPath:@"friends"];
    NSArray *fndArray2=[personsFriends2 allObjects];
    
    
    
    
    return fndArray2;
    
}

@end
