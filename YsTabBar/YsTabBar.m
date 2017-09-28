//
//  YsTabBar.m
//  SegmentBar
//
//  Created by Sundear on 2017/7/26.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "YsTabBar.h"



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
    myScroller.contentSize =CGSizeMake(self.frame.size.width*(controllers.count), 0);
    [self addSubview:myScroller];


    //首先添加分页视图
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

        //pages主窗体
        UIView *SubV = [UIView new];
//        SubV.frame = CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height-40);
//        SubV.backgroundColor = [self randomColor];//随机颜色
        [myScroller addSubview:SubV];
        [ViewArr addObject:SubV];

        //加入主控制器 或 View
        //判断是这3种控制器时
        if([controllers[i] isKindOfClass:[UIViewController class]]||
            [controllers[i] isKindOfClass:[UITableViewController class]]||
            [controllers[i] isKindOfClass:[UICollectionViewController class]]){
//            UIView *view = [controllers[i] view];
//            view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-40);
            [SubV addSubview:[controllers[i] view]];
            [[self viewController:self] addChildViewController:controllers[i]];//加入控制器
        }else{
            //view
            [SubV addSubview:controllers[i]];
        }
        //子view 占满布局
//        [SubV.subviews.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@0);
//            make.left.equalTo(@0);
//            make.right.equalTo(@0);
//            make.bottom.equalTo(@0);
//        }];
        SubV.subviews.firstObject.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-40);


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
//    [myScroller mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@40);
//        make.left.equalTo(@0);
//        make.right.equalTo(@0);
//        make.bottom.equalTo(@0);
//    }];
    myScroller.frame = CGRectMake(0, 40, self.frame.size.width, self.frame.size.height-40);

    //滑动线条
//    [myLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@38);
//        make.left.equalTo(@0);
//        make.width.equalTo(@(Width/ItemNum));
//        make.height.equalTo(@2);
//    }];
    myLine.frame = CGRectMake(0, 38, self.frame.size.width/ItemNum, 2);


    //标签
    //水平方向控件间隔固定等间隔
    if (ButtonArr.count>1) {
//        [ButtonArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
//        [ButtonArr mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@0);
//            make.height.equalTo(@40);
//        }];
        for (int k=0; k<ButtonArr.count; k++) {
            UIButton *btn = ButtonArr[k];
            CGFloat btn_w = self.frame.size.width/ButtonArr.count;
            btn.frame = CGRectMake(btn_w*k, 0, btn_w, 40);
        }
    }

    //展分线条
    if (LineArr.count>1) {
//        [LineArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:1 leadSpacing:Width/ItemNum tailSpacing:Width/ItemNum];
//        [LineArr mas_makeConstraints:^(MASConstraintMaker *make) { //数组额你不必须都是view
//            make.top.equalTo(@0);
//            make.height.equalTo(@40);
//        }];
        for (int k=1; k<=LineArr.count; k++) {
            UILabel *btn = LineArr[k-1];
            CGFloat btn_w = self.frame.size.width/ButtonArr.count;
            btn.frame = CGRectMake(btn_w*k-0.5, 0, 1, 40);
        }
    }




//    //主窗体
//    //水平方向控件间隔固定等间隔
//    if (ViewArr.count>1) {
//        [ViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
//        [ViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@0);
//            make.height.equalTo(myScroller.mas_height);
//        }];
//    }
//
//    //水平方向宽度固定等间隔
//    if (ViewArr.count>1) {
//        [ViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:Width leadSpacing:0 tailSpacing:0];
//        [ViewArr mas_makeConstraints:^(MASConstraintMaker *make) { //数组额你不必须都是view
//            make.top.equalTo(@0);
//            make.height.equalTo(myScroller.mas_height);
//        }];
//    }


    if (ViewArr.count>1) {
        for (int k=0; k<ViewArr.count; k++) {
            UIView *btn = ViewArr[k];
            btn.frame = CGRectMake(self.frame.size.width*k, 0, self.frame.size.width, self.frame.size.height-40);
        }
    }



}

-(void)buttonSelect:(UIButton*)button{
    NSInteger page = button.tag-1000;
    [myScroller setContentOffset:CGPointMake(self.frame.size.width*page, 0) animated:YES];
    [self ClickToNewPage:page];


}

//iOS8版本之前不能使用这个危险的方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger Page = scrollView.contentOffset.x/self.frame.size.width;
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
    float myOff_X = self.frame.size.width / ItemNum * page;
    [UIView animateWithDuration:.25 animations:^{
//        [myLine mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@(myOff_X));
//        }];
//        [myLine.superview layoutIfNeeded];//强制绘制
        CGRect bounce = myLine.frame;
        bounce.origin.x = myOff_X;
        myLine.frame = bounce;
    }];
}


/**滚动到某分页 */
-(void)ScrollerPage:(NSInteger)page{
    UIButton *button = [self viewWithTag:1000+page];
    if(button)[self buttonSelect:button];
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
