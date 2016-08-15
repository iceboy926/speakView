//
//  UIView+tapGesture.h
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/12.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (tapGesture)

- (void)setTapGesture:(void(^)(void))block;

@end
