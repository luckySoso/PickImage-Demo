//
//  UIBarButtonItem+XHExtension.m

//  Created by Soso on 16/3/30.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import "UIBarButtonItem+XHExtension.h"

@implementation UIBarButtonItem (XHExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    //button.size = button.currentBackgroundImage.size;
    
    button.frame = CGRectMake(0, 0, 30, 30);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
