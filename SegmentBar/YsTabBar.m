//
//  YsTabBar.m
//  SegmentBar
//
//  Created by Sundear on 2017/7/26.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "YsTabBar.h"

#define     ScreenWidth     [UIScreen mainScreen].bounds.size.width

@implementation YsTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}


-(void)AddSubVCArr:(NSArray*)controllers TitleArr:(NSArray*)titles Switching:(ClickBlock)block{

    ItemNum = controllers.count;
    self.bridgeBlock = block;


    myScroller = [UIScrollView new];
    myScroller.delegate = self;
    myScroller.pagingEnabled = YES;
    myScroller.showsHorizontalScrollIndicator = NO;
    [self addSubview:myScroller];


    //首先添加5个视图
    ButtonArr= [NSMutableArray new];
    NSMutableArray *ViewArr  = [NSMutableArray new];

    for (int i = 0; i < ItemNum; i ++) {
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.tag = i+1000;
        [btn addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [ButtonArr addObject:btn]; //保存添加的控件


        //主窗体
        UIView *SubV = [UIView new];
        SubV.backgroundColor = [self randomColor];
        [myScroller addSubview:SubV];
        [ViewArr addObject:SubV];

        //加入主控制器
        [SubV addSubview:[controllers[i] view]];

//        UILabel *SS = [UILabel new];
//        SS.frame = CGRectMake(100, 100, 100, 100);
//        SS.text = [NSString stringWithFormat:@"%zd",i];
//        [SubV addSubview:SS];
    }

    //滑动线条
    myLine = [UIView new];
    myLine.backgroundColor = [UIColor blueColor];
    [self addSubview:myLine];




    //滚动视图
    [myScroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@42);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];

    //滑动线条
    [myLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@40);
        make.left.equalTo(@0);
        make.width.equalTo(@(ScreenWidth/ItemNum));
        make.height.equalTo(@2);
    }];

    //标签
    //水平方向控件间隔固定等间隔
    [ButtonArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    [ButtonArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@1);
        make.height.equalTo(@40);
    }];


    //主窗体
    //水平方向控件间隔固定等间隔
    [ViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [ViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.height.equalTo(myScroller.mas_height);
    }];
    //水平方向宽度固定等间隔
    [ViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:ScreenWidth leadSpacing:0 tailSpacing:0];
    [ViewArr mas_makeConstraints:^(MASConstraintMaker *make) { //数组额你不必须都是view
        make.top.equalTo(@0);
        make.height.equalTo(myScroller.mas_height);
    }];







}

-(void)buttonSelect:(UIButton*)button{
    NSInteger page = button.tag-1000;
    [myScroller setContentOffset:CGPointMake(ScreenWidth*page, 0) animated:YES];
    [self ClickToNewPage:page];


}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger Page = scrollView.contentOffset.x/ScreenWidth;
    [self ClickToNewPage:Page];
}



//触发视图切换效果及交互动画
-(void)ClickToNewPage:(NSInteger)page{

    //判断滑动或点击后是否重复页码
    if (OldPage == page) return;
    OldPage = page;


    self.bridgeBlock(page);//返回当前页码给主控制器

    UIButton *button = [self viewWithTag:page+1000];
    for (UIButton *btn in ButtonArr) {
        if (button == btn) {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//选中
        }else{
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }

    //更新线条
    float myOff_X = ScreenWidth / ItemNum * page;
    [UIView animateWithDuration:.25 animations:^{
        [myLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(myOff_X));
        }];
        [myLine.superview layoutIfNeeded];//强制绘制
    }];
}







-(UIColor*)randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}






@end
