//
//  XHAlbumListViewCell.h
//  PickImage Demo
//
//  Created by Soso on 16/5/19.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ALAssetsGroup;

@interface XHAlbumListViewCell : UITableViewCell

/*!
 @brief  cell的group
 */
@property (nonatomic, strong) ALAssetsGroup *group;

@end
