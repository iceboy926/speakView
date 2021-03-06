//
//  UIView+tapGesture.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/12.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "UIView+tapGesture.h"
#import <objc/runtime.h>

@implementation UIView (tapGesture)

static char *kDTActionHandlerTapGestureKey = "gesturekeys";
static char *kDTActionHandlerTapBlockKey = "blockKeys";

- (void)setTapGesture:(void (^)(void))block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
    if (!gesture)
        
    {
        
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        
        [self addGestureRecognizer:gesture];
        
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
        
    }
    
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);

}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    void (^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
    if(action)
    {
        action();
    }
}

@end
