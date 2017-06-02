//
//  LoginViewController.h
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/8/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    
    __weak IBOutlet UITextField *userTxtF;
    __weak IBOutlet UITextField *passwordTxtF;
}

- (IBAction)loginClicked:(id)sender;
- (IBAction)touchClicked:(id)sender;


@end
