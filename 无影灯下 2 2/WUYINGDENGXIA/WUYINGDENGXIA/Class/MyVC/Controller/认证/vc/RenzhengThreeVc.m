//
//  RenzhengThreeVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "RenzhengThreeVc.h"
#import "RenzhengResultVc.h"
#import "HX_AddPhotoView.h"
#import <Photos/Photos.h>
#import "HX_AssetManager.h"

#define VERSION [[UIDevice currentDevice].systemVersion doubleValue]

@interface RenzhengThreeVc ()<HX_AddPhotoViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *ziliaoLab;
@property (weak, nonatomic) IBOutlet UILabel *shenfenzhengLab;
@property (weak, nonatomic) IBOutlet UILabel *tupianLab;
@property (weak, nonatomic) IBOutlet UILabel *careLab;

@property (weak, nonatomic) IBOutlet UIView *picView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *upBtn;

//图片选择器view
@property (nonatomic, strong) HX_AddPhotoView *addPhotoView;

@end

@implementation RenzhengThreeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nextBtn.layer.cornerRadius = CGRectGetHeight(self.nextBtn.frame)/2;//半径大小
    self.nextBtn.layer.masksToBounds = YES;//是否切割
    self.upBtn.layer.cornerRadius = CGRectGetHeight(self.nextBtn.frame)/2;//半径大小
    self.upBtn.layer.masksToBounds = YES;//是否切割
    
    if (kDevice_Is_iPhone5) {
        self.ziliaoLab.font = [UIFont systemFontOfSize:13];
        self.shenfenzhengLab.font = [UIFont systemFontOfSize:13];
        self.tupianLab.font = [UIFont systemFontOfSize:13];
    }
    if (kDevice_Is_iPhone4) {
        self.ziliaoLab.font = [UIFont systemFontOfSize:13];
        self.shenfenzhengLab.font = [UIFont systemFontOfSize:13];
        self.tupianLab.font = [UIFont systemFontOfSize:13];
    }
    
    [self.picView addSubview:self.addPhotoView];
    
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"资料认证"];
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

#pragma mark - 私有方法 -
//下一步
- (IBAction)nextStep:(UIButton *)sender {
    RenzhengResultVc *vc = [[RenzhengResultVc alloc]
                            init];
    [self.navigationController pushViewController:vc animated:YES];
}
//上一步
- (IBAction)upStep:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 图片选择器代理方法 -
- (void)updateViewFrame:(CGRect)frame WithView:(UIView *)view
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat buttonY = CGRectGetMaxY(frame);
    
    button.frame = CGRectMake(0, buttonY, 100, 100);
    [self.view layoutSubviews];
}

#pragma mark - 懒加载控件 -
-(HX_AddPhotoView *)addPhotoView{
    if (!_addPhotoView) {
        // 只选择照片
        _addPhotoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:3 WithSelectType:SelectPhoto];
        
        // 每行最大个数  不设置默认为4
        _addPhotoView.lineNum = 3;
        
        // collectionView 距离顶部的距离  底部与顶部一样  不设置,默认为0
        _addPhotoView.margin_Top = 0;
        
        // 距离左边的距离  右边与左边一样  不设置,默认为0
        _addPhotoView.margin_Left = 0;
        
        // 每个item间隔的距离  如果最小不能小于5   不设置,默认为5
        _addPhotoView.lineSpacing = 2;
        
        // 录制视频时最大多少秒   默认为60;
        _addPhotoView.videoMaximumDuration = 60.f;
        
        // 自定义相册的名称 - 不设置默认为自定义相册
        _addPhotoView.customName = @"无影灯下";
        
        _addPhotoView.delegate = self;
        _addPhotoView.backgroundColor = [UIColor whiteColor];
        _addPhotoView.frame = CGRectMake(0, 0, CGRectGetWidth(self.picView.frame), CGRectGetHeight(self.picView.frame));
        //        [self.picView addSubview:self.addPhotoView];
        /**  当前选择的个数  */
        _addPhotoView.selectNum;
        __weak typeof(self) weakSelf = self;
        
        [_addPhotoView setSelectPhotos:^(NSArray *photos, NSArray *videoFileNames, BOOL iforiginal) {
            
            //选择图片后展示图片视图
            weakSelf.picView.hidden = NO;
            
            [photos enumerateObjectsUsingBlock:^(id asset, NSUInteger idx, BOOL * _Nonnull stop) {
                
                // ios8.0 以下返回的是ALAsset对象 以上是PHAsset对象
                if (VERSION < 8.0f) {
                    //                ALAsset *oneAsset = (ALAsset *)asset;
                    // 缩略图
                    // UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
                    // 原图
                    // CGImageRef fullImage = [[asset defaultRepresentation] fullResolutionImage];
                    // url
                    // NSURL *url = [[asset defaultRepresentation] url];
                }else {
                    PHAsset *twoAsset = (PHAsset *)asset;
                    
                    CGFloat scale = [UIScreen mainScreen].scale;
                    
                    // 根据输入的大小来控制返回的图片质量
                    CGSize size = CGSizeMake(300 * scale, 300 * scale);
                    [[HX_AssetManager sharedManager] accessToImageAccordingToTheAsset:twoAsset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
                        // image为高清图时
                        if (![info objectForKey:PHImageResultIsDegradedKey]) {
                            // 高清图
                            //                        image;
                            //
                            //                        NSLog(@"%@",image);
                        }
                    }];
                }
                
            }];
        }];
    }
    return _addPhotoView;
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
