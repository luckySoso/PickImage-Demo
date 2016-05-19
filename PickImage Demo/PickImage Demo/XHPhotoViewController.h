//
//  XHPhotoViewController.h
//  PickImage Demo
//
//  Created by Soso on 16/5/19.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAssetsGroup;

typedef void(^PhotoVCHandler)(NSArray *selectedImgsArray);

@interface XHPhotoViewController : UIViewController


@property (nonatomic, strong) ALAssetsGroup *group;

@property (nonatomic, copy) PhotoVCHandler photoVCHandler;
@end
