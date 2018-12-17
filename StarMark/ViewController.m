//
//  ViewController.m
//  StarMark
//
//  Created by 李子栋 on 2018/3/14.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import "ViewController.h"
#import "BBSStarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    BBSStarView *starView = [[BBSStarView alloc] initWithFrame:CGRectMake(100, 100, 200, 60) starWidth:30 score:3.5 normalColor:[UIColor yellowColor] selectedColor:[UIColor redColor] type:BBSStarViewTypeShow];
    starView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:starView];
    
    
    BBSStarView *starView2 = [[BBSStarView alloc] initWithFrame:CGRectMake(100, 300, 200, 60) starWidth:40 score:4.8 normalColor:[UIColor yellowColor] selectedColor:[UIColor redColor] type:BBSStarViewTypeMark];
    starView2.backgroundColor = [UIColor blueColor];
    starView2.callback = ^(CGFloat score) {
        //score 取值在0-5之间。需要自己判断
        NSLog(@"%.1f",score);
    };
    [self.view addSubview:starView2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
