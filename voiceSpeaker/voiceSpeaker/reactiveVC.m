//
//  reactiveVC.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/16.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "reactiveVC.h"
#import "UIColor+Extend.h"
#import <ReactiveCocoa/ReactiveCocoa.h>



@interface reactiveVC ()

@end

@implementation reactiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"name is %@", _name);
    
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.frame = CGRectMake(25.0, 180, SCREEN_WDITH - 50, 47.0);
    [actionButton setBackgroundColor:[UIColor colorFromHexCode:@"1cbf61"]];
    [actionButton setTitle:@"Login" forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    actionButton.layer.masksToBounds = YES;
    actionButton.layer.cornerRadius = 5;
    [actionButton addTarget:self action:@selector(actionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:actionButton];

    
    // Do view setup here.
}

- (void)actionBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
