//
//  YZGMyCollectProduductFootView.m
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZCustomPhotoCollectView.h"
#import "LZCustomPhotoCollectCell.h"
@interface LZCustomPhotoCollectView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation LZCustomPhotoCollectView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        
        self.backgroundColor = [UIColor blackColor];

        self.delegate = self;
        
        self.dataSource = self;
        
        [self registerClass:[LZCustomPhotoCollectCell class] forCellWithReuseIdentifier:NSStringFromClass([self class])];//注册cell
        
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    _dataArray = (NSMutableArray *)[[_dataArray reverseObjectEnumerator] allObjects];
    
    [self reloadData];
}
#pragma mark ************** CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
      LZCustomPhotoCollectCell *cell = (LZCustomPhotoCollectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
      cell.asset = _dataArray[indexPath.item];
      return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PHAsset *asset = _dataArray[indexPath.item];

    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES; // 同步获得图片, 只会返回1张图片
    CGSize size =  CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if(result.size.width == asset.pixelWidth )
        {
            if(self.cellClickBlack)
            {
                self.cellClickBlack(result);
            }
        }
        
     
    }];

    
    
}

@end
