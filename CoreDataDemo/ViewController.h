//
//  ViewController.h
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/4/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "menuVIewController.h"

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *userTxtF;
    __weak IBOutlet UITextField *pasTxtF;
    __weak IBOutlet UITextField *ageTxtF;
    
    
    
}

@property bool *menuHidden;
@property (nonatomic,strong) UIView *maskView;

- (IBAction)completeButtonClicked:(id)sender;
- (IBAction)touchClicked:(id)sender;
- (IBAction)listClicked:(id)sender;


@end

