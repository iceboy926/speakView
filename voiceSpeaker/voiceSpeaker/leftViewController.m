//
//  leftViewController.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/24.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "leftViewController.h"
#import "ColorButton.h"

@interface leftViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *table;
}

@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leftbackiamge"]];
    
    // 创建dataSource
    NSArray *array = @[@"menu1",@"menu2",@"menu3",@"menu4",@"menu5",@"menu6",@"menu7",@"menu8",@"menu9",@"menu10"];
    [self.dataSource addObjectsFromArray:array];
    
    
    CGRect rectframe = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    
    table = [[UITableView alloc] initWithFrame:rectframe];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:table];
    
    
//        NSMutableArray *colorArray = [@[[UIColor colorWithRed:0.6 green:0.278 blue:0.757 alpha:1],[UIColor colorWithRed:0.614 green:0.612 blue:0.843 alpha:1]] mutableCopy];
//        ColorButton *btn = [[ColorButton alloc]initWithFrame:CGRectMake(0, 0, 150, 50) FromColorArray:colorArray ByGradientType:topToBottom];
//        [btn setTitle:@"测试button" forState:UIControlStateNormal];
//    
//        [btn addTarget:self action:@selector(onClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
//    //    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    //    btn.layer.shadowOffset = CGSizeMake(3, 3);
//    //    btn.layer.shadowColor = [UIColor grayColor].CGColor;
//    //    btn.layer.shadowOpacity = 0.8;
//    
//        [self.view addSubview:btn];
    
    

    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (NSMutableArray *)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    //cell.selectionStyle = UITableViewCellAccessoryNone;
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    //cell.textLabel.textColor = [UIColor redColor];
    NSLog(@"cell text is %@", cell.textLabel.text);
    return cell;
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
