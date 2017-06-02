//
//  AppDelegate.h
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/4/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UserInfo.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIWindow *menuWindow;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property BOOL isHidden;
@property (strong, nonatomic) NSString *checkVC;
@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) NSUserDefaults *user;
@property (strong, nonatomic) NSMutableDictionary *profileInfo;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

