//
//  NSArray+swizzle.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/26.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "NSArray+swizzle.h"

@implementation NSArray (swizzle)

- (id)myLastObject
{
    id ret = [self myLastObject];
    
    return ret;
}

@end
