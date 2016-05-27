//
//  XHAsset.m
//  PickImage Demo
//
//  Created by Soso on 16/5/27.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import "XHAsset.h"

@implementation XHAsset
- (instancetype)initWithAsset:(ALAsset *)asset {
    if (self = [super init]) {
        _asset = asset;
        _isSelected = NO;
    }
    
    return self;
}


+ (instancetype)assetWithAsset:(ALAsset *)asset {
    return [[XHAsset alloc] initWithAsset:asset];
}

@end
