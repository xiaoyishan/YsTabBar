//
//  YsTabBar.h
//  SegmentBar
//
//  Created by Sundear on 2017/7/26.
//  Copyright © 2017年 xiexin. All rights reserved.
//  兼容iOS11 放弃对masonry的支持来提高良好的拓展适应性

#import <UIKit/UIKit.h>
//#import "Masonry.h"
//#define     KWidth                   [[UIScreen mainScreen] bounds].size.width
//#define     KHeight                  [[UIScreen mainScreen] bounds].size.height
#define     BasicColor              [UIColor colorWithRed:236/255.0 green:239/255.0 blue:247/255.0 alpha:1]
#define     BasicLightGreenColor    [UIColor colorWithRed:0.851 green:0.961 blue:1.000 alpha:1.000]
#define     BasicBlue               [UIColor colorWithRed:33/255.0 green:137/255.0 blue:205/255.0 alpha:1]//淡蓝主题色
#define Font(X)             [UIFont systemFontOfSize:X];
#define FontB(X)            [UIFont boldSystemFontOfSize:X];

@interface YsTabBar : UIView<UIScrollViewDelegate>{
    UIScrollView *myScroller;
    UIView *myLine;
    NSMutableArray *ButtonArr;
    NSInteger ItemNum;
    NSInteger OldPage;
    float SelfWidth;
}
typedef void (^ClickBlock)(NSInteger Page);
@property (nonatomic, copy) ClickBlock bridgeBlock;//桥接的block



/* 添加自定义控制器 或 自定义View    到 YsTableBar */
-(void)AddSubVCArr:(NSArray*)controllers TitleArr:(NSArray*)titles Switching:(ClickBlock)block;

/** 滚动到某分页 */
-(void)ScrollerPage:(NSInteger)page;


@end
