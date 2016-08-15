//
//  CaculateMaker.h
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/15.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculateMaker : NSObject

@property (nonatomic, assign) int result;

- (CaculateMaker *(^)(int))add;
- (CaculateMaker *(^)(int))sub;
- (CaculateMaker *(^)(int))multi;
- (CaculateMaker *(^)(int))div;


@end
