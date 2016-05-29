//
//  XHAlbumListViewController.m
//  PickImage Demo
//
//  Created by Soso on 16/5/19.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import "XHAlbumListViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "XHAlbumListViewCell.h"
#import "XHPhotoViewController.h"
#import "XHAsset.h"

#define KSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
static NSString *const albumCellReuseID = @"albumCellReuseID";

@interface XHAlbumListViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ALAssetsLibrary *assetslibrary;
@property (nonatomic, strong) NSMutableArray *albumArrayM;
@property (nonatomic, strong) NSMutableArray *photosArrayM;

/**tableView*/
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation XHAlbumListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    //设置Nav
    [self setNav];
    
    //拿相册数据
    [self getAssetsGroupData];
    
    //创建tableview
    [self createTableView];
}


- (void)setNav{
    self.navigationItem.title = @"相簿";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"back_btn_normal" highImage:nil target:self action:@selector(back)];

}

- (void)back{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)createTableView{

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[XHAlbumListViewCell class] forCellReuseIdentifier:albumCellReuseID];
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
    

}


- (void)getAssetsGroupData {
    
    __weak typeof(self) weakSelf = self;
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    NSBlockOperation *enumOp = [NSBlockOperation blockOperationWithBlock:^{
        
        

        
        [self.assetslibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            
            if (group) {
                
                //[weakSelf.albumArrayM insertObject:group atIndex:0];
                [weakSelf.albumArrayM addObject:group];
                
                NSLog(@"获取到的相簿名：%@", [group valueForProperty:ALAssetsGroupPropertyName]);
            }
            
        } failureBlock:^(NSError *error) {
            NSLog(@"获取相簿失败：%@", error);
        }];
    }];
    
    NSBlockOperation *reloadOp = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf.tableView reloadData];
    }];
    
    [reloadOp addDependency:enumOp];
    [queue addOperation:enumOp];
    [queue addOperation:reloadOp];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.albumArrayM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALAssetsGroup *group = self.albumArrayM[indexPath.row];
    
    XHAlbumListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:albumCellReuseID forIndexPath:indexPath];
    cell.group = group;
    
    return cell;
}



#pragma mark - Table view delegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //点击相册跳转到photoViewController
    ALAssetsGroup *group = self.albumArrayM[indexPath.row];
    
    XHPhotoViewController *photoVC = [[XHPhotoViewController alloc] init];
    
    photoVC.group = group;
    
    photoVC.photoVCHandler = ^(NSArray *selectedImgsArray){
        NSLog(@"%@------", selectedImgsArray);
        
        
        for ( NSInteger i = 0; i<selectedImgsArray.count; i++) {
            
            XHAsset *asset = selectedImgsArray[i];
       
            // 使用asset来获取本地图片
            ALAssetRepresentation *assetRep = [asset.asset defaultRepresentation];
            CGImageRef imgRef = [assetRep fullResolutionImage];
            UIImage *image = [UIImage imageWithCGImage:imgRef
                                                      scale:1.0
                                                orientation:UIImageOrientationUp];
            NSLog(@"%@",NSStringFromCGSize(image.size));
            
            NSData *data=UIImageJPEGRepresentation(image, 1.0);
            NSLog(@"....%ld",data.length/1024);
            
        }
        
        
        
        
    };
    
    [self.navigationController pushViewController:photoVC animated:YES];
}


#pragma mark - lazy loading

- (ALAssetsLibrary *)assetslibrary {
    if (!_assetslibrary) {
        _assetslibrary = [[ALAssetsLibrary alloc] init];
    }
    
    return _assetslibrary;
}


- (NSMutableArray *)albumArrayM {
    if (!_albumArrayM) {
        _albumArrayM = [NSMutableArray array];
    }
    
    return _albumArrayM;
}


- (NSMutableArray *)photosArrayM {
    if (!_photosArrayM) {
        _photosArrayM = [NSMutableArray array];
    }
    
    return _photosArrayM;
}




@end
