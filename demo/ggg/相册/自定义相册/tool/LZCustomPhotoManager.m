//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZCustomPhotoManager.h"
#import <Photos/Photos.h>
@interface LZCustomPhotoManager ()
@property (nonatomic,strong) NSMutableArray * deviceAlumDataArr;


@end
@implementation LZCustomPhotoManager

- (NSMutableArray *)getAlumDataArr
{
    /*        相册配置  使用默认即可         */
    PHFetchOptions *fetchOptions = [PHFetchOptions new];
    
    /*        初始化相册数组         */
    _deviceAlumDataArr = [NSMutableArray array];
    
    /* 获取系统创建的相册 */
    PHFetchResult *smartAlbumFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:fetchOptions];
    
    /*        遍历系统创建相册结果集         */
    for (PHAssetCollection *sub in smartAlbumFetchResult) {
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:sub options:nil];
        
        if (result.count==0) {
            continue;
        }
        
        /*        添加具体相册到相册数组         */
        [_deviceAlumDataArr addObject:sub];
        
    }
    
    /*        获取所有的用户创建相册         */
    PHFetchResult *smartAlbumFetchResult2 = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:nil];
    
    /*        遍历用户自建相册结果集         */
    for (PHAssetCollection *sub in smartAlbumFetchResult2) {
        
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:sub options:nil];
        
        if (result.count==0) {
            continue;
        }
        /*        添加具体相册到相册数组         */
        [_deviceAlumDataArr addObject:sub];
        
    }
   
    return _deviceAlumDataArr;
}




- (NSMutableArray *)getAllPhotoArr
{
    
     _deviceAlumDataArr = [NSMutableArray array];
    
     _assetNameArr = [NSMutableArray array];

    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    
    NSDictionary *dic = @{@"PHAssetCollection":cameraRoll,@"isSelect":@(YES)};
    
    [_assetNameArr addObject:dic];
    
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections)
    {
        
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        
        if (assets.count==0)//判断如果为空则不添加
        {
            continue;
        }
        
        NSDictionary *dic = @{@"PHAssetCollection":assetCollection,@"isSelect":@(NO)};
        
        [_assetNameArr addObject:dic];
        
        [_deviceAlumDataArr addObjectsFromArray:[self enumerateAssetsInAssetCollection:assetCollection]];
    }
    
    // 遍历相机胶卷,获取大图
    [_deviceAlumDataArr addObjectsFromArray:[self enumerateAssetsInAssetCollection:cameraRoll]];

    return _deviceAlumDataArr;
}

/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (NSMutableArray *)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    NSMutableArray *imageArray = [NSMutableArray array];
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets)
    {
        
       [imageArray addObject:asset];

    }
    return imageArray;
}
/*

    // 是否要原图
    CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;

     // 从asset中获得图片
     [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {

         [imageArray addObject:result];

     }];
 */
@end
