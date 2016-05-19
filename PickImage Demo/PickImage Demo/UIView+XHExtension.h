//
//  UIView+XHExtension.h

//  Created by Soso on 16/3/30.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XHExtension)


//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/
@property (nonatomic,assign)CGFloat x;

@property (nonatomic,assign)CGFloat y;

@property (nonatomic,assign)CGFloat width;

@property (nonatomic,assign)CGFloat height;

@property (nonatomic,assign)CGSize size;

@end
