//
//  DrawViewController.m
//  lovewith
//
//  Created by imqiuhang on 15/4/22.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import "DrawViewController.h"
#import "AlertViewWithBlockOrSEL.h"
#import "UIView+QHUIViewCtg.h"
#define margin              20.f
#define colorSliderNavHeigh 44.f
#define colorBtnWidth       30.f
#define colorBtnmargin      10

@interface DrawViewController ()

@end

@implementation DrawViewController
{
    NSArray      *colorArr;
    UIScrollView *colorNavScrollView;
    NSString     *curHexColor;
    NSString     *lastColor;
    float        curWidth;
    CGPoint      MyBeganpoint;
    CGPoint      MyMovepoint;
    UIView       *chooseWidthView;
    CGRect       changeWithViewDefaultFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initColorBtn];
    [self initView ];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([gestureRecognizer isEqual:self.navigationController.interactivePopGestureRecognizer]) {
        
        return NO;
        
    } else {
        
        return YES;
        
    }
    
}

#pragma mark - valueChanged
- (void)colorBtnEvent:(UIButton *)sender {
    curHexColor = colorArr[sender.tag];
    lastColor = curHexColor;
    self.rubberBtn.tag=0;
    curHexColor=lastColor;
    [self.rubberBtn setImage:[UIImage imageNamed :@"icon_runbbsh_gray@3x"] forState:UIControlStateNormal];
    [self changeColor:self.changeColorBtn];
}

- (IBAction)rubberBtnEvent:(id)sender {
    if (self.rubberBtn.tag==0) {
       curHexColor = @"#ffffff";
        self.rubberBtn.tag=1;
        [self.rubberBtn setImage:[UIImage imageNamed :@"icon_runbbsh_pink"] forState:UIControlStateNormal];
    }else {
        self.rubberBtn.tag=0;
        curHexColor=lastColor;
        [self.rubberBtn setImage:[UIImage imageNamed :@"icon_runbbsh_gray@3x"] forState:UIControlStateNormal];
    }
    
}

//撤销一步的操作，貌似需求不需要了
- (IBAction)backBtnEvent:(id)sender {
    [self.drawPaletteView myLineFinallyRemove];
}

- (IBAction)cleanBtnEvent:(id)sender {
    AlertViewWithBlockOrSEL *alertView = [[AlertViewWithBlockOrSEL alloc] initWithTitle:@"清空画板" message:@"确定清空自己的画板?这将无法撤销."] ;
    [alertView addOtherButtonWithTitle:@"清空" onTapped:^{
        [self.drawPaletteView myalllineclear];
    }];
    [alertView setCancelButtonWithTitle:@"取消" onTapped:^{
    }];
    [alertView show];

}

- (IBAction)widthValueChangedEvent:(UISlider *)sender {
    curWidth = sender.value;
}

- (IBAction)changeColor:(UIButton *)sender {
    sender.enabled=NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        colorNavScrollView.width =  colorNavScrollView.width<QHScreenWidth?QHScreenWidth:0;
    } completion:^(BOOL finished) {
        sender.enabled = YES;
        
    }];
}

- (IBAction)chageWidth:(UIButton *)sender {
    
    sender.enabled=NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (chooseWidthView.height>0) {
            chooseWidthView.height=0;
            chooseWidthView.bottom = self.view.bottom-self.bottomView.height;
        }else {
            chooseWidthView.frame=changeWithViewDefaultFrame;
        }
    } completion:^(BOOL finished) {
        sender.enabled = YES;
        
    }];
}

- (void)selectWidth:(int)index {
    for(UIButton *btn in chooseWidthView.subviews) {
        if (btn.tag==index) {
            btn.backgroundColor = QHRGB(255, 100, 153);;
        }else {
            btn.backgroundColor = QHRGB(216, 216, 316);;
        }
    }
    curWidth = (index+1)*3;
    
}

- (void)widthBtnEvent:(UIButton *)sender {
    [self selectWidth:(int)sender.tag];
    [self chageWidth:self.chooseWidthBtn];
}

#pragma mark - drawWhileTouch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch=[touches anyObject];
    MyBeganpoint=[touch locationInView:self.drawPaletteView ];
    
    [self.drawPaletteView IntroductionpointHexColor:curHexColor];
    [self.drawPaletteView IntroductionpointWidth:curWidth];
    [self.drawPaletteView IntroductionpointInitPoint];
    [self.drawPaletteView IntroductionpointAddPoint:MyBeganpoint];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray* MovePointArray=[touches allObjects];
    MyMovepoint=[[MovePointArray objectAtIndex:0] locationInView:self.drawPaletteView];
    [self.drawPaletteView IntroductionpointAddPoint:MyMovepoint];
    [self.drawPaletteView setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.drawPaletteView IntroductionpointSavePoint];
    [self.drawPaletteView setNeedsDisplay];
}

#pragma mark -init
- (void)initColorBtn {
    
    [self.view addSubview:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)]];

    colorArr = @[
      @"#ffc0cb",
      @"#fb0d0d",
      @"#d65303",
      @"#d69803",
      @"#d6d403",
      @"#acd603",
      @"#4ed603",
      @"#03d666",
      @"#03d6c0",
      @"#03b6d6",
      @"#0366d6",
      @"#2b03d6",
      @"#7a03d6",
      @"#bb03d6",
      @"#d603ac",
      @"#d6036b",
    ];

    colorNavScrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, QHScreenWidth, colorSliderNavHeigh)];
    colorNavScrollView.bottom = self.view.height-self.bottomView.height;
    colorNavScrollView.contentSize =CGSizeMake(margin*2+colorBtnWidth*colorArr.count+colorBtnmargin*(colorArr.count-1), colorNavScrollView.contentSize.height);
    colorNavScrollView.showsVerticalScrollIndicator   = NO;
    colorNavScrollView.showsHorizontalScrollIndicator = NO;
    colorNavScrollView.bounces                        = YES;
    [self.view addSubview:colorNavScrollView];
    colorNavScrollView.width = 0;
    
    for (int i=0; i<colorArr.count; i++) {
        UIButton *colorBtn          = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, colorBtnWidth, colorBtnWidth)];
        colorBtn.left               = margin+i*colorBtnWidth+i*colorBtnmargin;
        colorBtn.centerY            = colorNavScrollView.height/2.f;
        colorBtn.tintColor          = [DrawPaletteView colorWithHexString:colorArr[i]];
        [colorBtn setImage:[[UIImage imageNamed:@"icon_draw_color_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        colorBtn.tag                = i;
        [colorNavScrollView addSubview:colorBtn];
        [colorBtn addTarget:self action:@selector(colorBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        colorBtn.layer.cornerRadius = colorBtn.height/2.f;
    }
    
}


- (void)rightNavBtnEvent {
    if ([self.delegate respondsToSelector:@selector(drawViewControllerDidMadeImage:)]) {
        [self.delegate drawViewControllerDidMadeImage:[self.drawPaletteView screenshotWithQuality:1.f]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initView {
    self.title=@"画";
    self.rubberBtn.tag=0;
    curHexColor = colorArr[0];
    lastColor = curHexColor;
    curWidth =4;
    
    self.drawPaletteView.layer.masksToBounds = YES;
    self.drawPaletteView.backgroundColor = [UIColor whiteColor];
    self.bottomView.backgroundColor = [DrawPaletteView colorWithHexString:@"#DDDDDD"];
    
    float wwidth               = 32;
    chooseWidthView            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wwidth, wwidth*3+3*6)];
    chooseWidthView.centerX    = self.chooseWidthBtn.centerX;
    chooseWidthView.bottom     = self.view.bottom-self.bottomView.height;
    [self.view addSubview:chooseWidthView];
    changeWithViewDefaultFrame = chooseWidthView.frame;
    chooseWidthView.height     = 0;
    chooseWidthView.bottom     = self.view.bottom-self.bottomView.height;
    chooseWidthView.clipsToBounds=YES;
    for (int i=0;i<3;i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0+i*(6+wwidth), wwidth, wwidth)];
        btn.backgroundColor = [DrawPaletteView colorWithHexString:@"#D8D8D8"];
        btn.tag=2-i;
        [btn addTarget:self action:@selector(widthBtnEvent:) forControlEvents:UIControlEventTouchUpInside];

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8+btn.tag*4,  8+btn.tag*4)];
        view.backgroundColor        = [UIColor whiteColor];
        view.userInteractionEnabled = NO;
        view.centerX                = btn.width/2.f;
        view.centerY                = btn.height/2.f;
        view.layer.cornerRadius     = view.width/2.f;
        [btn addSubview:view];
        [chooseWidthView addSubview:btn];
        
    }
    
    [self selectWidth:1];
    
    
    UIButton *  rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.size = CGSizeMake(80, 30);
    rightNavBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightNavBtn setTitle:@"生成" forState:UIControlStateNormal];
    [rightNavBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightNavBtn addTarget:self
                    action:@selector(rightNavBtnEvent)
          forControlEvents:UIControlEventTouchUpInside];
    rightNavBtn.titleLabel.font = defaultFont(16);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:animated];
}


@end
