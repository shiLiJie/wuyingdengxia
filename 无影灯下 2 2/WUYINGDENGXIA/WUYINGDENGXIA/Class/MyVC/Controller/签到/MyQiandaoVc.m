//
//  MyQiandaoVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyQiandaoVc.h"
#import "MyLiwuCell.h"
#import "MyLiwuDetailVc.h"

@interface MyQiandaoVc ()<UICollectionViewDataSource,UICollectionViewDelegate>
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
//签到view
@property (weak, nonatomic) IBOutlet UIView *qiandaoView;
//签到btn
@property (weak, nonatomic) IBOutlet UIButton *qiandaoBtn;
//签到状态
@property (nonatomic, assign) BOOL isQiandao;
//礼物列表
@property (weak, nonatomic) IBOutlet UICollectionView *liwuCollectionView;

@end

@implementation MyQiandaoVc

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    [super viewWillAppear:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    
    //设置礼物列表
    [self setCollection];
    //切圆角
    [self setCornerRadiu];
}

#pragma mark - UI -
//设置礼物列表
-(void)setCollection{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置CollectionView的属性
    self.liwuCollectionView.collectionViewLayout = flowLayout;
    self.liwuCollectionView.delegate = self;
    self.liwuCollectionView.dataSource = self;
    self.liwuCollectionView.scrollEnabled = YES;
    //注册Cell
    [self.liwuCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyLiwuCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

//切圆角
-(void)setCornerRadiu{
    self.qiandaoView.layer.cornerRadius = 10;//半径大小
    self.qiandaoView.layer.masksToBounds = YES;//是否切割
    
    self.qiandaoBtn.layer.cornerRadius = CGRectGetHeight(self.qiandaoBtn.frame)/2;//半径大小
    self.qiandaoBtn.layer.masksToBounds = YES;//是否切割
}

#pragma mark - 私有方法 -
//返回
- (IBAction)comeback:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//签到
- (IBAction)qiandaoClick:(UIButton *)sender {
}

#pragma mark  - CollectionView -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
//#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    MyLiwuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];

    return cell;
}
//#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(kScreen_Width * 0.44,(kScreen_Height * 0.28));
}
//#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    return UIEdgeInsetsMake(0, 0, (self.medals.count / 3 - 2) * DeviceSize.width / 3, 0);//（上、左、下、右）
    return UIEdgeInsetsMake(0, 10, 0, 10);//（上、左、下、右）
}
//#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyLiwuDetailVc *pageDetail = [[MyLiwuDetailVc alloc] init];
    [self.navigationController pushViewController:pageDetail animated:YES];
}
//#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
