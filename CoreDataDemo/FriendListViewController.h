//
//  FriendListViewController.h
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/9/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface FriendListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *friendsTable;
    NSArray *friendsArray;
}

@end
