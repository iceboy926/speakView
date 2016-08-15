//
//  CaculateMaker.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/15.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "CaculateMaker.h"

@implementation CaculateMaker

- (instancetype)init
{
    self = [super self];
    if(self)
    {
        _result = 0;
    }
    
    return self;
}

- (CaculateMaker *(^)(int))add
{
    CaculateMaker *(^ addValue)(int) = ^(int value){
    
        _result += value;
        return self;
    };
    
    
    return addValue;
    
//    return ^ CaculateMaker *(int value){
//        
//        _result += value;
//        
//        return self;
//    };
}

- (CaculateMaker *(^)(int))sub
{
    CaculateMaker *(^subValue)(int value) = ^(int value){
    
        _result -= value;
        
        return self;
    };
    
    
    return subValue;
}
- (CaculateMaker *(^)(int))multi
{
    CaculateMaker *(^multiValue)(int value) = ^(int value){
    
        _result *= value;
        
        return self;
    };
    
    
    return multiValue;
}

- (CaculateMaker *(^)(int))div
{
    CaculateMaker *(^divValue)(int value) = ^(int value){
        
        _result /= value;
        
        return self;
    };
    
    
    return divValue;
}

@end
