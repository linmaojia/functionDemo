//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZCustomPhotoTitleTableCell.h"
#import <Photos/Photos.h>
@interface LZCustomPhotoTitleTableCell()

@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UILabel *titleLab;

@end
@implementation LZCustomPhotoTitleTableCell
#pragma mark ************** 懒加载控件

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = systemFont(16);
        _titleLab.text = @"查看详情";
    }
    return _titleLab;
}
- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"gougou"];
        [_leftImg setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _leftImg;
}

#pragma mark ************** 设置cell 内容
- (void)setModel:(LZPhotoModel *)model
{
    
    PHAssetCollection *assetCollection = model.PHAssetCollection;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    _titleLab.text = [NSString stringWithFormat:@"%@ (%ld)",assetCollection.localizedTitle,assets.count];
    
    if(model.isSelect == YES)
    {
        _leftImg.hidden = NO;
    }
    else
    {
        _leftImg.hidden = YES;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor =  [UIColor colorWithHexColorString:@"f9f9f9"];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubviewsForCell];
        
        [self addConstraintsForCell];

    }
    return self;
}

#pragma mark **************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.leftImg];
  
    [self.contentView addSubview:self.titleLab];

}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.width.equalTo(@(30));
    }];
   
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(_leftImg.left).offset(20);
    }];
}
@end
