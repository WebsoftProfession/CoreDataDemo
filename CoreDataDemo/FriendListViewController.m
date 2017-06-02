//
//  FriendListViewController.m
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/9/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import "FriendListViewController.h"

@interface FriendListViewController ()

@end

@implementation FriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *menuBtn=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"menu1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    menuBtn.imageInsets=UIEdgeInsetsMake(0, -10, 0, 0);
    
    [self.navigationItem setLeftBarButtonItems:@[menuBtn]];
    
    theAppDelegate.checkVC=@"";
    
    friendsArray= [UserInfo getFriendsInfo:[theAppDelegate.user valueForKey:@"user_name"]];
    
    //NSLog(@"%@",[NSString stringWithFormat:@"%@.png",[[self docDir] stringByAppendingPathComponent:[[friendsArray objectAtIndex:0] valueForKey:@"profile_pic"]]]);
    
    // Do any additional setup after loading the view.
}

-(NSString *)docDir
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath=[paths objectAtIndex:0];
    
    return docPath;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return friendsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"friendCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    UILabel *lblUser=(UILabel *)[cell viewWithTag:2];
    
    lblUser.text=[[friendsArray objectAtIndex:indexPath.row] valueForKey:@"user_name"];
    
    UILabel *lblAge=(UILabel *)[cell viewWithTag:3];
    lblAge.text=[NSString stringWithFormat:@"Age %@",[[friendsArray objectAtIndex:indexPath.row] valueForKey:@"user_age"]];
    
    UIImageView *profileImage=(UIImageView *)[cell viewWithTag:1];
    profileImage.layer.cornerRadius=profileImage.frame.size.width/2;
    [profileImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[self docDir] stringByAppendingPathComponent:[[friendsArray objectAtIndex:indexPath.row] valueForKey:@"profile_pic"]]]]];
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
