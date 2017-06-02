//
//  menuVIewController.m
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/5/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import "menuVIewController.h"
#import "HomeViewController.h"


@implementation menuVIewController
@synthesize menuTable;
@synthesize profileImage;
HomeViewController *homeVC;
-(void)viewDidLoad
{
    
    [self RefreshImage];
   
    nav=(UINavigationController *)theAppDelegate.window.rootViewController;
    menuView.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    
    profileImage.layer.cornerRadius=profileImage.frame.size.width/2;
    profileImage.layer.borderWidth=10.0f;
    profileImage.layer.borderColor=[UIColor whiteColor].CGColor;
    menuTable.frame=CGRectMake(self.view.frame.origin.x, profileImage.frame.origin.y+profileImage.frame.size.height+20, self.view.frame.size.width, self.view.frame.size.height);
    titleArray=@[@"Home",@"Add Friends",@"Friend Lists",@"Privacy",@"Settings"];
    imgArray=@[@"add",@"users",@"users",@"priv",@"setting"];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeProfile:)];
    [editDP addGestureRecognizer:tap];
     homeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"homeVC"];
    theAppDelegate.isHidden=YES;
    theAppDelegate.checkVC=@"homeVC";
    
    //NSIndexPath *indexpath=[NSIndexPath indexPathForRow:0 inSection:0];
    
    //[menuTable selectRowAtIndexPath:indexpath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
}

-(void)RefreshImage
{
    userDataArray = [UserInfo retrieveSpecificData:[theAppDelegate.user valueForKey:@"user_name"]];
    if (userDataArray.count>0) {
        
        //profileImage.image=[UIImage imageWithContentsOfFile:[[self docDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[[userDataArray objectAtIndex:0] valueForKey:@"profile_pic"]]]];
        NSLog(@"%@",[[userDataArray objectAtIndex:0] valueForKey:@"profile_pic"]);
        [profileImage setImage:[UIImage imageNamed:[[self docDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[[userDataArray objectAtIndex:0] valueForKey:@"profile_pic"]]]]];
    }
    else
    {
        NSFileManager *manager=[NSFileManager defaultManager];
        if (![manager fileExistsAtPath:[[self docDir] stringByAppendingPathComponent:@"default.jpg"]]) {
            NSError *err;
            [manager copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"default" ofType:@"jpg"] toPath:[[self docDir] stringByAppendingPathComponent:@"default.jpg"] error:&err];
        }
        [profileImage setImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"default" ofType:@"jpg"]]];
    }
}

-(void)changeProfile:(UITapGestureRecognizer *)tapG
{
    imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    nav=(UINavigationController *)theAppDelegate.window.rootViewController;
    CGRect controllerFrame=[UIScreen mainScreen].bounds;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        theAppDelegate.window.frame=controllerFrame;
    }];
    
    [[nav.viewControllers objectAtIndex:0] presentViewController:imagePicker animated:YES completion:nil];
    
}

-(NSString *)docDir
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath=[paths objectAtIndex:0];
    
    return docPath;
}

-(void)saveImage :(NSString *)imageName
{
    
    NSString *fileNameWithPath=[[self docDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
    
    NSData *imageData=[NSData dataWithData:UIImagePNGRepresentation(profileImage.image)];
    
    [imageData writeToFile:fileNameWithPath atomically:YES];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *img=[info valueForKey:UIImagePickerControllerOriginalImage];
    profileImage.image=img;
    
    NSDate *currentDate=[NSDate date];
    
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"ddmmsshh"];
    
    NSString *fileName=[NSString stringWithFormat:@"%@%@",[theAppDelegate.user valueForKey:@"user_name"],[formatter stringFromDate:currentDate]];
    
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    [dataDic setValue:[theAppDelegate.user valueForKey:@"user_name"] forKey:@"user_name"];
    [dataDic setValue:fileName forKey:@"profile_pic"];
    
    [UserInfo saveProfileInfo:dataDic];
    [self saveImage:fileName];
    
    
    CGRect menuFrame=[UIScreen mainScreen].bounds;
    menuFrame.size.width=theAppDelegate.menuWindow.frame.size.width;
    //menuFrame.origin.y=20;
    CGRect controllerFrame=[UIScreen mainScreen].bounds;
    controllerFrame.origin.x=controllerFrame.origin.x+menuFrame.size.width;
    [UIView animateWithDuration:0.2 animations:^{
        
        theAppDelegate.window.frame=controllerFrame;
        
    }];
    [picker dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    CGRect menuFrame=[UIScreen mainScreen].bounds;
    menuFrame.size.width=theAppDelegate.menuWindow.frame.size.width;
    CGRect controllerFrame=[UIScreen mainScreen].bounds;
    controllerFrame.origin.x=controllerFrame.origin.x+menuFrame.size.width;
    
    [UIView animateWithDuration:0.2 animations:^{

        theAppDelegate.window.frame=controllerFrame;
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"menuCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        
    }
    
    [cell.imageView setImage:[UIImage imageNamed:[imgArray objectAtIndex:indexPath.row]]];
    
    cell.textLabel.text=[titleArray objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    nav=(UINavigationController *)theAppDelegate.window.rootViewController;
    NSArray *navArray=nav.viewControllers;
    NSLog(@"%@",[navArray description]);
    
    
    switch (indexPath.row) {
        case 0:
        {
            
            if (![theAppDelegate.checkVC isEqualToString:@"homeVC"]) {
                
                [nav pushViewController:homeVC animated:NO];
                [nav setViewControllers:@[homeVC]];
                theAppDelegate.checkVC=@"homeVC";
            }
            
            
            CGRect controllerFrame=[UIScreen mainScreen].bounds;
            
            
            [UIView animateWithDuration:0.2 animations:^{
                
                theAppDelegate.window.frame=controllerFrame;
            }];
            
            theAppDelegate.isHidden=YES;
            [theAppDelegate.maskView removeFromSuperview];

            
            
        }
            break;
        case 1:
        {
            
            if (![theAppDelegate.checkVC isEqualToString:@"listVC"]) {
                
                ListViewController *listVC=[self.storyboard instantiateViewControllerWithIdentifier:@"listVC"];
                [nav pushViewController:listVC animated:NO];
                [nav setViewControllers:@[listVC]];
                theAppDelegate.checkVC=@"listVC";
            }
           
            
           
            CGRect controllerFrame=[UIScreen mainScreen].bounds;
            
            
            [UIView animateWithDuration:0.2 animations:^{
                
                theAppDelegate.window.frame=controllerFrame;
            }];
            theAppDelegate.isHidden=YES;
            [theAppDelegate.maskView removeFromSuperview];
            
            
        }
            break;
        case 2:
        {
            
            if (![theAppDelegate.checkVC isEqualToString:@"friendVC"]) {
                
                UIViewController *privacyVC=[self.storyboard instantiateViewControllerWithIdentifier:@"friendVC"];
                [nav pushViewController:privacyVC animated:NO];
                [nav setViewControllers:@[privacyVC]];
                theAppDelegate.checkVC=@"friendVC";
            }
            
            
            CGRect controllerFrame=[UIScreen mainScreen].bounds;
            
            
            [UIView animateWithDuration:0.2 animations:^{
                
                theAppDelegate.window.frame=controllerFrame;
            }];
            theAppDelegate.isHidden=YES;
            [theAppDelegate.maskView removeFromSuperview];
            
            
        }
            break;
            
        case 3:
        {
            
            if (![theAppDelegate.checkVC isEqualToString:@"privacyVC"]) {
                
                UIViewController *privacyVC=[self.storyboard instantiateViewControllerWithIdentifier:@"privacyVC"];
                [nav pushViewController:privacyVC animated:NO];
                [nav setViewControllers:@[privacyVC]];
                theAppDelegate.checkVC=@"privacyVC";
            }
            
            
            CGRect controllerFrame=[UIScreen mainScreen].bounds;
            
            
            [UIView animateWithDuration:0.2 animations:^{
                
                theAppDelegate.window.frame=controllerFrame;
            }];
            theAppDelegate.isHidden=YES;
            [theAppDelegate.maskView removeFromSuperview];
            
            
        }
            break;
        case 4:
        {
            if (![theAppDelegate.checkVC isEqualToString:@"settingsVC"]) {
                
                UIViewController *settingsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"settingsVC"];
                [nav pushViewController:settingsVC animated:NO];
                [nav setViewControllers:@[settingsVC]];
                theAppDelegate.checkVC=@"settingsVC";
            }
            
            
            CGRect controllerFrame=[UIScreen mainScreen].bounds;
            
            
            [UIView animateWithDuration:0.2 animations:^{
                
                theAppDelegate.window.frame=controllerFrame;
            }];
            theAppDelegate.isHidden=YES;
            [theAppDelegate.maskView removeFromSuperview];
            
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
    
    
}


- (IBAction)logoutUser:(id)sender {
    
    [theAppDelegate.user removeObjectForKey:@"user_name"];
    [theAppDelegate.user removeObjectForKey:@"user_password"];
    
    
    UIViewController *loginVC=[self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    
    CGRect controllerFrame=[UIScreen mainScreen].bounds;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        theAppDelegate.window.frame=controllerFrame;
    }];
    theAppDelegate.isHidden=YES;
    [theAppDelegate.maskView removeFromSuperview];
    
    [nav setViewControllers:@[loginVC]];
    
    [nav popToViewController:loginVC animated:YES];
    
    
}
@end
