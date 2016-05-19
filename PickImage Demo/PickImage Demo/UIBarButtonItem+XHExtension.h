//
//  UIBarButtonItem+XHExtension.h

//  Created by Soso on 16/3/30.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XHExtension)


//设置UIBarButtonItem图片 与点击事件
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


@end
