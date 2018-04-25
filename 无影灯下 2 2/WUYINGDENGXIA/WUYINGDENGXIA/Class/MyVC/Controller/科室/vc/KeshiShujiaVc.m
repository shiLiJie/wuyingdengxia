//
//  KeshiShujiaVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/12.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "KeshiShujiaVc.h"
#import "shujiaCollectionCell.h"
#import "ZZNewsSheetMenu1.h"

@interface KeshiShujiaVc ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *keshiName;//科室名称
@property (weak, nonatomic) IBOutlet UIImageView *userImage;//用户头像
@property (weak, nonatomic) IBOutlet UIButton *userNameBtn;//用户名,用的按钮
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;//更多按钮
@property (weak, nonatomic) IBOutlet UIButton *user1;//科室人员1
@property (weak, nonatomic) IBOutlet UIButton *user2;//科室人员2
@property (weak, nonatomic) IBOutlet UIButton *user3;//科室人员3
@property (weak, nonatomic) IBOutlet UILabel *shujiaNum;//书架内容个数
@property (weak, nonatomic) IBOutlet UICollectionView *shujiaCollectionview;//书架内容collectionview
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

@implementation KeshiShujiaVc

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUi];
}

#pragma mark - UI -
-(void)setUpUi{
    //前11空格,后4空格
    [self.userNameBtn setTitle:@"           666    " forState:UIControlStateNormal];
    //切圆角
    self.userNameBtn.layer.cornerRadius = CGRectGetHeight(self.userNameBtn.frame)/2;//半径大小
    self.userNameBtn.layer.masksToBounds = YES;//是否切割
    self.moreBtn.layer.cornerRadius = CGRectGetHeight(self.moreBtn.frame)/2;//半径大小
    self.moreBtn.layer.masksToBounds = YES;//是否切割
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置CollectionView的属性
    self.shujiaCollectionview.collectionViewLayout = flowLayout;
    self.shujiaCollectionview.delegate = self;
    self.shujiaCollectionview.dataSource = self;
    self.shujiaCollectionview.showsVerticalScrollIndicator = NO;
    self.shujiaCollectionview.showsHorizontalScrollIndicator = NO;
    //注册Cell
    [self.shujiaCollectionview registerNib:[UINib nibWithNibName:NSStringFromClass([shujiaCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"科室书架"];
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
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
    shujiaCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    return cell;
}
//#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(130,42);
}
//#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    return UIEdgeInsetsMake(0, 0, (self.medals.count / 3 - 2) * DeviceSize.width / 3, 0);//（上、左、下、右）
    return UIEdgeInsetsMake(0, 0, 0, 0);//（上、左、下、右）
}
//#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    MyLiwuDetailVc *pageDetail = [[MyLiwuDetailVc alloc] init];
//    [self.navigationController pushViewController:pageDetail animated:YES];
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
