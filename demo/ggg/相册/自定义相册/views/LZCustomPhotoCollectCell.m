

#import "LZCustomPhotoCollectCell.h"

@interface LZCustomPhotoCollectCell ()

@property (nonatomic, strong) UIImageView *productImg;     /**< 品牌图片 */

@end

@implementation LZCustomPhotoCollectCell
#pragma mark ************** 懒加载控件
- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        _productImg.image = [UIImage imageNamed:@"logo_del_pro"];
        [_productImg setContentMode:UIViewContentModeScaleAspectFill];
        _productImg.clipsToBounds=YES;
    }
    return _productImg;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubviewsForCell];
        
        [self addConstraintsForCell];
    }
    return self;
}

- (void)setAsset:(PHAsset *)asset
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
   
    options.synchronous = YES; // 同步获得图片, 只会返回1张图片
    
    CGSize size =  CGSizeMake(150, 150);
    
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
       
        _productImg.image = result;
        
    }];
}


#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.productImg];

}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
   
}



@end
