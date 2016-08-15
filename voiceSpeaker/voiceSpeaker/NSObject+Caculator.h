//
//  NSObject+Caculator.h
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/15.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CaculateMaker;

@interface NSObject (Caculator)

+(int)makeCaculators:(void (^)(CaculateMaker *maker))make;

@end
