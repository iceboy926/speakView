//
//  Product_Custom.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/22.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "Product_Custom.h"

@interface Product_Custom()
{
    NSMutableArray *productArray;
    NSCondition *condition;
}

@end

@implementation Product_Custom

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        productArray = [NSMutableArray array];
        condition = [[NSCondition alloc] init];
    }
    
    return self;
}

- (void)product_cunstom_test
{
    NSThread *customThread = [[NSThread alloc] initWithTarget:self selector:@selector(CreateCustom) object:nil];
    [customThread start];
    
    NSThread *productThread = [[NSThread alloc] initWithTarget:self selector:@selector(CreateProduct) object:nil];
    [productThread start];

}

- (void)CreateProduct
{
    [condition lock];
    [productArray addObject:[[NSObject alloc] init]];
    NSLog(@"Create a object");
    [condition signal];
    [condition unlock];
}

- (void)CreateCustom
{
    [condition lock];
    while ([productArray count] == 0) {
        NSLog(@"waiting for product");
        [condition wait];
    }
    
    [productArray removeObjectAtIndex:0];
    NSLog(@"Custom a object");
    [condition unlock];
}

@end
