//
//  QHDefine.h
//  QHTableViewProfile
//
//  Created by imqiuhang on 15/8/12.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#ifndef QHTableViewProfile_QHDefine_h
#define QHTableViewProfile_QHDefine_h


#define QHRGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define QHRGBA(r, g, b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]

#define defaultFont(s) [UIFont fontWithName:@"STHeitiSC-Light" size:s]

#define QHKEY_WINDOW      [[UIApplication sharedApplication] keyWindow]
#define QHScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define QHScreenHeight    [[UIScreen mainScreen] bounds].size.height

#define QHIOS_VERSION     [[[UIDevice currentDevice] systemVersion] floatValue]

#ifdef DEBUG
#define QHLog(fmt,...) NSLog((@"\n\n[行号]%d\n" "[函数名]%s\n" "[日志]"fmt"\n"),__LINE__,__FUNCTION__,##__VA_ARGS__);
#else
#define QHLog(fmt,...);
#endif




#endif
