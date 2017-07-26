//
//  YsTabBar.h
//  SegmentBar
//
//  Created by Sundear on 2017/7/26.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@interface YsTabBar : UIView<UIScrollViewDelegate>{
    UIScrollView *myScroller;
    UIView *myLine;
    NSMutableArray *ButtonArr;
    NSInteger ItemNum;
    NSInteger OldPage;
}

typedef void (^ClickBlock)(NSInteger Page);
@property (nonatomic, copy) ClickBlock bridgeBlock;//桥接的block

-(void)AddSubVCArr:(NSArray*)controllers TitleArr:(NSArray*)titles Switching:(ClickBlock)block;

@end
