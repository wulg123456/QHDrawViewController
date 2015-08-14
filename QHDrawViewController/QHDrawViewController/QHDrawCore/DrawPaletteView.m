//
//  Palette.m
//  lovewith
//
//  Created by imqiuhang on 15/4/22.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import "DrawPaletteView.h"
#import "UIView+QHUIViewCtg.h"
@implementation DrawPaletteView

@synthesize x;
@synthesize y;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
	
}

- (void)awakeFromNib {
    myallline=[[NSMutableArray alloc] initWithCapacity:10];
    myallColor=[[NSMutableArray alloc] initWithCapacity:10];
    myallwidth=[[NSMutableArray alloc] initWithCapacity:10];

}

- (void)drawRect:(CGRect)rect  {
	//获取上下文
	CGContextRef context=UIGraphicsGetCurrentContext();
	//设置笔冒
	CGContextSetLineCap(context, kCGLineCapRound);
	//设置画线的连接处　拐点圆滑
	CGContextSetLineJoin(context, kCGLineJoinRound);
	//画之前线

    
    //画自己的
	if (myallline.count>0) {
		for (int i=0; i<[myallline count]; i++) {
			NSArray* tempArray=[NSArray arrayWithArray:[myallline objectAtIndex:i]];

			if ([myallColor count]>0) {
                segmentColor= [DrawPaletteView colorWithHexString:myallColor[i]].CGColor;
                Intsegmentwidth=[[myallwidth objectAtIndex:i]floatValue]+1;
			}
			if ([tempArray count]>1) {
				CGContextBeginPath(context);
				CGPoint myStartPoint=[[tempArray objectAtIndex:0] CGPointValue];
				CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
				
				for (int j=0; j<[tempArray count]-1; j++) {
					CGPoint myEndPoint=[[tempArray objectAtIndex:j+1] CGPointValue];
					CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);	
				}
				CGContextSetStrokeColorWithColor(context, segmentColor);
				CGContextSetLineWidth(context, Intsegmentwidth);
				CGContextStrokePath(context);
			}
		}
	}
	//画当前的线
	if ([myallpoint count]>1) {
		CGContextBeginPath(context);
		//起点
		CGPoint myStartPoint=[[myallpoint objectAtIndex:0]   CGPointValue];
		CGContextMoveToPoint(context,    myStartPoint.x, myStartPoint.y);
		//把move的点全部加入　数组
		for (int i=0; i<[myallpoint count]-1; i++) {
			CGPoint myEndPoint=  [[myallpoint objectAtIndex:i+1] CGPointValue];
			CGContextAddLineToPoint(context, myEndPoint.x,   myEndPoint.y);
		}
		//在颜色和画笔大小数组里面取不相应的值
		segmentColor= [DrawPaletteView colorWithHexString:[myallColor lastObject]].CGColor;
		Intsegmentwidth=[[myallwidth lastObject]floatValue]+1;
		//绘制画笔颜色
		CGContextSetStrokeColorWithColor(context, segmentColor);
		CGContextSetFillColorWithColor (context,  segmentColor);
		//绘制画笔宽度
		CGContextSetLineWidth(context, Intsegmentwidth);
		//把数组里面的点全部画出来
		CGContextStrokePath(context);
	}
}

- (void)IntroductionpointInitPoint {
	myallpoint=[[NSMutableArray alloc] initWithCapacity:10];
}

//把画过的当前线放入　存放线的数组
-(void)IntroductionpointSavePoint {
	[myallline addObject:myallpoint];
}
-(void)IntroductionpointAddPoint:(CGPoint)sender {
	NSValue* pointvalue=[NSValue valueWithCGPoint:sender];
	[myallpoint addObject:pointvalue ];
}

- (void)IntroductionpointHexColor:(NSString *)color {
	[myallColor addObject:color];
}

- (void)IntroductionpointWidth:(int)sender {
	[myallwidth addObject:@(sender)];
}

- (void)myalllineclear {
	if ([myallline count]>0)  {
		[myallline removeAllObjects];
		[myallColor removeAllObjects];
		[myallwidth removeAllObjects];
		[myallpoint removeAllObjects];
		myallline=[[NSMutableArray alloc] initWithCapacity:10];
		myallColor=[[NSMutableArray alloc] initWithCapacity:10];
		myallwidth=[[NSMutableArray alloc] initWithCapacity:10];
		[self setNeedsDisplay];
	}
}

- (void)myLineFinallyRemove {
	if ([myallline count]>0) {
		[myallline  removeLastObject];
		[myallColor removeLastObject];
		[myallwidth removeLastObject];
		[myallpoint removeAllObjects];
    }
	[self setNeedsDisplay];
    if ([myallline count]<=0) {
    }
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (UIColor *) colorWithHexString: (NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1];
}




@end
