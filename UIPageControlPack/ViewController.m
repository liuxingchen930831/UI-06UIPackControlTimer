//
//  ViewController.m
//  UIPageControlPack
//
//  Created by liuxingchen on 16/9/7.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "ViewController.h"
#import "XCView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XCView *view = [XCView LoadXib];
    view.frame = CGRectMake(20, 50, 300, 200);
    view.imageNames = @[@"img_01",@"img_02",@"img_03",@"img_04",@"img_00"];
    [self.view addSubview:view];
    
}
@end
