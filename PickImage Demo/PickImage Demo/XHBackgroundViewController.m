//
//  ViewController.m
//  PickImage Demo
//
//  Created by Soso on 16/5/18.
//  Copyright © 2016年 Soso. All rights reserved.
//

#import "XHBackgroundViewController.h"
#import "SXPickPhoto.h"
#import "pickImageView.h"
#import "XHAlbumListViewController.h"
#import "XHNavigationController.h"
#import "TZImagePickerController.h"

#define KSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define margin  (KSCREENWIDTH - 4 * 60) / 5


/**
 *  这个 UIImageJPEGRepresentation(image, 0.0)，是1的功能。
    这个 [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)] 是2的功能。
 
 
 //    data 转成image
 //UIImage imageWithData:<#(NSData *)#>
 
 //    image(.PNG) 转成data
 //UIImagePNGRepresentation(<#UIImage *image#>)
 //    .jpg 转成data
 //参数2. 压缩系数,0 - 1.0
 NSData *dataOriginal = UIImageJPEGRepresentation(self.imageView.image, 1.0);
 NSData *dataEdited = UIImageJPEGRepresentation(self.imageView.image, 0.3);
 
 NSLog(@"%@",NSHomeDirectory());
 
 //把原始的图片保存到沙盒
 [dataOriginal writeToFile:[NSString stringWithFormat:@"%@/Library/1.jpg",NSHomeDirectory()] atomically:YES];
 
 //把编辑过的图片也保存进去 方便对比 (编辑了会压缩,压缩过后的图片所占外存更小,放大会模糊)
 [dataEdited writeToFile:[NSString stringWithFormat:@"%@/Library/2.jpg",NSHomeDirectory()] atomically:YES];
 
 
 */
static NSInteger i = 0;

@interface XHBackgroundViewController ()
{
    UIView *_backView;
    UIButton *_photoBtn;
    SXPickPhoto *_pickPhoto;
    NSInteger index;
    
}

@property (nonatomic,strong) NSMutableArray *photoArray;

@end

@implementation XHBackgroundViewController

- (NSMutableArray *)photoArray{

    if (_photoArray == nil) {
        _photoArray = [NSMutableArray array];
    }
    
    return _photoArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createBackView];
}

//创建背景view
- (void)createBackView{

    self.navigationItem.title = @"PickImage Demod";
    
    //背景view
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, KSCREENHEIGHT - 64)];
    _backView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview: _backView];
    
    //相机按钮
//    _photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin, 20, 60, 60)];
//    [_photoBtn setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
//    [_photoBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
//    //_photoBtn.backgroundColor = [UIColor redColor];
//    [_backView addSubview:_photoBtn];

    UIButton *photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin, 20, 60, 60)];
    [photoBtn setBackgroundImage:[UIImage imageNamed:@"photo.jpg"] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    [_backView addSubview:photoBtn];
    
    //相机对象
    _pickPhoto = [[SXPickPhoto alloc] init];

}





//选择
- (void)click{

    //[self methodOne];
    
    [self methodTwo];
    
    //[self methodThree];
}


- (void)methodThree{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
   

    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    // Set the appearance
    // 在这里设置imagePickerVc的外观
    //imagePickerVc.navigationBar.barTintColor = [UIColor whiteColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // Set allow picking video & photo & originalPhoto or not
    // 设置是否可以选择视频/图片/原图
    // imagePickerVc.allowPickingVideo = NO;
    // imagePickerVc.allowPickingImage = NO;
    // imagePickerVc.allowPickingOriginalPhoto = NO;
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];

}

#pragma mark method two
- (void)methodTwo{

    XHAlbumListViewController *album = [[XHAlbumListViewController alloc] init];
    XHNavigationController *nav = [[XHNavigationController alloc] initWithRootViewController:album];
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];

}


#pragma mark method one

-(void)methodOne{

    _pickPhoto = [[SXPickPhoto alloc] init];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_pickPhoto ShowTakePhotoWithController:self andWithBlock:^(NSObject *Data) {
            
            //拿到拍到的照片
            UIImage *image = (UIImage *)Data;
            //NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
            
            //存入系统相册
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
            [self addImage:image];
            
            
            
        }];
        
    }];
    
    
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_pickPhoto SHowLocalPhotoWithController:self andWithBlock:^(NSObject *Data) {
            
            //拿到手机系统相册的图片
            UIImage *image = (UIImage *)Data;
            NSData *dataOriginal = UIImageJPEGRepresentation(image, 1.0);
            
            
            //把原始的图片保存到沙盒
            [dataOriginal writeToFile:[NSString stringWithFormat:@"%@/Library/原始%ld.jpg",NSHomeDirectory(),i] atomically:YES];
            
            [self addImage:image];
        }];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    UIAlertController *alet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alet addAction:camera];
    [alet addAction:photo];
    [alet addAction:cancel];
    [self presentViewController:alet animated:YES completion:^{
        
    }];


}

- (void)addImage:(UIImage *)image{
    
   NSData * dataEdit = [self imageData:image];
    
    UIImage *editImg = [UIImage imageWithData:dataEdit];
    
    //把编辑的图片保存到沙盒
    NSString *filePath = [NSString stringWithFormat:@"%@/Library/编辑%ld.jpg",NSHomeDirectory(),i];
    [dataEdit writeToFile:filePath atomically:YES];
    //UIImageWriteToSavedPhotosAlbum(editImg, nil, nil, nil);
    
    
    pickImageView *imageView = [[pickImageView alloc] init];
    imageView.image = image;
    imageView.frame = _photoBtn.frame;
    imageView.userInteractionEnabled = YES;
    imageView.filePath = filePath;
    imageView.tag = i;
    [_backView addSubview:imageView];
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
    [imageView addGestureRecognizer:imageTap];
    
    
    
    _photoBtn.x = _photoBtn.x + imageView.width + margin;
    
    if ((KSCREENWIDTH - (_photoBtn.x + _photoBtn.width)) < margin) {
        
        _photoBtn.y = imageView.y + imageView.height + margin;
        _photoBtn.x = margin;
    }
    
   
    NSLog(@"edit------%ld",dataEdit.length/1024);
    
    [self.photoArray addObject:editImg];
    
    i++;
 
}

- (void)imageTap:(UITapGestureRecognizer *)tap{

    NSLog(@"%ld",self.photoArray.count);
    
//    //1.创建图片浏览器
//    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
//    
//    //2.告诉图片浏览器显示所有的图片
//    NSMutableArray *photos = [NSMutableArray array];
//    
//    for (int i = 0 ; i < self.photoArray.count; i++) {
//        
//        UIImage *pic = self.photoArray[i];
//        
//        //传递数据给浏览器
//        MJPhoto *photo = [[MJPhoto alloc] init];
////        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
////        photo.srcImageView = self.subviews[i]; //设置来源哪一个UIImageView
//        photo.image = pic;
//        
//        [photos addObject:photo];
//    }
//    brower.photos = photos;
//    
//    //3.设置默认显示的图片索引
//    brower.currentPhotoIndex = tap.view.tag;
//    
//    //4.显示浏览器
//    [brower show];
//    
// 
    
    

}


//压缩图像
- (NSData *)imageData:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    
    if (data.length>100*1024) {
        
        
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
            
        }else if (data.length>512*1024) {//0.5M-1M
            
            data=UIImageJPEGRepresentation(myimage, 0.5);
            
        }else if (data.length>200*1024) {//0.25M-0.5M
            
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size{

    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



@end
