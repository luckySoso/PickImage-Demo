//
//  XHPhotoCollectionViewCell.h
//  PickImage Demo
//
//  Created by Soso on 16/5/27.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHAsset;
@class XHPhotoCollectionViewCell;

@protocol XHPhotoCollectionViewCellDelegate <NSObject>

- (void)photoCollectionViewCell:(XHPhotoCollectionViewCell *)cell clickCheckBtn:(UIButton *)checkBtn;

@end

@interface XHPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) XHAsset *asset;

@property (nonatomic, weak) id<XHPhotoCollectionViewCellDelegate> photoCellDelegate;

@end
