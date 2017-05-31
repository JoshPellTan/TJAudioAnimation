//
//  TJAudioAnimation.m
//  TJAudioAnimation
//
//  Created by TanJian on 17/5/31.
//  Copyright © 2017年 Joshpell. All rights reserved.
//

#import "TJAudioAnimation.h"

static CGFloat lineW = 2;
static CGFloat margin = 10;

@interface TJAudioAnimation ()

@property (nonatomic, strong) NSMutableArray *linesArr;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TJAudioAnimation

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.backgroundColor = [UIColor blueColor];
        
        [self configerUI];
    }
    return self;
}

-(void)configerUI{
    
   _lineView = [[UIView alloc]initWithFrame:CGRectMake(margin, (self.bounds.size.height-1)*0.5, self.bounds.size.width-margin, 1)];
    _lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineView];
    
    //上下跳动的线条
    [self addAudioLines];
    
}

-(void)addAudioLines{
    
    CGFloat lineH = self.bounds.size.height*0.5*0.85;
    
    NSInteger lineCount = (_lineView.bounds.size.width-lineW-margin)/(lineW+margin);
    //根据count重新设置横线的长度（微调）
    CGFloat tempW = _lineView.bounds.size.width-(lineW+margin)*(lineCount+1);
    _lineView.frame = CGRectMake(_lineView.frame.origin.x-tempW*0.5, _lineView.frame.origin.y, _lineView.frame.size.width-tempW, _lineView.frame.size.height);
    
    for (int i = 0; i<lineCount+1; i++) {
        
        
        CAShapeLayer *topShapeLayer = [CAShapeLayer new];
        topShapeLayer.frame = CGRectMake(_lineView.frame.origin.x+margin*0.5+(lineW+margin)*i, self.bounds.size.height*0.5*0.15, 2, lineH);
        UIBezierPath *linePathTop = [[UIBezierPath alloc]init];
        [linePathTop moveToPoint:CGPointMake(0, lineH)];
        [linePathTop addLineToPoint:CGPointMake(0, 0)];
        topShapeLayer.path = linePathTop.CGPath;
        topShapeLayer.strokeColor = [UIColor grayColor].CGColor;
        topShapeLayer.lineWidth = 2;
        topShapeLayer.strokeStart = 0;
        topShapeLayer.strokeEnd = 0;
        [self.layer addSublayer:topShapeLayer];
        
        
        CAShapeLayer *bottomShapeLayer = [CAShapeLayer new];
        bottomShapeLayer.frame = CGRectMake(_lineView.frame.origin.x+margin*0.5+(lineW+margin)*i, _lineView.frame.origin.y+1, 2, lineH);
        UIBezierPath *linePathBottom = [[UIBezierPath alloc]init];
        [linePathBottom moveToPoint:CGPointMake(0, 0)];
        [linePathBottom addLineToPoint:CGPointMake(0, lineH)];

        bottomShapeLayer.path = linePathBottom.CGPath;
        bottomShapeLayer.strokeColor = [UIColor grayColor].CGColor;
        bottomShapeLayer.fillColor = [UIColor whiteColor].CGColor;
        bottomShapeLayer.lineWidth = 2;
        bottomShapeLayer.strokeStart = 0;
        bottomShapeLayer.strokeEnd = 0;
        [self.layer addSublayer:bottomShapeLayer];
        
        
        [self.linesArr addObject:@[topShapeLayer,bottomShapeLayer]];
        
    }
    
}

-(void)setupTopBezierPath:(CGPathRef )topBezierPath bottomBezierPath:(CGPathRef )bottomBezierPath{
    
    CAShapeLayer *topShapeLayer = [CAShapeLayer new];
    topShapeLayer.path = topBezierPath;
    topShapeLayer.strokeColor = [UIColor grayColor].CGColor;
    topShapeLayer.fillColor = [UIColor whiteColor].CGColor;
    topShapeLayer.lineWidth = 1;
    topShapeLayer.strokeStart = 0;
    topShapeLayer.strokeEnd = 0;
    [self.layer addSublayer:topShapeLayer];
    
    CAShapeLayer *bottomShapeLayer = [CAShapeLayer new];
    bottomShapeLayer.path = bottomBezierPath;
    bottomShapeLayer.strokeColor = [UIColor grayColor].CGColor;
    bottomShapeLayer.fillColor = [UIColor whiteColor].CGColor;
    bottomShapeLayer.lineWidth = 1;
    bottomShapeLayer.strokeStart = 0;
    bottomShapeLayer.strokeEnd = 0;
    [self.layer addSublayer:bottomShapeLayer];
    
    [self.linesArr addObject:@[topShapeLayer,bottomShapeLayer]];
    
}




-(void)startAnimation{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
}
                      
-(void)timerAction{
  
    for (NSArray *lineArr in self.linesArr) {
        
        int volum = arc4random()%100;
        CGFloat per = volum/100.0;
        for (CAShapeLayer *shapeLayer in lineArr) {
            
            [UIView animateWithDuration:0.15 animations:^{
                shapeLayer.strokeEnd = per;
            }];
            
        }
        
    }
}

-(void)stopAnimation{
    
    [_timer invalidate];
    for (NSArray *lineArr in self.linesArr) {
        
        CGFloat per = 0;
        for (CAShapeLayer *shapeLayer in lineArr) {
            
            [UIView animateWithDuration:0.15 animations:^{
                shapeLayer.strokeEnd = per;
            }];
            
        }
        
    }
}


#pragma mark lazy
-(NSMutableArray *)linesArr{
    
    if (!_linesArr) {
        _linesArr = [NSMutableArray array];
    }
    return _linesArr;
}
@end
