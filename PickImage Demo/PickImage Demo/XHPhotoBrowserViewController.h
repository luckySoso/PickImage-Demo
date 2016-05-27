//
//  XHPhotoBrowserViewController.h
//  PickImage Demo
//
//  Created by Soso on 16/5/22.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PhotoBrowserVCHandler)(NSArray *assetArray);

@interface XHPhotoBrowserViewController : UIViewController

/*!
 @brief  显示照片的集合
 */
//@property (nonatomic, strong) NSArray *photosArray;
/*!
 @brief  asset实例集合
 */
@property (nonatomic, strong) NSArray *assetsArray;
/*!
 @brief  可以选择的最大照片数
 */
@property (nonatomic, assign) NSInteger maxSelectedNo;
/*!
 @brief  当前显示的索引
 */
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
/*!
 @brief  返回按钮数据回调
 */
@property (nonatomic, copy) PhotoBrowserVCHandler photoBrowserVCHandler;

@end
