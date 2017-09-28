//
//  NewViewController.m
//  YsTabBar
//
//  Created by Sundear on 2017/9/26.
//  Copyright © 2017年 xiaSang. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *SS = [UILabel new];
    SS.frame = CGRectMake(10, 100, 200, 100);
    SS.text = @"NewVC NewVC NewVC NewVC NewVC NewVC ";
    [self.view addSubview:SS];
    
//    self.view.backgroundColor = [UIColor orangeColor];
}



@end
