//
//  NSObject+Caculator.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/15.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "NSObject+Caculator.h"
#import "CaculateMaker.h"

@implementation NSObject (Caculator)

+(int)makeCaculators:(void (^)(CaculateMaker *maker))block
{
    CaculateMaker *mkg = [[CaculateMaker alloc] init];
    
    block(mkg);
    
    return mkg.result;
}
@end
