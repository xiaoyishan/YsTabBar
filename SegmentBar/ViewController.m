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


    

    [_TabBar AddSubVCArr:@[[One new],[Two new],[Three new],[Four new]]
                TitleArr:@[@"One",@"Two",@"Three",@"Four"]
               Switching:^(NSInteger Page) {

        NSLog(@"block return page: %zd" ,Page);

    }];



}





@end
