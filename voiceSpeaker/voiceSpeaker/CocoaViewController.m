//
//  CocoaViewController.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/16.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "CocoaViewController.h"
#import "UIColor+Extend.h"

@implementation CocoaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.frame = CGRectMake(25.0, 180, SCREEN_WDITH - 50, 47.0);
    [actionButton setBackgroundColor:[UIColor colorFromHexCode:@"2dbf34"]];
    [actionButton setTitle:@"back" forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    actionButton.layer.masksToBounds = YES;
    actionButton.layer.cornerRadius = 5;
    [actionButton addTarget:self action:@selector(actionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:actionButton];
}


- (void)actionBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
