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
#import "CocoaViewController.h"



@interface reactiveVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *ListtableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong) UITextField *usernameTextField;
@property(nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation reactiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"name is %@", _name);
    
    
    
    self.ListtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WDITH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.ListtableView.dataSource = self;
    self.ListtableView.delegate = self;
    [self.ListtableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.ListtableView setSeparatorColor:[UIColor colorWithRed:207/255.0 green:205/255.0 blue:205/255.0 alpha:0.75]];
    [self.view addSubview:self.ListtableView];
    [self SetUpTableViewData];
    
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.frame = CGRectMake(25.0, 160, SCREEN_WDITH - 50, 47.0);
    [actionButton setBackgroundColor:[UIColor colorFromHexCode:@"1cbf61"]];
    [actionButton setTitle:@"Login" forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    actionButton.layer.masksToBounds = YES;
    actionButton.layer.cornerRadius = 5;
    //[actionButton addTarget:self action:@selector(actionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginBtn = actionButton;
    
    [self.view addSubview:actionButton];
    
    
    //target-action
    self.loginBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSLog(@" logint btn");
        
        //[self dismissViewControllerAnimated:YES completion:nil];
        
        UIStoryboard *mainStore = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        CocoaViewController *cocoaVC = [mainStore instantiateViewControllerWithIdentifier:@"CocoaVC"];
        
        [self presentViewController:cocoaVC animated:YES completion:^{
        
        
        }];
    
        
        return [RACSignal empty];
    }];
    
    
    
    // 创建验证用户名的信道
    RACSignal *validUsernameSignal = [self.usernameTextField.rac_textSignal
                                      map:^id(NSString *text) {
                                          return @([self isValidUsername:text]);
                                      }];
    
    // 创建验证密码的信号
    RACSignal *validPasswordSignal = [self.passwordTextField.rac_textSignal
                                      map:^id(NSString *text) {
                                          return @([self isValidPassword:text]);
                                      }];
    
     // 通过信道返回的值，设置文本框的文字色
    RAC(self.usernameTextField, textColor) = [validUsernameSignal map:^id(id value) {
        
        UIColor *color = nil;
        if([value boolValue])
        {
            color = [UIColor colorFromHexCode:@"666666"];
        }
        else
        {
            color = [UIColor redColor];
        }
        
        return color;
    }];
    
    
     // 通过信道返回的值，设置文本框的文字色
    RAC(self.passwordTextField, textColor) = [validPasswordSignal map:^id(id value) {
        
        return [value boolValue] ? [UIColor colorFromHexCode:@"666666"] : [UIColor redColor];
    }];
    
    
    // 合并信道,生成新的信号--登陆Btn的信道
    RACSignal *loginActiveSignal = [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal] reduce:^id(id usernameValid, id passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    
    [loginActiveSignal subscribeNext:^(id x) {
        if([x boolValue])
        {
            self.loginBtn.enabled = YES;
            self.loginBtn.backgroundColor = [UIColor colorFromHexCode:@"1cbf61"];
            NSLog(@"subscribeNext enable");
        }
        else
        {
            self.loginBtn.enabled = NO;
            self.loginBtn.backgroundColor = [UIColor grayColor];
            NSLog(@"ssubscribeNext disable");
        }
    }];

}

- (BOOL)isValidUsername:(NSString *)userName
{
    BOOL blret = NO;
    
    blret = (userName.length > 6) ? YES : NO;
    
    return blret;
}


- (BOOL)isValidPassword:(NSString *)password
{
    return (password.length > 6) ? YES : NO;
}

- (void)SetUpTableViewData
{
    self.dataArray = [[NSMutableArray alloc] init];
    
    
    
    NSMutableDictionary *userNameDic = [[NSMutableDictionary alloc] init];
    
    userNameDic[@"title"] = @"用户名: ";
    userNameDic[@"object"] = self.usernameTextField = [self cellTextField];
    self.usernameTextField.placeholder = @"请输入用户名称";
    
    [self.dataArray addObject:userNameDic];
    
    
    NSMutableDictionary *passWordDic = [[NSMutableDictionary alloc] init];
    
    passWordDic[@"title"] = @"密码: ";
    passWordDic[@"object"] = self.passwordTextField = [self cellTextField];
    self.passwordTextField.placeholder = @"请输入用户密码";
    
    [self.dataArray addObject:passWordDic];
    
}

- (UITextField *)cellTextField
{
    // 创建
    UITextField *qTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 0.0, SCREEN_WDITH - 80, 50.0)];
    qTextField.text = @"";
    qTextField.borderStyle = UITextBorderStyleNone;
    qTextField.backgroundColor = [UIColor clearColor];
    qTextField.font = [UIFont systemFontOfSize:14];
    qTextField.textColor = [UIColor colorFromHexCode:@"666666"];
    qTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    qTextField.keyboardType = UIKeyboardTypeDefault;
    qTextField.returnKeyType = UIReturnKeyNext;
    qTextField.textAlignment = NSTextAlignmentLeft;
    
    return qTextField;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WDITH, 50)];
        
        leftLabel.backgroundColor = [UIColor clearColor];
        leftLabel.font = [UIFont systemFontOfSize:14];
        leftLabel.textColor = [UIColor colorFromHexCode:@"666666"];
        leftLabel.tag = 11;
        
        [cell.contentView addSubview:leftLabel];
    
    }
    
    
    unsigned long row = [indexPath row];
    //自定义cell
    
    NSMutableDictionary *itemData = self.dataArray[row];

    UILabel *titleLabel = [cell.contentView viewWithTag:11];
    titleLabel.text = itemData[@"title"];
    
    UITextField *textField = itemData[@"object"];
    
    [cell.contentView addSubview:textField];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)actionBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
