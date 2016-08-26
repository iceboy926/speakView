//
//  leftView.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/26.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "leftView.h"
#import "ColorButton.h"
#import "rightViewController.h"

@interface leftView() <UITableViewDelegate, UITableViewDataSource>
{
    
}

@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation leftView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        NSArray *array = @[@"menu1",@"menu2",@"menu3",@"menu4",@"menu5",@"menu6",@"menu7",@"menu8",@"menu9",@"menu10"];
        [self.dataSource addObjectsFromArray:array];
        
        
        CGRect rectframe = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height);
        
        UITableView *table = [[UITableView alloc] initWithFrame:rectframe];
        table.delegate = self;
        table.dataSource = self;
        
        [self addSubview:table];
        
        
        NSMutableArray *colorArray = [@[[UIColor colorWithRed:0.6 green:0.278 blue:0.757 alpha:1],[UIColor colorWithRed:0.614 green:0.612 blue:0.843 alpha:1]] mutableCopy];
        ColorButton *btn = [[ColorButton alloc]initWithFrame:CGRectMake(0, 0, 150, 50) FromColorArray:colorArray ByGradientType:topToBottom];
        [btn setTitle:@"测试button" forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(onClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];

    }
    
    return self;
}


- (NSMutableArray *)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    //cell.backgroundColor = [UIColor brownColor];
    
    //cell.selectionStyle = UITableViewCellAccessoryNone;
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    //cell.textLabel.textColor = [UIColor redColor];
    NSLog(@"cell text is %@", cell.textLabel.text);
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    rightViewController *nextVc = [[rightViewController alloc]init];
    nextVc.title = self.dataSource[indexPath.row];
    
    if(_blockmenu)
    {
        _blockmenu(nextVc);
    }
//    [self.navigationController pushViewController:nextVc animated:YES];
//    // 设置关闭左侧菜单回到不偏移的MainMenu位置
//    [self.menu closeLeftMenuView];

}



@end
