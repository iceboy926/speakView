//
//  shadowView.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/11.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "shadowView.h"

@implementation shadowView

- (void)drawRect:(CGRect)rect
{
    //[super drawRect:rect];
    
    
    //可以通过CGContextSaveGState过程保存图形上下文的状态，通过CGContextRestoreGState恢复到以前的状态.恢复图形上下文的状态会恢复一切，包括填充颜色、字体、线条粗细等
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //用灰色设置背景颜色
    /*第二个参数：阴影的位移,由 CGSize 类型值指定,从每个形状要应用阴影的右下部分开始。位移的 x 值越大,形状
     右边的阴影就扩散得越远。位移的 y 值越大,下部的阴影就越低。
     第三个参数：阴影的模糊值,以浮点值(CGFloat)来指定。指定 0.0f 将导致阴影成为固态形状。这个值越高,阴影就越
     模糊。我们很快能看到例子。
     */
    CGContextSetShadowWithColor(currentContext, CGSizeMake(3.0f, 3.0f), 10.0f, [[UIColor grayColor] CGColor]);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect firstRect = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    CGPathAddRect(path, NULL, firstRect);
    CGContextAddPath(currentContext, path);
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
    CGContextDrawPath(currentContext, kCGPathFill);
    
    CGPathRelease(path);
    
    NSString *string = @"有志者事竟成";
    [string drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor greenColor]}];


}

@end
