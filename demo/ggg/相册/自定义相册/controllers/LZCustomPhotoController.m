//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZCustomPhotoController.h"
#import "LZCustomPhotoManager.h"
#import "LZCustomPhotoCollectView.h"
#import "LZCustomPhotoTitleBgView.h"
#import "LZCustomPhotoTitleView.h"
#import "LZPhotoModel.h"
#import <Photos/Photos.h>
@interface LZCustomPhotoController ()
@property (nonatomic, strong) LZCustomPhotoManager *manager;
@property (nonatomic, strong) NSMutableArray * deviceAlumDataArr;//所有相片数组
@property (nonatomic, strong) NSMutableArray * deviceAlumNameArr;//所有相片集数组
@property (nonatomic, strong) LZCustomPhotoCollectView *collectionView;
@property (nonatomic, strong) LZCustomPhotoTitleView *titleView;//导航栏标题
@property (nonatomic, strong) LZCustomPhotoTitleBgView *titleBgView;
@property (nonatomic, strong) UIButton *cameraBtn;

@end

@implementation LZCustomPhotoController

#pragma mark ************** 懒加载控件
- (UIButton *)cameraBtn {
    if (!_cameraBtn) {
        
        _cameraBtn = [[UIButton alloc]init];
        [_cameraBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
        _cameraBtn.backgroundColor = mainColor;
        [_cameraBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_cameraBtn addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchDown];
        
    }
    return _cameraBtn;
}

- (LZCustomPhotoTitleView *)titleView {
    if (!_titleView) {
        ESWeakSelf;
        _titleView = [[LZCustomPhotoTitleView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleView.titleClickBlack = ^(BOOL flag){
            [__weakSelf showTitleTableViewWithFlag:flag];
        };

    }
    return _titleView;
}
- (LZCustomPhotoCollectView *)collectionView
{
    if (!_collectionView)
    {
        ESWeakSelf;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        layout.minimumInteritemSpacing = 2; //列与列之间的间距
        layout.minimumLineSpacing = 2;//行与行之间的间距
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-4)/3, (SCREEN_WIDTH-4)/3);//cell的大小
        
        _collectionView = [[LZCustomPhotoCollectView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.cellClickBlack = ^(UIImage *image){
            
            [__weakSelf.navigationController popViewControllerAnimated:YES];
            if(__weakSelf.selectImgBlock)
                __weakSelf.selectImgBlock(image);
            
        };
    }
    return _collectionView;
}
- (LZCustomPhotoManager *)manager {
    if (!_manager) {
        _manager = [[LZCustomPhotoManager alloc]init];
    }
    return _manager;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    [self getData];
   
    
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.titleView =self.titleView;
}
#pragma mark ************** 获取数据
- (void)getData
{
    self.deviceAlumDataArr = [self.manager getAllPhotoArr];//所有图片数组
}
- (void)setDeviceAlumDataArr:(NSMutableArray *)deviceAlumDataArr
{
    _deviceAlumDataArr = deviceAlumDataArr;
    
    self.collectionView.dataArray = deviceAlumDataArr;//赋值
    
    //转模型
    _deviceAlumNameArr = [NSMutableArray array];
    
    for (NSDictionary *dict in self.manager.assetNameArr)
    {
        if (dict != nil)
        {
            [_deviceAlumNameArr addObject:[LZPhotoModel productListModelWithDict:dict]];
        }
    }
    
    LZPhotoModel *model = _deviceAlumNameArr[0];

    PHAssetCollection *assetCollection = model.PHAssetCollection;

    self.titleView.titleLab.text = assetCollection.localizedTitle;//设置标题
    
}
#pragma mark ************** 是否打开相片集名称视图
- (void)showTitleTableViewWithFlag:(BOOL )flag
{
    if(flag == YES)
    {
        ESWeakSelf;
        _titleBgView = [[LZCustomPhotoTitleBgView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        
        _titleBgView.dataArray = _deviceAlumNameArr;
        
        _titleBgView.cellClickBlack = ^(NSInteger index){
            [__weakSelf reloadCollectionView:index];
        };
        _titleBgView.bgClickBlack = ^(){
            [__weakSelf.titleView showImgAnimations];
            
        };
        [self.view insertSubview:_titleBgView atIndex:1];
    }
    else
    {
        [_titleBgView dismissTableView];
    }
    
}
#pragma mark ************** 刷新内容
- (void)reloadCollectionView:(NSInteger)index
{
    
    LZPhotoModel *model = _deviceAlumNameArr[index];
    // 获得某个相簿中的所有PHAsset对象
    NSMutableArray *arr = [NSMutableArray array];
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:model.PHAssetCollection options:nil];
    for (PHAsset *asset in assets)
    {
        [arr addObject:asset];
    }
    self.collectionView.dataArray = arr;
    
    self.titleView.photoName = model.PHAssetCollection.localizedTitle;//标题切换

}
#pragma mark ************** 跳转到拍照页面
- (void)cameraBtnClick
{
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.cameraBtn];

    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(50));
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(_cameraBtn.top);
    }];
   
}
@end
