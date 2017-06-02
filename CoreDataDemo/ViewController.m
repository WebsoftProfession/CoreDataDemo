//
//  ViewController.m
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/4/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController
@synthesize menuHidden;
@synthesize maskView;
menuVIewController *menu;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    switch (textField.tag) {
        case 1:
        {
            [textField resignFirstResponder];
            [pasTxtF becomeFirstResponder];
        }
            break;
        case 2:
        {
            [textField resignFirstResponder];
            [ageTxtF becomeFirstResponder];
        }
            break;
        case 3:
        {
            [textField resignFirstResponder];
        }
            break;
            
        default:
            break;
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
        {
            textField.returnKeyType=UIReturnKeyNext;
        }
            break;
        case 2:
        {
            textField.returnKeyType=UIReturnKeyNext;
        }
            break;
        case 3:
        {
            
            textField.returnKeyType=UIReturnKeyDone;
        }
            break;
            
        default:
            break;
    }
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    BOOL isValid = YES;
    switch (textField.tag) {
        case 3:
        {
            
            NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:textField.text];
            isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
            
            if (!isValid) {
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"wrong input!" message:@"please enter a valid age" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                
                [self.view endEditing:YES];
            }
        }
            break;
            
        default:
            break;
    }
    
    return isValid;
}

- (IBAction)completeButtonClicked:(id)sender {
    
    
    if ([userTxtF.text isEqualToString:@""] || [pasTxtF.text isEqualToString:@""] || [ageTxtF.text isEqualToString:@""]) {
        
        
        
        UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Complete Requirement" message:@"Please Fill All Fields..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else
    {
        NSMutableDictionary *recordDic=[[NSMutableDictionary alloc] init];
        
        [recordDic setValue:userTxtF.text forKey:@"user_name"];
        [recordDic setValue:pasTxtF.text forKey:@"user_password"];
        [recordDic setValue:ageTxtF.text forKey:@"user_age"];
        [recordDic setValue:@"default.jpg" forKey:@"profile_pic"];
        
        [UserInfo insertData:recordDic];
        [theAppDelegate.user setValue:userTxtF.text forKey:@"user_name"];
        [theAppDelegate.user setValue:pasTxtF.text forKey:@"user_password"];
        [theAppDelegate.user synchronize];
        
        UIViewController *listVC=[self.storyboard instantiateViewControllerWithIdentifier:@"listVC"];
        [self.navigationController pushViewController:listVC animated:YES];
        
        userTxtF.text=@"";
        pasTxtF.text=@"";
        ageTxtF.text=@"";
        
        [userTxtF becomeFirstResponder];
    }
    
    
    
}

- (IBAction)touchClicked:(id)sender {
    
    [self.view endEditing:YES];
}

- (IBAction)listClicked:(id)sender {
    
    
}
@end
