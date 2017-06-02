//
//  LoginViewController.m
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/8/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import "LoginViewController.h"
#import "menuVIewController.h"

@implementation LoginViewController
menuVIewController *menuVC;

-(void)viewDidLoad
{
    self.title=@"Log In";
    menuVC=[self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 21:
        {
            textField.returnKeyType=UIReturnKeyNext;
            
        }
            break;
        case 22:
        {
            textField.returnKeyType=UIReturnKeyDone;
        }
            break;
            
            
        default:
            break;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 21:
        {
            [textField resignFirstResponder];
            [passwordTxtF becomeFirstResponder];
        }
            break;
        case 22:
        {
            [textField resignFirstResponder];
        }
            break;
            
            
        default:
            break;
    }
    
    return YES;
}



- (IBAction)loginClicked:(id)sender {
    
    
    
    if ([UserInfo checkUserData:userTxtF.text andPass:passwordTxtF.text]) {
        
        UIViewController *homeVC=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"homeVC"];
        [self.navigationController pushViewController:homeVC animated:YES];
        
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        
        [user setValue:userTxtF.text forKey:@"user_name"];
        [user setValue:passwordTxtF.text forKey:@"user_password"];
        [user synchronize];
        
        
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"wrong input !!!" message:@"Enter correct user name or password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
}

- (IBAction)touchClicked:(id)sender {
    [self.view endEditing:YES];
}
@end
