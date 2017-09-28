//
//  ViewController.m
//  YsTabBar
//
//  Created by xiaSang on 2017/9/24.
//  Copyright © 2017年 xiaSang. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *custonView = [UILabel new];
    custonView.backgroundColor = [UIColor purpleColor];
    custonView.userInteractionEnabled = YES;
    custonView.text = @"这是一个自定义View YsTabBar 可以同时存放VC 与 View";
    custonView.numberOfLines = 0;

        
    

    NSArray *Controllers = @[[NewViewController new],[NewViewController new],[NewViewController new],[NewViewController new],custonView];
    NSArray *Titles = @[@"One",@"Two",@"Three",@"Four",@"纯View"];
    [_TabBar AddSubVCArr:Controllers TitleArr:Titles Switching:^(NSInteger Page) {
        NSLog(@"block return page: %zd" ,Page);
    }];
    
    
}




@end
