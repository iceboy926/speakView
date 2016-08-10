//
//  SpeakerView.m
//  LXWaveProgressDemo
//
//  Created by 金玉衡 on 16/8/10.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#define TOTAL_NUM  11
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

#define Color(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define FillColor Color(100,200,200)

#import "SpeakerView.h"

@interface SpeakerView()
{
    UIView *topView;
    UIView *bottomView;
    
    CAShapeLayer *_indicateLayer;
    
    NSMutableArray *indicateLayerArray;
    
    NSTimer *timer;
    NSInteger voice;
    BOOL  blOver;
}

@end

@implementation SpeakerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        indicateLayerArray = [NSMutableArray array];
        
        [self setup];
        
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGesture:)];
        
        longGesture.minimumPressDuration = 0.5;
        
        [self addGestureRecognizer:longGesture];
        
        voice = TOTAL_NUM/2;
        blOver = YES;
        
        [self timerRefreshVoice:nil];
        
    }

    

    
    return self;
}

- (void)setup
{
    topView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)/2.0 - CGRectGetWidth(self.bounds)/4.0, 0, CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)/3.0*2.0)];
    
    topView.backgroundColor = [UIColor clearColor];
    topView.clipsToBounds = YES;
    topView.layer.borderWidth = 4;
    topView.layer.borderColor = FillColor.CGColor;
    topView.layer.cornerRadius = CGRectGetWidth(topView.frame)/2.0;
    
    [self addSubview:topView];
    
    [self addLayerArray];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) - CGRectGetHeight(self.bounds)/6.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)/2.0)];
    
    bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview:bottomView];
    
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    arcLayer.frame = CGRectMake(0, 0, CGRectGetWidth(bottomView.frame), CGRectGetHeight(bottomView.frame)/3.0);
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor = FillColor.CGColor;
    arcLayer.lineCap = kCALineCapRound;
    arcLayer.lineWidth = 8;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(bottomView.frame)/2.0, 0) radius:CGRectGetWidth(bottomView.frame)/12.0*5.0 startAngle:degreesToRadians(180) endAngle:degreesToRadians(360) clockwise:NO];
    arcLayer.path = [path CGPath];
    
    [bottomView.layer addSublayer:arcLayer];
    
    
    
    CAShapeLayer *vertialRectLayer = [CAShapeLayer layer];
    //vertialRectLayer.frame = CGRectMake(0, CGRectGetHeight(bottomView.frame)/3.0, CGRectGetWidth(bottomView.frame), CGRectGetHeight(bottomView.frame)/3.0);
    vertialRectLayer.fillColor = FillColor.CGColor;
    vertialRectLayer.strokeColor = FillColor.CGColor;
    UIBezierPath *vertialPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetWidth(bottomView.frame)/2.0 - 4, CGRectGetWidth(bottomView.frame)/12.0*5.0, 8, CGRectGetHeight(bottomView.frame)/3.0) cornerRadius:4];
    
    vertialRectLayer.lineWidth = 1;
    vertialRectLayer.lineCap = kCALineCapRound;
    vertialRectLayer.path = [vertialPath CGPath];
    
    [bottomView.layer addSublayer:vertialRectLayer];
    
    
    
    
    CAShapeLayer *horizonialRectLayer = [CAShapeLayer layer];
    
    horizonialRectLayer.fillColor = FillColor.CGColor;
    horizonialRectLayer.strokeColor = FillColor.CGColor;
    
    UIBezierPath *horizonPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetWidth(bottomView.frame)/12.0*5.0 + CGRectGetHeight(bottomView.frame)/3.0, CGRectGetWidth(bottomView.frame), 8) cornerRadius:2];
    
    horizonialRectLayer.path = [horizonPath CGPath];
    
    [bottomView.layer addSublayer:horizonialRectLayer];
    
    
}

- (void)addLayerArray
{
    CGFloat layerHeight = CGRectGetHeight(topView.frame)/TOTAL_NUM;
    
    for (int i = 0; i < TOTAL_NUM; i++) {
        
        CGFloat y = CGRectGetHeight(topView.frame)-(i+1)*layerHeight;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, y, CGRectGetWidth(topView.frame), layerHeight) cornerRadius:0];
        CAShapeLayer *Layer = [CAShapeLayer layer];
        Layer.path = path.CGPath;
        Layer.fillColor = self.backgroundColor.CGColor;
        [topView.layer addSublayer:Layer];
        [indicateLayerArray addObject:Layer];
    }


}


- (void)LongPressGesture:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        voice = TOTAL_NUM/2;
        blOver = YES;
        
        timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerRefreshVoice:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [timer fire];

    }
    else if(gesture.state == UIGestureRecognizerStateChanged)
    {
        
    }
    else if(gesture.state == UIGestureRecognizerStateEnded)
    {
        if(timer.isValid)
        {
            [timer invalidate];
            timer = nil;
            voice = TOTAL_NUM/2;
            blOver = YES;
            [self timerRefreshVoice:nil];
        }
    }
}

- (void)timerRefreshVoice:(NSTimer *)time
{
    [self updateTopViewLayer:voice];
    
    if(voice == TOTAL_NUM-1)
    {
        blOver = NO;
    }
    else if(voice == 1)
    {
        blOver = YES;
    }
    
    if(blOver)
    {
        voice++;
    }
    else
    {
        voice--;
    }
}


- (void)updateTopView:(NSInteger)power
{
    CGFloat height = (power)*(CGRectGetHeight(topView.frame)/TOTAL_NUM);
    [_indicateLayer removeFromSuperlayer];
    _indicateLayer = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetHeight(topView.frame)-height, CGRectGetWidth(topView.frame), height) cornerRadius:0];
    _indicateLayer = [CAShapeLayer layer];
    _indicateLayer.path = path.CGPath;
    _indicateLayer.fillColor = FillColor.CGColor;
    [topView.layer addSublayer:_indicateLayer];

}

- (void)updateTopViewLayer:(NSInteger)power
{
    for (int i = 0; i < TOTAL_NUM; i++) {
        
        CAShapeLayer *layer = [indicateLayerArray objectAtIndex:i];
        
        if(i > power)
        {
            layer.fillColor = self.backgroundColor.CGColor;
        }
        else
        {
        
            if(i%2 == 0)
            {
                layer.fillColor = self.backgroundColor.CGColor;
            }
            else
            {
                layer.fillColor = FillColor.CGColor;
            }
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
}

@end
