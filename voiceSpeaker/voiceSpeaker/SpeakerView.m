//
//  SpeakerView.m
//  LXWaveProgressDemo
//
//  Created by 金玉衡 on 16/8/10.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#define TOTAL_NUM  8
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

#import "SpeakerView.h"

@interface SpeakerView()
{
    UIView *topView;
    UIView *bottomView;
    
    CAShapeLayer *_indicateLayer;
    
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
        [self setup];
        
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGesture:)];
        
        longGesture.minimumPressDuration = 0.5;
        
        [self addGestureRecognizer:longGesture];
        
        voice = 1;
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
    topView.layer.borderWidth = 0.5;
    topView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    topView.layer.cornerRadius = CGRectGetWidth(topView.frame)/2.0;
    
    [self addSubview:topView];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) - CGRectGetHeight(self.bounds)/6.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)/2.0)];
    
    bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview:bottomView];
    
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    arcLayer.frame = CGRectMake(0, 0, CGRectGetWidth(bottomView.frame), CGRectGetHeight(bottomView.frame)/3.0);
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    arcLayer.lineCap = kCALineCapRound;
    arcLayer.lineWidth = 8;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(bottomView.frame)/2.0, 0) radius:CGRectGetWidth(bottomView.frame)/12.0*5.0 startAngle:degreesToRadians(180) endAngle:degreesToRadians(360) clockwise:NO];
    arcLayer.path = [path CGPath];
    
    [bottomView.layer addSublayer:arcLayer];
    
    
    
    CAShapeLayer *vertialRectLayer = [CAShapeLayer layer];
    //vertialRectLayer.frame = CGRectMake(0, CGRectGetHeight(bottomView.frame)/3.0, CGRectGetWidth(bottomView.frame), CGRectGetHeight(bottomView.frame)/3.0);
    vertialRectLayer.fillColor = [UIColor lightGrayColor].CGColor;
    vertialRectLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    UIBezierPath *vertialPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetWidth(bottomView.frame)/2.0 - 4, CGRectGetWidth(bottomView.frame)/12.0*5.0, 8, CGRectGetHeight(bottomView.frame)/3.0) cornerRadius:4];
    
    vertialRectLayer.lineWidth = 1;
    vertialRectLayer.lineCap = kCALineCapRound;
    vertialRectLayer.path = [vertialPath CGPath];
    
    [bottomView.layer addSublayer:vertialRectLayer];
    
    
    
    
    CAShapeLayer *horizonialRectLayer = [CAShapeLayer layer];
    
    horizonialRectLayer.fillColor = [UIColor lightGrayColor].CGColor;
    horizonialRectLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    
    UIBezierPath *horizonPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetWidth(bottomView.frame)/12.0*5.0 + CGRectGetHeight(bottomView.frame)/3.0, CGRectGetWidth(bottomView.frame), 8) cornerRadius:2];
    
    horizonialRectLayer.path = [horizonPath CGPath];
    
    [bottomView.layer addSublayer:horizonialRectLayer];
    
    
}


- (void)LongPressGesture:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        voice = 1;
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
            voice = 1;
            blOver = YES;
            [self timerRefreshVoice:nil];
        }
    }
}

- (void)timerRefreshVoice:(NSTimer *)time
{
    [self updateTopView:voice];
    
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
    _indicateLayer.fillColor = [UIColor lightGrayColor].CGColor;
    [topView.layer addSublayer:_indicateLayer];

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
}

@end
