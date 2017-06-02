//
//  TouchView.m
//  CoreDataDemo
//
//  Created by WebsoftProfession on 2/4/16.
//   2016 WebsoftProfession. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
