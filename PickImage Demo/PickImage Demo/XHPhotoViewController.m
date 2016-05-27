//
//  XHPhotoViewController.m
//  PickImage Demo
//
//  Created by Soso on 16/5/19.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import "XHPhotoViewController.h"
#import "XHPhotoCollectionViewCell.h"

#define ITEM_MARGIN 2
#define EDGE_MARGIN 10

#define LINE_ITEM_NUMBER 4


static NSString *const photoCVCellReuseID = @"photoCVCellReuseID";

@interface XHPhotoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,XHPhotoCollectionViewCellDelegate>
/*!
 @brief  显示group的所有照片的collectionView
 */
@property (nonatomic, weak) UICollectionView *photosCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/*!
 @brief  相簿中的所有照片Asset集合
 */
@property (nonatomic, strong) NSArray *assetArray;
/*!
 @brief  底部照片操作的toolBar
 */
@property (nonatomic, strong) UIView *actionToolbar;
/*!
 @brief  '预览'按钮
 */
@property (nonatomic, strong) UIButton *preViewBtn;
/*!
 @brief  '完成'按钮
 */
@property (nonatomic, strong) UIButton *doneBtn;
/*!
 @brief  选择信息标签
 */
@property (nonatomic, strong) UILabel *selectedInfoLabel;
/*!
 @brief  已经选中的Asset集合
 */
@property (nonatomic, strong) NSMutableArray *selectedAssetArrayM;
/*!
 @brief  可以选择的最大照片数
 */
@property (nonatomic, assign) NSInteger maxSelectedNo;

@end

@implementation XHPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    
    [self setupToolbar];
    
    [self.photosCollectionView registerClass:[XHPhotoCollectionViewCell class] forCellWithReuseIdentifier:photoCVCellReuseID];
}

- (void)setNav{
    self.navigationItem.title = @"相机照片";
    self.maxSelectedNo = 5;
    self.view.backgroundColor = [UIColor whiteColor];
    
  

}

- (void)setupToolbar {
    
    //下方选择的照片数label
    _selectedInfoLabel = [[UILabel alloc] init];
    CGFloat chooseInfoLabelW = 100;
    CGFloat chooseInfoLabelH = 44;
    CGFloat chooseInfoLabelX = (KSCREENWIDTH - chooseInfoLabelW) * 0.5;
    CGFloat chooseInfoLabelY = 0;
    _selectedInfoLabel.frame = CGRectMake(chooseInfoLabelX, chooseInfoLabelY, chooseInfoLabelW, chooseInfoLabelH);
    
    [self updateActionToolbarInfo]; // 设置初始显示为 0/最大选择数
    _selectedInfoLabel.textColor = [UIColor blackColor];
    _selectedInfoLabel.textAlignment = NSTextAlignmentCenter;
    [self.actionToolbar addSubview:_selectedInfoLabel];//底部照片操作的toolBar
    
    //预览按钮
    _preViewBtn = [self creatActionBtnWithX:EDGE_MARGIN title:@"预览" action:@selector(previewBtnClicked:)];
    
    //完成按钮
    CGFloat doneBtnX = KSCREENWIDTH - EDGE_MARGIN - _preViewBtn.frame.size.width;
 
    _doneBtn = [self creatActionBtnWithX:doneBtnX title:@"完成" action:@selector(doneBtnClicked:)];
}
#pragma mark - collection datesource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XHPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCVCellReuseID
                                                                                forIndexPath:indexPath];
    
    cell.photoCellDelegate = self;
    
    cell.asset = self.assetArray[indexPath.row];
    
    return cell;
}


//添加预览完成按钮 尺寸
- (UIButton *)creatActionBtnWithX:(CGFloat)x title:(NSString *)title action:(SEL)action {
    
    CGFloat preViewBtnX = x;
    CGFloat preViewBtnY = 0;
    CGFloat preViewBtnW = 60;
    CGFloat preViewBtnH = 44;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(preViewBtnX, preViewBtnY, preViewBtnW, preViewBtnH)];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setEnabled:NO];
    
   
    [self.actionToolbar addSubview:btn];
    
    return btn;
}


/*!
 @brief  更新ActionToolbar中按钮的状态
 */
- (void)updateActionToolbarInfo {
    
    self.selectedInfoLabel.text = [NSString stringWithFormat:@"(%zd/%zd)", self.selectedAssetArrayM.count, self.maxSelectedNo];
    _selectedInfoLabel.textColor = (self.selectedAssetArrayM.count == self.maxSelectedNo) ? [UIColor redColor] : [UIColor blackColor];
    _preViewBtn.enabled = self.selectedAssetArrayM.count ? YES : NO;
    _doneBtn.enabled = self.selectedAssetArrayM.count ? YES : NO;
}


#pragma mark - 按钮的action
- (void)previewBtnClicked:(UIButton *)previewBtn {
    
//    YSPhotoBrowserViewController *photoBrowserVC = [[YSPhotoBrowserViewController alloc] init];
//    photoBrowserVC.assetsArray = self.selectedAssetArrayM.copy;
//    photoBrowserVC.maxSelectedNo = self.maxSelectedNo;
//    
//    __weak typeof(self) weakSelf = self;
//    photoBrowserVC.photoBrowserVCHandler = ^(NSArray *assetArray){
//        [weakSelf handleData:assetArray];
//    };
//    
//    [self showViewController:photoBrowserVC sender:nil];
}


- (void)doneBtnClicked:(UIButton *)previewBtn {
    NSLog(@"%s", __func__);
    
    if (self.photoVCHandler) {
        self.photoVCHandler(self.selectedAssetArrayM.copy);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - lazy loading

- (UICollectionView *)photosCollectionView {
    if (!_photosCollectionView) {
        CGFloat x = 0;
        CGFloat y = 64;
        CGFloat w = KSCREENWIDTH;
        CGFloat h = KSCREENHEIGHT - y - self.actionToolbar.bounds.size.height;
        UICollectionView *photosCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(x, y, w, h) collectionViewLayout:self.flowLayout];
        
        photosCollectionView.dataSource = self;
        photosCollectionView.delegate = self;
        photosCollectionView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:photosCollectionView];
        
        _photosCollectionView = photosCollectionView;
    }
    
    return _photosCollectionView;
}


- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat itemWH = (KSCREENWIDTH - ITEM_MARGIN * (LINE_ITEM_NUMBER + 1)) / LINE_ITEM_NUMBER;
        _flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
        _flowLayout.minimumLineSpacing = ITEM_MARGIN;
        _flowLayout.minimumInteritemSpacing = ITEM_MARGIN;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    
    return _flowLayout;
}






#pragma mark 懒加载
- (NSArray *)assetArray {
    if (!_assetArray) {
        _assetArray = [NSArray array];
    }
    
    return _assetArray;
}


- (NSMutableArray *)selectedAssetArrayM {
    if (!_selectedAssetArrayM) {
        _selectedAssetArrayM = [NSMutableArray array];
    }
    
    return _selectedAssetArrayM;
}


- (UIView *)actionToolbar {
    if (!_actionToolbar) {
        _actionToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                                     KSCREENHEIGHT - 44,
                                                                     KSCREENWIDTH,
                                                                     44)];
        _actionToolbar.backgroundColor = [UIColor redColor];
        [self.view addSubview:_actionToolbar];
    }
    
    return _actionToolbar;
}



@end
