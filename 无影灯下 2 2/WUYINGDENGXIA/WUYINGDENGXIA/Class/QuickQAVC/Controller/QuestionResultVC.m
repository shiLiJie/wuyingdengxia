//
//  QuestionResultVC.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/8.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "QuestionResultVC.h"
#import "ZZHotKeysLayout.h"
#import "ZZCollectionViewCell.h"

static NSString * const kCellID = @"Cell";

@interface QuestionResultVC ()<UICollectionViewDelegate,UICollectionViewDataSource,
ZZHotKeysLayoutDelegate>
//Scroller
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
//顶部view
@property (weak, nonatomic) IBOutlet UIView *topView;
//底部view
@property (weak, nonatomic) IBOutlet UIView *bottomView;

//展开收起按钮
@property (weak, nonatomic) IBOutlet UIButton *zhankaiBtn;
//图片区view
@property (weak, nonatomic) IBOutlet UIView *picView;
//五个图片
@property (weak, nonatomic) IBOutlet UIImageView *pic1;
@property (weak, nonatomic) IBOutlet UIImageView *pic2;
@property (weak, nonatomic) IBOutlet UIImageView *pic3;
@property (weak, nonatomic) IBOutlet UIImageView *pic4;
@property (weak, nonatomic) IBOutlet UIImageView *pic5;
//标签视图
@property (weak, nonatomic) IBOutlet UICollectionView *sheetView;
@property(nonatomic,strong)ZZHotKeysLayout *hkLayout;
//标签区高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sheetViewHeight;
//图片区高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picViewHeight;
@end

@implementation QuestionResultVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.zhankaiBtn.layer.cornerRadius = CGRectGetHeight(self.zhankaiBtn.frame)/2;//半径大小
    self.zhankaiBtn.layer.masksToBounds = YES;//是否切割
    
    self.sheetView.scrollEnabled = NO;
    [self.sheetView setCollectionViewLayout:self.hkLayout];
    self.sheetView.delegate=self;
    self.sheetView.dataSource =self;
    
    [self.sheetView registerClass:[ZZCollectionViewCell class] forCellWithReuseIdentifier:kCellID];
    //监听contentsize变化
    [self.sheetView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    //给图片赋值
    [self setImageVIew];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    self.titleLab.text = self.title;
    self.detailLab.text = self.detail;
    [self.yueliangbiBtn setTitle:self.yueliang forState:UIControlStateNormal];
    self.scroller.contentSize =  CGSizeMake(0, CGRectGetMaxY(self.bottomView.frame));
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    self.sheetViewHeight.constant = self.sheetView.contentSize.height;
}

- (NSMutableArray *)hotKeys{
    if (_hotKeys == nil) {
        _hotKeys = [NSMutableArray array];
    }
    return _hotKeys;
}
- (ZZHotKeysLayout *)hkLayout{
    if (_hkLayout == nil) {
        _hkLayout = [[ZZHotKeysLayout alloc]init];
        _hkLayout.flowEdgeInset = UIEdgeInsetsMake(15, 0, 0, 0);
        _hkLayout.rowSpace = 15;
        _hkLayout.columSpace = 15;
        _hkLayout.delegate = self;
    }
    return _hkLayout;
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

//右上角分享
-(UIButton *)set_rightButton{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:GetImage(@"fenxiang") forState:UIControlStateNormal];
    return btn;
}

-(void)right_button_event:(UIButton *)sender{
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.hkLab.text = self.hotKeys[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.hotKeys.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)hotKeysLayout:(ZZHotKeysLayout *)layout indexPath:(NSIndexPath *)indexPath{
    NSString * hotKey = self.hotKeys[indexPath.item];
    return  [self stringSize:hotKey];
}

- (CGSize)stringSize:(NSString *)string{
    if (string.length == 0) return CGSizeZero;
    UIFont * font = [UIFont systemFontOfSize:14];
    CGFloat yOffset = 3.0f;
    CGFloat width = [UIScreen mainScreen].bounds.size.width -  self.hkLayout.flowEdgeInset.left - self.hkLayout.flowEdgeInset.right;
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGSize size = CGSizeMake(MIN(contentSize.width + 20,width) , MAX(22, contentSize.height + 2 * yOffset + 1));
    return size;
}

#pragma mark - 私有方法 -
//展开或者收起内容按钮点击方法
- (IBAction)zhankaiOrshouqi:(UIButton *)sender {
    if (self.detailLab.numberOfLines == 2) {
        self.detailLab.numberOfLines = 0;
    }else{
        self.detailLab.numberOfLines = 2;
    }
    [self.scroller layoutIfNeeded];
    [self.view layoutIfNeeded];
    self.scroller.contentSize =  CGSizeMake(0, CGRectGetMaxY(self.bottomView.frame));
}

//给图片赋值
-(void)setImageVIew{
    if (self.imageArr.count==1) {
        UIImage *image = self.imageArr[0];
        self.pic1.image = image;
        self.picViewHeight.constant = 66;
    }
    if (self.imageArr.count==2) {
        UIImage *image = self.imageArr[0];
        self.pic1.image = image;
        UIImage *image1 = self.imageArr[1];
        self.pic2.image = image1;
        self.picViewHeight.constant = 66;
    }
    if (self.imageArr.count==3) {
        UIImage *image = self.imageArr[0];
        self.pic1.image = image;
        UIImage *image1 = self.imageArr[1];
        self.pic2.image = image1;
        UIImage *image2 = self.imageArr[2];
        self.pic3.image = image2;
        self.picViewHeight.constant = 66;
    }
    if (self.imageArr.count==4) {
        UIImage *image = self.imageArr[0];
        self.pic1.image = image;
        UIImage *image1 = self.imageArr[1];
        self.pic2.image = image1;
        UIImage *image2 = self.imageArr[2];
        self.pic3.image = image2;
        UIImage *image3 = self.imageArr[3];
        self.pic4.image = image3;
        self.picViewHeight.constant = 66;
    }
    if (self.imageArr.count==5) {
        UIImage *image = self.imageArr[0];
        self.pic1.image = image;
        UIImage *image1 = self.imageArr[1];
        self.pic2.image = image1;
        UIImage *image2 = self.imageArr[2];
        self.pic3.image = image2;
        UIImage *image3 = self.imageArr[3];
        self.pic4.image = image3;
        UIImage *image4 = self.imageArr[4];
        self.pic5.image = image4;
        self.picViewHeight.constant = 66;
    }else{
        self.picViewHeight.constant = 1;

    }
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
