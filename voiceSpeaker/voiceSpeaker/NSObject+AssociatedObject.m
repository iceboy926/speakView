//
//  NSObject+AssociatedObject.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/11.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObject)


- (void)setAssociatedObject:(id)Object
{
    objc_setAssociatedObject(self, @selector(associatedObject), Object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (id)associatedObject
{
    return objc_getAssociatedObject(self, @selector(associatedObject));
}

@end
