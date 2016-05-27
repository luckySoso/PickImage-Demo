//
//  XHAsset.h
//  PickImage Demo
//
//  Created by Soso on 16/5/27.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAsset;
@interface XHAsset : NSObject

@property (nonatomic, strong) ALAsset *asset;
/*!
 @brief  是否已经被选择
 */
@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initWithAsset:(ALAsset *)asset;
+ (instancetype)assetWithAsset:(ALAsset *)asset;

@end
