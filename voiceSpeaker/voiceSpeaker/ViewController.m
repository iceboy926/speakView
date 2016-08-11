//
//  ViewController.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/10.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "ViewController.h"
#import "SpeakerView.h"
#import "shadowView.h"
#import "ColorButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SpeakerView *vc = [[SpeakerView alloc] initWithFrame:CGRectMake(0, 10, 60, 100)];
    
   // vc.center = self.view.center;
    
    [self.view addSubview:vc];
    
    
    shadowView *view = [[shadowView alloc] initWithFrame:CGRectMake(100, 120, 100,100)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    
    NSMutableArray *colorArray = [@[[UIColor colorWithRed:0.6 green:0.278 blue:0.757 alpha:1],[UIColor colorWithRed:0.614 green:0.612 blue:0.843 alpha:1]] mutableCopy];
    ColorButton *btn = [[ColorButton alloc]initWithFrame:CGRectMake(100, 200, 150, 50) FromColorArray:colorArray ByGradientType:topToBottom];
    [btn setTitle:@"测试button" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.layer.shadowOffset = CGSizeMake(3, 3);
//    btn.layer.shadowColor = [UIColor grayColor].CGColor;
//    btn.layer.shadowOpacity = 0.8;
    
    [self.view addSubview:btn];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
