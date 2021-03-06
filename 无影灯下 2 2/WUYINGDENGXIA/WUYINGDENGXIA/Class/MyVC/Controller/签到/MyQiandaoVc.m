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
#import "LiwuModel.h"

@interface MyQiandaoVc ()<UICollectionViewDataSource,UICollectionViewDelegate>
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
//月亮币lab
@property (weak, nonatomic) IBOutlet UILabel *yueliangbiLab;
//签到view
@property (weak, nonatomic) IBOutlet UIView *qiandaoView;
//签到btn
@property (weak, nonatomic) IBOutlet UIButton *qiandaoBtn;
//签到状态
@property (nonatomic, assign) BOOL isQiandao;
//礼物列表
@property (weak, nonatomic) IBOutlet UICollectionView *liwuCollectionView;
//礼物模型数组
@property (nonatomic, strong) NSArray *liwuAar;


@end

@implementation MyQiandaoVc

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    [super viewWillAppear:nil];
    
    //刷新UI
    [self uploadUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    
    self.liwuAar = [[NSArray alloc] init];
    
    //设置礼物列表
    [self setCollection];
    //切圆角
    [self setCornerRadiu];
    //获取礼物列表
    [self getLiwuList];
}
//刷新UI
-(void)uploadUI{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (user.loginStatus) {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:user.headimg] placeholderImage:GetImage(@"tx")];
        self.yueliangbiLab.text = user.moon_cash !=nil ? user.moon_cash : @"0";
        __weak typeof(self) weakSelf = self;
        [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_singdata?userid=%@",user.userid]]
                                                    parameters:nil
                                                       success:^(id obj) {
                                                           
                                                           
                                                           NSDictionary *dict = obj[@"data"];
                                                           if ([[NSString stringWithFormat:@"%@",dict[@"isSign"]] isEqualToString:@"1"]) {
                                                               [weakSelf.qiandaoBtn setTitle:@"已签到" forState:UIControlStateNormal];
                                                           }
                                                       } fail:^(NSError *error) {
                                                           
                                                       }];
        
    }else{
        self.headImage.image = GetImage(@"tx");
        self.yueliangbiLab.text = @"0";
    }
    
    
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
    
    self.headImage.layer.cornerRadius = CGRectGetHeight(self.headImage.frame)/2;;//半径大小
    self.headImage.layer.masksToBounds = YES;//是否切割
}

#pragma mark - 私有方法 -
//获取礼物列表
-(void)getLiwuList{
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:@"get_allgoods"]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       
                                                       NSArray *arr = obj[@"data"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[LiwuModel LiwuModelWithDict:dict]];
                                                           
                                                           [self.liwuCollectionView reloadData];
                                                       }
                                                       self.liwuAar= arrayM;
    } fail:^(NSError *error) {
        
    }];
}

//返回
- (IBAction)comeback:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//签到
- (IBAction)qiandaoClick:(UIButton *)sender {
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (user.loginStatus) {
        NSDictionary *dict = @{
                               @"userid":user.userid,
                               @"type":@"1",
                               @"toid":@"0"
                               };
        
        [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_sign"]
                                                     parameters:dict
                                                        success:^(id obj) {
                                                            if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                                //签到成功添加五个月亮币
                                                                [MBProgressHUD showSuccess:obj[@"msg"]];
                                                                user.moon_cash = [NSString stringWithFormat:@"%ld",[user.moon_cash integerValue] + 5];
                                                                [user saveUserInfoToSanbox];
                                                                [self.qiandaoBtn setTitle:@"已签到" forState:UIControlStateNormal];
                                                                [self uploadUI];
                                                            }else{
                                                                if ([obj[@"msg"] isEqualToString:@"今天你已经签过到了"]) {
                                                                    [self.qiandaoBtn setTitle:@"已签到" forState:UIControlStateNormal];
                                                                    [self uploadUI];
                                                                }
                                                                [MBProgressHUD showOneSecond:obj[@"msg"]];
                                                            }
                                                        } fail:^(NSError *error) {
                                                            
                                                        }];
    }else{
        LoginVc *loginVc = [LoginVc loginControllerWithBlock:^(BOOL result, NSString *message) {
            
        }];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
    
}

#pragma mark  - CollectionView -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.liwuAar.count;
    
}
//#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    MyLiwuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    LiwuModel *model = self.liwuAar[indexPath.row];
    [cell.liwuImage sd_setImageWithURL:[NSURL URLWithString:model.goods_img] placeholderImage:GetImage(@"")];
    cell.liwuName.text = model.goods_name;
    cell.liwuJiage.text = model.moon_cash;

    return cell;
}
//#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (kDevice_Is_iPhoneX) {
        return  CGSizeMake(kScreen_Width * 0.46,(kScreen_Height * 0.23));
    }else{
        return  CGSizeMake(kScreen_Width * 0.46,(kScreen_Height * 0.28));
    }
    
}
//#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    return UIEdgeInsetsMake(0, kScreen_Width *0.03, 0, kScreen_Width *0.03);
    return UIEdgeInsetsMake(0, 5, 0, 5);
}
//#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyLiwuDetailVc *vc = [[MyLiwuDetailVc alloc] init];
    vc.liwumodel = [[LiwuModel alloc] init];
    vc.liwumodel = self.liwuAar[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
