//
//  ViewController.m
//  QHDrawViewController
//
//  Created by imqiuhang on 15/8/14.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "ViewController.h"
#import "DrawViewController.h"
@interface ViewController ()<DrawViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)push:(id)sender {
    DrawViewController *drawVC =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DrawViewController"];
    drawVC.isFromJoin=YES;
    drawVC.delegate=self;
    [self.navigationController pushViewController:drawVC animated:YES];
}

- (void)drawViewControllerDidMadeImage:(UIImage *)image {
    self.drawImage.image = image;
}

@end
