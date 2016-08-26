//
//  leftView.h
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/26.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockMenu)(UIViewController *vc);

@interface leftView : UIView

@property (nonatomic, copy) BlockMenu blockmenu;

@property (nonatomic, copy) void (^leftblock)(id sender);

@end
