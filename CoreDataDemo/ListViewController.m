//
//  ListViewController.m
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/4/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import "ListViewController.h"

@implementation ListViewController
{
    NSMutableArray *dataArray;
    NSMutableArray *searchArray;
    BOOL editEnabled;

}
@synthesize menuHidden;
-(void)viewDidLoad
{
    self.menuHidden=true;
    editEnabled=NO;
    isSearching=NO;
    editButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit"] style:UIBarButtonItemStylePlain target:self action:@selector(editClicked)];
    editButton.imageInsets=UIEdgeInsetsMake(15, 15, 15, 15);
    [self.navigationItem setRightBarButtonItem:editButton];
    searchArray=[[NSMutableArray alloc] init];
   dataArray= [[UserInfo retrieveAllData] mutableCopy];
    editView.frame=CGRectMake(0, -568, self.view.frame.size.width, self.view.frame.size.height);
    [self.view bringSubviewToFront:editView];
    listTable.frame=CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100);
    
    searchbar.showsCancelButton=NO;
    editView.layer.opacity=0.8;
    editView.layer.allowsGroupOpacity = YES;
    
    UIBarButtonItem *menuBtn=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"menu1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    menuBtn.imageInsets=UIEdgeInsetsMake(0, -10, 0, 0);
    
    for (int i=0; i<dataArray.count; i++) {
        
        if ([[[dataArray objectAtIndex:i] valueForKey:@"user_name"] isEqualToString:[theAppDelegate.user valueForKey:@"user_name"]]) {
            
            userDict =[dataArray objectAtIndex:i];
            [dataArray removeObjectAtIndex:i];
            
            
        }
    }
    
    [self.navigationItem setLeftBarButtonItems:@[menuBtn]];
    
    theAppDelegate.checkVC=@"";
    
}

-(void)openMenu:(id)sender
{
    if (theAppDelegate.isHidden) {
        CGRect menuFrame=[UIScreen mainScreen].bounds;
        menuFrame.size.width=theAppDelegate.menuWindow.frame.size.width;
        CGRect controllerFrame=[UIScreen mainScreen].bounds;
        controllerFrame.origin.x=controllerFrame.origin.x+menuFrame.size.width;
        [self.view addSubview:theAppDelegate.maskView];
        [UIView animateWithDuration:0.2 animations:^{
            
            theAppDelegate.window.frame=controllerFrame;
            theAppDelegate.maskView.alpha=0.5;
            
        }];
        
        theAppDelegate.isHidden=false;
        
    }
    else
    {
        
        CGRect controllerFrame=[UIScreen mainScreen].bounds;
        
        
        [UIView animateWithDuration:0.2 animations:^{
            
            theAppDelegate.window.frame=controllerFrame;
            theAppDelegate.maskView.alpha=0.0;
        }];
        theAppDelegate.isHidden=YES;
        [theAppDelegate.maskView removeFromSuperview];
    }
}

-(void)editClicked
{
    if (editEnabled) {
        
        editEnabled=NO;
        [listTable reloadData];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            editView.frame=CGRectMake(0, -568, self.view.frame.size.width, self.view.frame.size.height);
            
        }];
        [editButton setImage:[UIImage imageNamed:@"edit.png"]];
        editButton.imageInsets=UIEdgeInsetsMake(15, 15, 15, 15);
        //[self.navigationItem setLeftBarButtonItem:nil];
    }
    else
    {
        editEnabled=YES;
        [listTable reloadData];
        
    }
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        NSString *username=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"user_name"];
        [UserInfo deleteData:username];
        
        [dataArray removeObjectAtIndex:indexPath.row];
        
        
        
        [listTable reloadData];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearching) {
        
        return searchArray.count;
    }
    else
    {
    return dataArray.count;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"listCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    UIButton *btnAdd=(UIButton *)[cell viewWithTag:30];
    btnAdd.layer.cornerRadius=10.0;
    //btnAdd.layer.borderColor=[UIColor blueColor].CGColor;
    //btnAdd.layer.borderWidth=10.0;
    
    if (isSearching) {
       
        cell.detailTextLabel.text=[NSString stringWithFormat:@"\rAge %@",[[searchArray objectAtIndex:indexPath.row] valueForKey:@"user_age"]];
        
        UILabel *lbl=(UILabel *)[cell viewWithTag:102];
        lbl.attributedText=[[searchArray objectAtIndex:indexPath.row] valueForKey:@"user_name"];
        UIButton *editCellButton=(UIButton *)[cell viewWithTag:101];
        
        
        if (editEnabled) {
            
            editCellButton.hidden=NO;
        }
        else
        {
            editCellButton.hidden=YES;
        }
    }
    else
    {
        
        cell.detailTextLabel.text=[NSString stringWithFormat:@"\rAge %@",[[dataArray objectAtIndex:indexPath.row] valueForKey:@"user_age"]];
        UILabel *lbl=(UILabel *)[cell viewWithTag:102];
        lbl.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"user_name"];
        UIButton *editCellButton=(UIButton *)[cell viewWithTag:101];
        if (editEnabled) {
            
            editCellButton.hidden=NO;
        }
        else
        {
            editCellButton.hidden=YES;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    
    [UserInfo getFriendsInfo:[theAppDelegate.user valueForKey:@"user_name"]];
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
            [passTxtF becomeFirstResponder];
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
            
        case 200:
        {
            [textField resignFirstResponder];
            
        }
            break;
            
        default:
            break;
    }
    
    return YES;
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}

-(void)searchData
{
    
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

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    searchBar.text=@"";
    isSearching=NO;
    [listTable reloadData];
    searchbar.showsCancelButton=NO;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //isSearching=YES;
    searchbar.showsCancelButton=YES;
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    isSearching=NO;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    isSearching=YES;
    if ([searchBar.text isEqualToString:@""]) {
        
        isSearching=NO;
        [listTable reloadData];
    }
    else
    {
        if (isSearching) {
            [searchArray removeAllObjects];
            for (int i=0; i<dataArray.count ; i++) {
                
                NSMutableString *myString=[[dataArray objectAtIndex:i] valueForKey:@"user_name"];
                NSRange range=[myString rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if (range.location != NSNotFound) {
                    
                    
                    
                    NSMutableString *upper=[[NSMutableString alloc] init];
                    
                    NSString *trimmedString = [myString substringWithRange:range];
                    [upper appendString:trimmedString];
                    
                    NSMutableAttributedString *muAtrStr = [[NSMutableAttributedString alloc]initWithString:[[dataArray objectAtIndex:i] valueForKey:@"user_name"]];
                    NSAttributedString *string;
                   
                    string=[[NSAttributedString alloc] initWithString:upper attributes:@{NSFontAttributeName :[UIFont fontWithName:@"arial" size:18.0], NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]}];
                    
                    [muAtrStr replaceCharactersInRange:range withAttributedString:string];

                    
                    
                    NSMutableDictionary *attributedDic=[[NSMutableDictionary alloc] init];
                    
                    [attributedDic setValue:muAtrStr forKey:@"user_name"];
                    [attributedDic setValue:[[dataArray objectAtIndex:i] valueForKey:@"user_password"] forKey:@"user_password"];
                    [attributedDic setValue:[[dataArray objectAtIndex:i] valueForKey:@"user_age"] forKey:@"user_age"];
                    [attributedDic setValue:muAtrStr forKey:@"user_name"];
                    
                    [searchArray addObject:attributedDic];
                    upper=nil;
                }
                
            }
            
            [listTable reloadData];
            
        }
    }
    
    
    
}

- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    return 0;
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

-(IBAction)updateClicked:(id)sender
{
    
    NSMutableDictionary *userDic=[[NSMutableDictionary alloc] init];
        
        [userDic setValue:preVName forKey:@"prev_user_name"];
        [userDic setValue:userTxtF.text forKey:@"user_name"];
        [userDic setValue:passTxtF.text forKey:@"user_password"];
        [userDic setValue:ageTxtF.text forKey:@"user_age"];
        
        
        [UserInfo replaceRecord:userDic];
        dataArray= [[UserInfo retrieveAllData] mutableCopy];
        [listTable reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        editView.frame=CGRectMake(0, -568, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
    [editButton setImage:[UIImage imageNamed:@"edit.png"]];
    editButton.imageInsets=UIEdgeInsetsMake(15, 15, 15, 15);
    //[self.navigationItem setLeftBarButtonItem:nil];
    
    
}

- (IBAction)addFriendClicked:(id)sender {
    
    UIButton *btn=(UIButton *)sender;
    
    UITableViewCell *cell=(UITableViewCell *)btn.superview;
    UILabel *lblRecord=(UILabel *)[cell viewWithTag:102];
    
    for (int i=0; i<dataArray.count; i++) {
        
        if ([lblRecord.text isEqualToString:[[dataArray objectAtIndex: i] valueForKey:@"user_name"]]) {
            
            [UserInfo addFriend:[dataArray objectAtIndex:i] withUser:userDict];
        }
    }
}


- (IBAction)cellEditClicked:(id)sender {
    
    
    [editButton setImage:[UIImage imageNamed:@"up.png"]];
    editButton.imageInsets=UIEdgeInsetsMake(15, 15, 15, 15);
    UIButton *btn=(UIButton *)sender;
    UITableViewCell *cell=(UITableViewCell *)btn.superview;
    UILabel *mylbl=(UILabel *)[cell viewWithTag:102];
    for (int i=0; i<dataArray.count; i++) {
        
        if ([mylbl.text isEqualToString:[[dataArray objectAtIndex:i] valueForKey:@"user_name"]]) {
            
            [UIView animateWithDuration:0.5 animations:^{
                
                editView.frame=self.view.frame;
            }];
            
            userTxtF.text=[[dataArray objectAtIndex:i] valueForKey:@"user_name"];
            passTxtF.text=[[dataArray objectAtIndex:i] valueForKey:@"user_password"];
            ageTxtF.text=[NSString stringWithFormat:@"%@",[[dataArray objectAtIndex:i] valueForKey:@"user_age"]];
            preVName=[[dataArray objectAtIndex:i] valueForKey:@"user_name"];
            
        }
    }
    
    
}
@end
