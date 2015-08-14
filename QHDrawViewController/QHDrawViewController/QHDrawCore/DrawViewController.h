//
//  DrawViewController.h
//  lovewith
//
//  Created by imqiuhang on 15/4/22.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawPaletteView.h"

@protocol DrawViewControllerDelegate <NSObject>

@optional
- (void)drawViewControllerDidMadeImage:(UIImage *)image;

@end

@interface DrawViewController : UIViewController

@property (weak, nonatomic) IBOutlet DrawPaletteView *drawPaletteView;
@property (weak, nonatomic) IBOutlet UIButton        *rubberBtn;
@property (weak, nonatomic) IBOutlet UIButton        *cleanBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *chooseWidthBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeColorBtn;

@property (nonatomic,weak)id<DrawViewControllerDelegate>delegate;

@property BOOL isFromJoin;

@end
