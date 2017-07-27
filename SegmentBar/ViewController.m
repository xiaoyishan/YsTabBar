//
//  ViewController.m
//  SegmentBar
//
//  Created by Sundear on 2017/7/26.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "ViewController.h"

#import "One.h"
#import "Two.h"
#import "Three.h"
#import "Four.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet YsTabBar *TabBar;
@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.



    UILabel *custonView = [UILabel new];
    custonView.userInteractionEnabled = YES;
    custonView.text = @"这是一个自定义View YsTabBar 可以同时存放VC 与 View";
    custonView.numberOfLines = 0;


    
    NSMutableArray *Mycontrollers = @[[One new],[Two new],[Three new],[Four new]].mutableCopy;
    [Mycontrollers addObject:custonView];

    [_TabBar AddSubVCArr:Mycontrollers
                TitleArr:@[@"One",@"Two",@"Three",@"Four",@"自定义View"]
               Switching:^(NSInteger Page) {

        NSLog(@"block return page: %zd" ,Page);

    }];



}





@end
