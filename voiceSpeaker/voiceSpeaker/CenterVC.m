//
//  CenterViewController.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/29.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "CenterVC.h"
#import "UIImage+xhImageName.h"

@interface CenterVC ()

@end

@implementation CenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageVC = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    imageVC.image = [UIImage imageNamed:@"anddy"];
    
    [self.view addSubview:imageVC];
    
    // Do any additional setup after loading the view.
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
