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
#import "UIAlertView+Block.h"
#import "UIView+tapGesture.h"
#import "XZLog.h"
#import "NSObject+Caculator.h"
#import "CaculateMaker.h"
#import "reactiveVC.h"
#import "CocoaViewController.h"
#import "Product_Custom.h"

@interface ViewController ()

@end

@implementation ViewController

void uncaughtExceptionHandler(NSException *exception){
    [XZLog logCrash:exception];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Set ExceptionHandler
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    // 初始化
    [XZLog initLog];
    
    // 设置保存多少天的数据，多余就删除。
    [XZLog setNumberOfDaysToDelete:5];
    
    // 测试用例
    FDLog(@"header", @"iOS", @"抢先预定了喂");
    
    Product_Custom *pC = [[Product_Custom alloc] init];
    [pC product_cunstom_test];
    
    
    
    SpeakerView *vc = [[SpeakerView alloc] initWithFrame:CGRectMake(0, 10, 60, 100)];
    
   // vc.center = self.view.center;
    
    [self.view addSubview:vc];
    
    
    shadowView *view = [[shadowView alloc] initWithFrame:CGRectMake(100, 120, 100,100)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    [view setTapGesture:^{
    
        NSLog(@"view tap gesture");
        
        [self performSegueWithIdentifier:@"goNext" sender:self];
    
    }];
    
    SEL sel = @selector(onClickedBtn:);
    NSLog(@" SEL : %p", sel);
    
    
    NSMutableArray *colorArray = [@[[UIColor colorWithRed:0.6 green:0.278 blue:0.757 alpha:1],[UIColor colorWithRed:0.614 green:0.612 blue:0.843 alpha:1]] mutableCopy];
    ColorButton *btn = [[ColorButton alloc]initWithFrame:CGRectMake(100, 200, 150, 50) FromColorArray:colorArray ByGradientType:topToBottom];
    [btn setTitle:@"测试button" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(onClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.layer.shadowOffset = CGSizeMake(3, 3);
//    btn.layer.shadowColor = [UIColor grayColor].CGColor;
//    btn.layer.shadowOpacity = 0.8;
    
    [self.view addSubview:btn];
}

- (void)onClickedBtn:(id)sender
{
//    UIAlertView *view = [[UIAlertView alloc] initWithTitle:nil message:@"this is a message" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    
//    [view showAlertViewWithCompleteBlock:^(NSInteger buttonIndex){
//    
//        NSLog(@" clicked %d button", buttonIndex);
//    
//    }];
    
    int result = [NSObject makeCaculators:^(CaculateMaker *maker) {
       
        maker.add(5).add(4).add(1).sub(5).multi(2).div(5);
        
    }];
    
    NSLog(@"result is %d", result);
    
    //[self performSegueWithIdentifier:@"goNext" sender:self];
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    CocoaViewController *cocoaVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"CocoaVC"];
    cocoaVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:cocoaVC animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"goNext"])
    {
        reactiveVC *active = segue.destinationViewController;
        
        active.name = @"storyboard name";
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
