//
//  HomeViewController.m
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/8/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import "HomeViewController.h"
#import "menuVIewController.h"

@implementation HomeViewController
menuVIewController *menu1VC;
-(void)viewDidLoad
{
    UIBarButtonItem *menuBtn=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"menu1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    menuBtn.imageInsets=UIEdgeInsetsMake(0, -10, 0, 0);
    
    menu1VC=[self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    [self.navigationItem setLeftBarButtonItems:@[menuBtn]];
    userLabel.text=[theAppDelegate.user valueForKey:@"user_name"];
    [menu1VC RefreshImage];
    theAppDelegate.checkVC=@"homeVC";
    
    
}


-(void)openMenu:(id)sender
{
    
    
    
    
    if (theAppDelegate.isHidden) {
        CGRect menuFrame=[UIScreen mainScreen].bounds;
        menuFrame.size.width=theAppDelegate.menuWindow.frame.size.width;
        //menuFrame.origin.y=20;
        
        CGRect controllerFrame=[UIScreen mainScreen].bounds;
        controllerFrame.origin.x=controllerFrame.origin.x+menuFrame.size.width;
        
        [self.view addSubview:theAppDelegate.maskView];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            theAppDelegate.maskView.alpha=0.5;
            //theAppDelegate.menuWindow.frame=menuFrame;
            theAppDelegate.window.frame=controllerFrame;
            
        }];
        
        theAppDelegate.isHidden=false;
        
    }
    else
    {
        
        CGRect controllerFrame=[UIScreen mainScreen].bounds;
        
        
        [UIView animateWithDuration:0.2 animations:^{
            theAppDelegate.maskView.alpha=0.0;
            theAppDelegate.window.frame=controllerFrame;
        }];
        theAppDelegate.isHidden=YES;
        [theAppDelegate.maskView removeFromSuperview];
    }
    
    
}


@end
