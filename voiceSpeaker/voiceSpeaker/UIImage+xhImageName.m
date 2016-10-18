//
//  UIImage+xhImageName.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/10/18.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "UIImage+xhImageName.h"
#import <objc/runtime.h>

@implementation UIImage (xhImageName)

+(UIImage *)xh_ImageNamed:(NSString *)namestr
{
    NSString *imageStr = namestr;
    double version = [[[UIDevice currentDevice] systemVersion] doubleValue];
    if(version > 7.0)
    {
        imageStr = [imageStr stringByAppendingString:@"_os7"];
    }
    
    return [UIImage xh_ImageNamed:imageStr];
}

+ (void)load
{
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    
    Method m2 = class_getClassMethod([UIImage class], @selector(xh_ImageNamed:));
    
    method_exchangeImplementations(m1, m2);
}

@end
