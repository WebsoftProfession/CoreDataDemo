//
//  menuVIewController.h
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/5/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ListViewController.h"
#import "UserInfo.h"

@class UserProfileDetails;

@interface menuVIewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
     IBOutlet UIImageView *profileImage;
    __weak IBOutlet UIVisualEffectView *menuView;
    IBOutlet UITableView *menuTable;
    NSArray *titleArray;
    NSArray *imgArray;
    __weak IBOutlet UIImageView *editDP;
    UIImagePickerController *imagePicker;
    UINavigationController *nav;
    NSArray *userDataArray;
    
    
}



@property (nonatomic,strong) UIImageView *profileImage;
@property (nonatomic,strong) UITableView *menuTable;


- (IBAction)logoutUser:(id)sender;
-(void)RefreshImage;

@end
