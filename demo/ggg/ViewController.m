//
//  ViewController.m
//  ggg
//
//  Created by LXY on 16/8/3.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "ViewController.h"
#import "YZGPicController.h"
#import "KViewController.h"
@interface ViewController ()
{
    NSMutableArray *buttonArray;    /**< 按钮数组 */
    NSMutableArray *buttonArray1;    /**< 按钮数组 */
}
@property (nonatomic, strong) UIView *bottomView;    /**< 底部视图 */
@property (nonatomic, strong) UIView *bottomView1;    /**< 底部视图 */

@end

@implementation ViewController


- (UIView *)bottomView{
    
    if(!_bottomView){
        
        buttonArray = [NSMutableArray new];//使用数组约束
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        NSArray *array = [NSArray arrayWithObjects:@"相册",@"订单列表",@"收货地址管理",@"收藏页面",@"物流地址管理",@"支付成功",@"退款详情",@"订单列表按钮",@"我的收藏" ,@"商品详情",nil];
        for(int i=0;i<array.count;i++){
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button.backgroundColor = RGB(238, 91, 40);
            [button setTitleColor:[UIColor whiteColor] forState:0];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.titleLabel.font= boldSystemFont(15);
            button.tag=100+i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:button];
            [buttonArray addObject:button];
            
        }
        
        
    }
    return _bottomView;
}
- (UIView *)bottomView1{
    
    if(!_bottomView1){
        
        buttonArray1 = [NSMutableArray new];//使用数组约束
        _bottomView1 = [[UIView alloc]init];
        _bottomView1.backgroundColor = [UIColor whiteColor];
        NSArray *array = [NSArray arrayWithObjects:@"kkk",@"同类推荐",@"商品列表",@"搜索页面",@"排行榜",@"分类",@"首页",@"客服",@"微博图片" ,@"商品详情",nil];
        for(int i=0;i<array.count;i++){
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button.backgroundColor = RGB(238, 91, 40);
            [button setTitleColor:[UIColor whiteColor] forState:0];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.titleLabel.font= boldSystemFont(15);
            button.tag=200+i;
            [button addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView1 addSubview:button];
            [buttonArray1 addObject:button];
            
        }
        
        
    }
    return _bottomView1;
}
#pragma mark ************************* 监听button方法
-(void)buttonAction1:(UIButton *)sender{
    switch (sender.tag) {
        case 200:
        {
            KViewController *vc = [[KViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

  
        default:
            break;
    }
    
    
    
}




#pragma mark ************************* 监听button方法
-(void)buttonAction:(UIButton *)sender{
    switch (sender.tag) {
        case 100:{
            YZGPicController *vc = [[YZGPicController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
      
     
        default:
            break;
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.bottomView];
    
    [_bottomView makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.top.bottom.equalTo(self.view);
    }];
    
    //平均分配 水平
    
    [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:5 leadSpacing:5 tailSpacing:5];
    [buttonArray makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.left.equalTo(self.bottomView);
    }];
    
    
    
    
    [self.view addSubview:self.bottomView1];
    
    [_bottomView1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.left.equalTo(_bottomView.right).offset(20);
        make.top.bottom.equalTo(self.view);
    }];
    
    //平均分配 水平
    
    [buttonArray1 mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:5 leadSpacing:5 tailSpacing:5];
    [buttonArray1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.left.equalTo(self.bottomView1);
    }];

}

@end
