//
//  YsTabBar.m
//  SegmentBar
//
//  Created by Sundear on 2017/7/26.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "YsTabBar.h"

#define     Width                   [[UIScreen mainScreen] bounds].size.width
#define     BasicColor              [UIColor colorWithRed:236/255.0 green:239/255.0 blue:247/255.0 alpha:1]
#define     BasicLightGreenColor    [UIColor colorWithRed:0.851 green:0.961 blue:1.000 alpha:1.000]
#define     BasicBlue               [UIColor colorWithRed:33/255.0 green:137/255.0 blue:205/255.0 alpha:1]//淡蓝主题色


#define Font(X)             [UIFont systemFontOfSize:X];
#define FontB(X)            [UIFont boldSystemFontOfSize:X];

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

    //修复view偏移64
    UIView *FixView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:FixView];

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
    NSMutableArray *LineArr  = [NSMutableArray new];

    for (int i = 0; i < ItemNum; i ++) {
        UIButton *btn = [UIButton new];
        btn.backgroundColor = BasicLightGreenColor;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.tag = i+1000;
        btn.titleLabel.font = Font(13);
        [btn addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [ButtonArr addObject:btn]; //保存添加的控件

        if(i==0)[btn setTitleColor:BasicBlue forState:UIControlStateNormal];

        //主窗体
        UIView *SubV = [UIView new];
//        SubV.backgroundColor = [self randomColor];
        [myScroller addSubview:SubV];
        [ViewArr addObject:SubV];

        //加入主控制器 或 View
        //判断是这3种控制器时
        if([controllers[i] isKindOfClass:[UIViewController class]]||
            [controllers[i] isKindOfClass:[UITableViewController class]]||
            [controllers[i] isKindOfClass:[UICollectionViewController class]]){
            [SubV addSubview:[controllers[i] view]];
            [[self viewController:self] addChildViewController:controllers[i]];//加入控制器
        }else{
            //view
            [SubV addSubview:controllers[i]];
        }
        //子view 占满布局
        [SubV.subviews.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
        }];



    }

    //展分线条
    for (int k=0; k<ItemNum-1; k++) {
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor lightGrayColor];
        line.alpha = .15;
        [self addSubview:line];
        [LineArr addObject:line];
    }


    //滑动线条
    myLine = [UIView new];
    myLine.backgroundColor = BasicBlue;
    [self addSubview:myLine];







    //滚动视图
    [myScroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@40);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];

    //滑动线条
    [myLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@38);
        make.left.equalTo(@0);
        make.width.equalTo(@(Width/ItemNum));
        make.height.equalTo(@2);
    }];

    //标签
    //水平方向控件间隔固定等间隔
    if (ButtonArr.count>1) {
        [ButtonArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [ButtonArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.height.equalTo(@40);
        }];
    }

    //展分线条
    if (LineArr.count>1) {
        [LineArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:1 leadSpacing:Width/ItemNum tailSpacing:Width/ItemNum];
        [LineArr mas_makeConstraints:^(MASConstraintMaker *make) { //数组额你不必须都是view
            make.top.equalTo(@0);
            make.height.equalTo(@40);
        }];
    }




    //主窗体
    //水平方向控件间隔固定等间隔
    if (ViewArr.count>1) {
        [ViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [ViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.height.equalTo(myScroller.mas_height);
        }];
    }

    //水平方向宽度固定等间隔
    if (ViewArr.count>1) {
        [ViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:Width leadSpacing:0 tailSpacing:0];
        [ViewArr mas_makeConstraints:^(MASConstraintMaker *make) { //数组额你不必须都是view
            make.top.equalTo(@0);
            make.height.equalTo(myScroller.mas_height);
        }];
    }






}

-(void)buttonSelect:(UIButton*)button{
    NSInteger page = button.tag-1000;
    [myScroller setContentOffset:CGPointMake(Width*page, 0) animated:YES];
    [self ClickToNewPage:page];


}

//iOS8版本之前不能使用这个危险的方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger Page = scrollView.contentOffset.x/Width;
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
            [btn setTitleColor:BasicBlue forState:UIControlStateNormal];//选中
        }else{
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
    }

    //更新线条
    float myOff_X = Width / ItemNum * page;
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


//返回当前视图的控制器
- (UIViewController *)viewController:(UIView*)myView {

    for (UIView* next = [myView superview]; next; next = next.superview) {

        UIResponder *nextResponder = [next nextResponder];

        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



@end
