//
//  ListViewController.h
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/4/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate>
{
    
    __weak IBOutlet UITableView *listTable;
    __weak IBOutlet UIView *editView;
    
    __weak IBOutlet UITextField *userTxtF;
    __weak IBOutlet UITextField *passTxtF;
    __weak IBOutlet UITextField *ageTxtF;
    __weak IBOutlet UISearchBar *searchbar;
    UIBarButtonItem *editButton;
    UIBarButtonItem *navigationBack;
    NSDictionary *userDict;
    
    
    
    NSString *preVName;
    BOOL isSearching;
}

@property bool *menuHidden;

- (IBAction)cellEditClicked:(id)sender;
-(IBAction)updateClicked:(id)sender;
- (IBAction)addFriendClicked:(id)sender;

@end
