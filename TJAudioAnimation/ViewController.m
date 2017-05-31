//
//  ViewController.m
//  TJAudioAnimation
//
//  Created by TanJian on 17/5/31.
//  Copyright © 2017年 Joshpell. All rights reserved.
//

#import "ViewController.h"
#import "TJAudioAnimation.h"


@interface ViewController ()

@property (nonatomic, strong) TJAudioAnimation *ani;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _ani = [[TJAudioAnimation alloc]initWithFrame:CGRectMake(50, 150, 265, 50)];
    
    [self.view addSubview:_ani];
    
    UIButton *playBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 50,50)];
    playBtn.backgroundColor = [UIColor greenColor];
    [playBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    
    
}

-(void)buttonClickAction:(UIButton *)button{
    
    button.selected = !button.selected;
    if (button.selected) {
        [_ani startAnimation];
    }else{
        [_ani stopAnimation];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
