//
//  PublicPageViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

typedef enum _chooseType{
    
    titleType = 0,//标题类型
    detailType    //内容类型
    
} chooseType;

#import "PublicPageViewController.h"
#import "HX_AddPhotoView.h"
#import <Photos/Photos.h>
#import "HX_AssetManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PublicPageResultVC.h"
#import "AddSheetViewController.h"


#define VERSION [[UIDevice currentDevice].systemVersion doubleValue]

@interface PublicPageViewController ()<UITextViewDelegate,HX_AddPhotoViewDelegate>
//标题输入框
@property (nonatomic, strong) UITextView *titieTextLab;
//内容输入框
@property (nonatomic, strong) UITextView *detailTextView;
//选择文章标签按钮
@property (weak, nonatomic) IBOutlet UIButton *chooseMenuBtn;
//图片区
@property (weak, nonatomic) IBOutlet UIView *picView;
//最底部区域
@property (weak, nonatomic) IBOutlet UIView *chooseView;
//选择哪个编辑框的类型
@property (nonatomic, assign) chooseType choosetype;
//图片选择器view
@property (nonatomic, strong) HX_AddPhotoView *addPhotoView;
//是否正在编辑中
@property (nonatomic, assign) BOOL isEditor;
//图片数组
@property (nonatomic, strong) NSMutableArray *imageArr;
//标签数组
@property (nonatomic, strong) NSMutableArray *labelArr;



@end

@implementation PublicPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArr = [[NSMutableArray alloc] init];
    self.labelArr = [[NSMutableArray alloc] init];
    
   //添加ui控件
    [self addUi];
    
    [self.view bringSubviewToFront:self.chooseView];
    
    //为监听键盘高度添加两个观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}
 
#pragma mark - UI -

//添加ui控件
-(void)addUi{
    
    //输入标题框
    self.titieTextLab = [[UITextView alloc] init];
    if (kDevice_Is_iPhoneX) {
        self.titieTextLab.frame = CGRectMake(17, 99, kScreen_Width-17, 46);
    }else{
        self.titieTextLab.frame = CGRectMake(17, 75, kScreen_Width-17, 46);
    }
    
    [self.view addSubview:self.titieTextLab];
    self.titieTextLab.text = @"请输入文章标题";
    self.titieTextLab.font = [UIFont systemFontOfSize:13];
    self.titieTextLab.textColor = RGB(191, 191, 191);
    //输入内容框
    self.detailTextView = [[UITextView alloc] init];
    if (kDevice_Is_iPhoneX) {
        self.detailTextView.frame = CGRectMake(17, 141, kScreen_Width-17, kScreen_Height-173-130);
    }else{
        self.detailTextView.frame = CGRectMake(17, 117, kScreen_Width-17, kScreen_Height-115-130);
    }
    
    [self.view addSubview:self.detailTextView];
    self.detailTextView.text = @"请输入文章内容";
    self.detailTextView.font = [UIFont systemFontOfSize:13];
    self.detailTextView.textColor = RGB(191, 191, 191);
    //设置代理
    self.titieTextLab.delegate = self;
    self.detailTextView.delegate = self;
    //设置标题框和内容框中间的分割线
    
    UIView *view = [[UIView alloc] init];
    if (kDevice_Is_iPhoneX) {
        view.frame = CGRectMake(22, 137, kScreen_Width-17, 0.5);
    }else{
        view.frame = CGRectMake(22, 113, kScreen_Width-17, 0.5);
    }
    view.backgroundColor = RGB(232, 232, 232);
    [self.view addSubview:view];
    
    //添加图片选择器视图
    if (self.addPhotoView != nil) {
        [self.picView addSubview:self.addPhotoView];
    }
    //进来默认隐藏图片选择器
    self.picView.hidden = YES;
    //不可投稿状态
    self.isEditor = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"文章投稿"];
}
-(BOOL)hideNavigationBottomLine{
    return NO;
}
//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{

    self.addPhotoView = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

//右侧按钮设置点击
-(UIButton *)set_rightButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(kScreen_Width-44, 0, 44, 60);
    [btn setTitle:@"投稿" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(191, 191, 191) forState:UIControlStateNormal];
    
    return btn;
}

//投稿按钮点击方法
-(void)right_button_event:(UIButton *)sender{
    
    if (self.isEditor) {
        
        UserInfoModel *user = [UserInfoModel shareUserModel];
        [user loadUserInfoFromSanbox];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        NSString *articleClass = [self.labelArr componentsJoinedByString:@","];

        __weak typeof(self) weakSelf = self;
        
        [MBProgressHUD showMessage:@"正在上传，请稍后"];
        
        //如果有图片
        if (self.imageArr.count > 0) {
            
            for (int i = 0; i<self.imageArr.count; i++) {
                NSData *data = UIImagePNGRepresentation(self.imageArr[i]);
                
                [[HttpRequest shardWebUtil] uploadImageWithUrl:[BaseUrl stringByAppendingString:@"upload?type=1"]
                                                    WithParams:nil
                                                         image:data
                                                      filename:@"6"
                                                      mimeType:@"png"
                                                    completion:^(id dic) {
                                                        
                                                        if ([dic[@"code"] isEqualToString:SucceedCoder]) {
                                                            
                                                            [arr addObject:dic[@"data"][@"complete_url"]];
                                                            
                                                            //上传完左右照片,提交投稿
                                                            if (i == weakSelf.imageArr.count-1) {
                                                                //发送投稿请求
                                                                [weakSelf postPageWithUid:user.userid articleClass:articleClass articleImg:arr];
                                                                
                                                            }
                                                            
                                                        }else{
                                                            [MBProgressHUD hideHUD];
                                                        }

                                                    }
                                                    errorBlock:^(NSError *error) {
                                                        [MBProgressHUD hideHUD];
                                                        
                                                    }];
                
            }
        }else{
            //没图片
            [weakSelf postPageWithUid:user.userid articleClass:articleClass articleImg:arr];
        }

    }else{
        
    }
}

//发送投稿请求
-(void)postPageWithUid:(NSString *)uid
          articleClass:(NSString *)articleclass
            articleImg:(NSMutableArray *)articleimg{
    NSDictionary *dic = @{
                          @"userid":uid,
                          @"articleTitle":self.titieTextLab.text,
                          @"articleContent":self.detailTextView.text,
                          @"articleType":@"文章",
                          @"articleClass":articleclass,
                          @"articleImg":articleimg,
                          };
    
    
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_article"] parameters:dic success:^(id obj) {
        
        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
            [MBProgressHUD hideHUD];
            //跳转到提交结果界面
            PublicPageResultVC *publicPageRusult = [[PublicPageResultVC alloc] init];
            [self.navigationController pushViewController:publicPageRusult animated:YES];
            //假的占位,模拟提交成功
            publicPageRusult.isSucess = YES;
            
        }else{
            [MBProgressHUD hideHUD];
            //跳转到提交结果界面
            PublicPageResultVC *publicPageRusult = [[PublicPageResultVC alloc] init];
            [self.navigationController pushViewController:publicPageRusult animated:YES];
            //假的占位,模拟提交成功
            publicPageRusult.isSucess = NO;
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        //跳转到提交结果界面
        PublicPageResultVC *publicPageRusult = [[PublicPageResultVC alloc] init];
        [self.navigationController pushViewController:publicPageRusult animated:YES];
        //假的占位,模拟提交成功
        publicPageRusult.isSucess = NO;
    }];
}


-(UIColor*)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

#pragma mark - 按钮点击方法和私有方法 -
//选择图片按钮点击方法
- (IBAction)choosePicBtnClick:(UIButton *)sender {
    
    [self.titieTextLab resignFirstResponder];
    [self.detailTextView resignFirstResponder];
  
    NSNotification *notification =[NSNotification notificationWithName:@"XUANZETUPIAN" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];

}

//选择标签按钮点击方法
- (IBAction)chooseSheetBtnClick:(UIButton *)sender {
    AddSheetViewController *vc = [[AddSheetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    __weak typeof(self) weakSelf = self;
    vc.clossviewblock = ^(NSMutableArray *itemArray) {
        weakSelf.labelArr = itemArray;
        //回调返回的标签数组
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(CGRectGetWidth(weakSelf.chooseMenuBtn.frame)/2, -5, CGRectGetWidth(weakSelf.chooseMenuBtn.frame)/2, CGRectGetWidth(weakSelf.chooseMenuBtn.frame)/2);
        [btn setBackgroundColor:RGB(255, 81, 81)];
        [btn setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)itemArray.count] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setFont:[UIFont systemFontOfSize:9]];
        btn.layer.cornerRadius = btn.frame.size.width / 2;
        //将多余的部分切掉
        btn.layer.masksToBounds = YES;
        [weakSelf.chooseMenuBtn addSubview:btn];
    };
}

#pragma mark - textview代理方法 -
// 将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //开始编辑后判断是哪个输入框开始编辑
    if (textView == self.titieTextLab) {
        self.choosetype = titleType;
    }else{
        self.choosetype = detailType;
        if (kDevice_Is_iPhoneX) {
            self.detailTextView.frame = CGRectMake(17, 139, kScreen_Width-17, kScreen_Height-173-130-180 -39 -20 );
        }else{
            self.detailTextView.frame = CGRectMake(17, 115, kScreen_Width-17, kScreen_Height-115-130-180 -39 -20 );
        }
        
    }
    return YES;
}

// 开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView == self.titieTextLab) {
        if ([textView.text isEqualToString:@"请输入文章标题"]) {
            textView.text = @"";
            textView.textColor = RGB(51, 51, 51);
            textView.font = BOLDSYSTEMFONT(15);
        }
    }else{
        
        if ([textView.text isEqualToString:@"请输入文章内容"]) {
            textView.text = @"";
            textView.textColor = RGB(51, 51, 51);
            textView.font = [UIFont systemFontOfSize:14];
        }
    }
}

// 文本发生改变
- (void)textViewDidChange:(UITextView *)textView{
    if (![self.titieTextLab.text isEqualToString:@""] &&
        ![self.detailTextView.text isEqualToString:@""] &&
        ![self.titieTextLab.text isEqualToString:@"请输入文章标题"] &&
        ![self.detailTextView.text isEqualToString:@"请输入文章内容"])
    {
        self.isEditor = YES;
        [self.right_button setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];//右上角按钮变蓝色
        self.right_button.userInteractionEnabled = YES;
    }else{
        self.isEditor = NO;
        [self.right_button setTitleColor:RGB(191, 191, 191) forState:UIControlStateNormal];//右上角按钮变灰色
        self.right_button.userInteractionEnabled = YES;
    }
}

//暂时或永久结束编辑调用
- (void)textViewDidEndEditing:(UITextView *)textView{
    //结束编辑状态
//    self.isEditor = NO;
    
    if (textView == self.titieTextLab) {
        //标题截取20字符
        if (textView.text.length >= 20){
            textView.text = [textView.text substringToIndex:20];
            NSLog(@"标题最多输入20个字");
        }
        //如果什么都没有输入,结束编辑后默认还原
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"请输入文章标题";
            textView.textColor = RGB(191, 191, 191);
            textView.font = [UIFont systemFontOfSize:13];
        }
    }else{
        //如果什么都没有输入,结束编辑后默认还原
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"请输入文章内容";
            textView.textColor = RGB(191, 191, 191);
            textView.font = [UIFont systemFontOfSize:13];
        }
    }
}

// 文本将要改变
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

#pragma mark - 图片选择器代理方法 -
- (void)updateViewFrame:(CGRect)frame WithView:(UIView *)view
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat buttonY = CGRectGetMaxY(frame);
    
    button.frame = CGRectMake(0, buttonY, 100, 100);
    [self.view layoutSubviews];
}

#pragma mark - 监听键盘通知方法 -
-(void)keyboardWillAppear:(NSNotification *)notification
{
    
    NSDictionary *info = [notification userInfo];
    //取出动画时长
    CGFloat animationDuration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //取出键盘位置大小信息
    CGRect keyboardBounds = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //记录Y轴变化
    CGFloat keyboardHeight = keyboardBounds.size.height;
    //上移动画options
    UIViewAnimationOptions options = (UIViewAnimationOptions)[[info valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    
    
    [UIView animateKeyframesWithDuration:animationDuration delay:0 options:options animations:^{
        //根据选择的编辑框来决定键盘上的view上移距离
        if (self.choosetype == titleType) {
            self.chooseView.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
        }else{
            self.chooseView.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);

        }
        

    } completion:nil];
}


-(void)keyboardWillDisappear:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    //取出动画时长
    CGFloat animationDuration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //下移动画options
    UIViewAnimationOptions options = (UIViewAnimationOptions)[[info valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    //回复动画
    [UIView animateKeyframesWithDuration:animationDuration delay:0 options:options animations:^{

        self.chooseView.transform = CGAffineTransformIdentity;
        if (kDevice_Is_iPhoneX) {
            self.detailTextView.frame = CGRectMake(17, 139, kScreen_Width-17, kScreen_Height-173-130-34);
        }else{
            self.detailTextView.frame = CGRectMake(17, 115, kScreen_Width-17, kScreen_Height-115-130-34);
        }
        

    } completion:nil];
    
}

#pragma mark - 懒加载控件 -
-(HX_AddPhotoView *)addPhotoView{
    if (!_addPhotoView) {
        // 只选择照片
        _addPhotoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:5 WithSelectType:SelectPhoto];
        
        // 每行最大个数  不设置默认为4
        _addPhotoView.lineNum = 5;
        
        // collectionView 距离顶部的距离  底部与顶部一样  不设置,默认为0
        _addPhotoView.margin_Top = 5;
        
        // 距离左边的距离  右边与左边一样  不设置,默认为0
        _addPhotoView.margin_Left = 10;
        
        // 每个item间隔的距离  如果最小不能小于5   不设置,默认为5
        _addPhotoView.lineSpacing = 5;
        
        // 录制视频时最大多少秒   默认为60;
        _addPhotoView.videoMaximumDuration = 60.f;
        
        // 自定义相册的名称 - 不设置默认为自定义相册
        _addPhotoView.customName = @"无影灯下";
        
        _addPhotoView.delegate = self;
        _addPhotoView.backgroundColor = [UIColor whiteColor];
        _addPhotoView.frame = CGRectMake(0, 0, kScreen_Width, CGRectGetHeight(self.picView.frame));
//        [self.picView addSubview:self.addPhotoView];
        /**  当前选择的个数  */
        _addPhotoView.selectNum;
        __weak typeof(self) weakSelf = self;
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        [_addPhotoView setSelectPhotos:^(NSArray *photos, NSArray *videoFileNames, BOOL iforiginal) {

            [arr removeAllObjects];
            if (photos.count == 0) {
                [arr removeAllObjects];
                [weakSelf.imageArr removeAllObjects];
                NSLog(@"%ld",weakSelf.imageArr.count);
            }

            
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
                        
                        [arr addObject:image];
                        weakSelf.imageArr = arr;
                        
                        // image为高清图时
                        if (![info objectForKey:PHImageResultIsDegradedKey]) {
                            
                            
                        }
                    }];
                }
                
            }];
        }];
    }
    return _addPhotoView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//注销通知用
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
