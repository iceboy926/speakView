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
#import "ObjectArchive.h"
#import "WJSlideMenu.h"
#import "leftView.h"
#import "NSArray+swizzle.h"
#import <objc/runtime.h>
#import "LeftSlideViewController.h"
#import "leftViewController.h"


@interface ViewController ()
{
    WJSlideMenu *slideMenu;
    LeftSlideViewController *leftSlideMenu;
}

@end

@implementation ViewController

void uncaughtExceptionHandler(NSException *exception){
    [XZLog logCrash:exception];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupSlide
{
    // 创建slideMenu
    CGRect frame = self.view.bounds;
    WJSlideMenu *menu = [[WJSlideMenu alloc]initWithFrame:frame];
    menu.backgroundColor = [UIColor whiteColor];
    [menu addSwipeGesture];// 添加左右滑动手势
    [self.view addSubview:menu];
    slideMenu = menu;
    
    
    
    // ******************** 根据自身需求布局页面 *******************
    
    // 可选设置
    menu.leftMovex = 180; //不设置默认是200
    //menu.rightMovex = 220;//不设置默认是200
    
    // 根据需求自定义修改navLeftBtn
    [slideMenu.navLeftBtn setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    slideMenu.navLeftBtn.backgroundColor = [UIColor clearColor];
    slideMenu.navLeftBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 20, 13, 20);
    
    
//    // 根据需求自定义修改navRigthBtn
//    [slideMenu.navRigthBtn setImage:[UIImage imageNamed:@"addMore"] forState:UIControlStateNormal];
//    slideMenu.navRigthBtn.backgroundColor = [UIColor clearColor];
//    slideMenu.navRigthBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 20, 13, 20);
    
    
    
    // 根据需求自定义修改navBgView titleView 等等
    slideMenu.navBgView.backgroundColor = [UIColor colorWithRed:124 green:234 blue:222 alpha:0.7];
    slideMenu.titleView.backgroundColor = [UIColor clearColor];
    //slideMenu.navRigthBtn.backgroundColor = [UIColor clearColor];
    //slideMenu.mainView.backgroundColor = [UIColor lightGrayColor];
    
    //  比如添加一个titleView的文字
    UILabel *titleLb = [[UILabel alloc]initWithFrame:slideMenu.titleView.bounds];
    titleLb.text = @"SlideMenu";
    [slideMenu.titleView addSubview:titleLb];
    
    
    leftView *left = [[leftView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [slideMenu.leftMenuView addSubview:left];
    
    left.blockmenu = ^(UIViewController *vc){
    
        [self.navigationController pushViewController:vc animated:YES];
        
        [slideMenu closeLeftMenuView];
    
    };
    
    left.leftblock = ^(id sender){
    
        NSLog(@"sender is %@", sender);
    };

    
//    rightViewController *rightView = [[rightViewController alloc] init];
//    
//    [slideMenu.rightMenuView addSubview:rightView.view];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //self.view.backgroundColor = [UIColor clearColor];
    
     //[self setupSlide];
    
    
    //Set ExceptionHandler
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    // 初始化
//    [XZLog initLog];
//    
//    // 设置保存多少天的数据，多余就删除。
//    [XZLog setNumberOfDaysToDelete:5];
//    
//    // 测试用例
//    FDLog(@"header", @"iOS", @"抢先预定了喂");
//    
//    Product_Custom *pC = [[Product_Custom alloc] init];
//    [pC product_cunstom_test];
//    
//    
//    
//    SpeakerView *vc = [[SpeakerView alloc] initWithFrame:CGRectMake(0, 10, 60, 100)];
//    
//   // vc.center = self.view.center;
//    
//    [self.view addSubview:vc];
//    
//    
    shadowView *view = [[shadowView alloc] initWithFrame:CGRectMake(100, 120, 100,100)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    [view setTapGesture:^{
    
        NSLog(@"view tap gesture");
        
        [self performSegueWithIdentifier:@"goNext" sender:self];
    
    }];
//
//    SEL sel = @selector(onClickedBtn:);
//    NSLog(@" SEL : %p", sel);
//    
//    
    NSMutableArray *colorArray = [@[[UIColor colorWithRed:0.6 green:0.278 blue:0.757 alpha:1],[UIColor colorWithRed:0.614 green:0.612 blue:0.843 alpha:1]] mutableCopy];
    ColorButton *btn = [[ColorButton alloc]initWithFrame:CGRectMake(100, 200, 150, 50) FromColorArray:colorArray ByGradientType:topToBottom];
    [btn setTitle:@"测试button" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(onClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.layer.shadowOffset = CGSizeMake(3, 3);
//    btn.layer.shadowColor = [UIColor grayColor].CGColor;
//    btn.layer.shadowOpacity = 0.8;
    
    [self.view addSubview:btn];
    
    
    ObjectArchive *object = [[ObjectArchive alloc] initWithName:@"Joke" Age:@"123" Career:@"engineer"];
    
    NSData *objectData = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    NSLog(@"objectData is %@", objectData);
    
    ObjectArchive *anotherObject = [NSKeyedUnarchiver unarchiveObjectWithData:objectData];
    
    ObjectArchive *objectCopy = [anotherObject copy];
    
    NSLog(@"name is %@, age is %@, career is %@", objectCopy.ObjectName, objectCopy.ObjectAge, objectCopy.ObjectCareer);
    
   
    
}

- (void)testSwizzle
{
    @autoreleasepool {
        
        Method ori_Method =  class_getInstanceMethod([NSArray class], @selector(lastObject));
        Method my_Method = class_getInstanceMethod([NSArray class], @selector(myLastObject));
        method_exchangeImplementations(ori_Method, my_Method);
        
        NSArray *array = @[@"0",@"1",@"2",@"3"];
        NSString *string = [array lastObject];
        NSLog(@"TEST RESULT : %@",string);
        
    }
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
    
    leftViewController *leftView = [[leftViewController alloc] init];
    
    leftSlideMenu = [[LeftSlideViewController alloc] initWithLeftView:leftView andMainView:cocoaVC];
    
    [self presentViewController:leftSlideMenu animated:YES completion:nil];
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
