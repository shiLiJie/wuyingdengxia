//
//  AddSheetViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "AddSheetViewController.h"
#import "IQKeyboardManager.h"
#import "SearchSheetLabVc.h"
#import "lableModel2.h"

@interface AddSheetViewController ()<UITextFieldDelegate>
//确定按钮
@property (weak, nonatomic) IBOutlet UIButton *sueBtn;
//自定义标签textfield
@property (weak, nonatomic) IBOutlet UITextField *addSheetTextfield;
//存放自定义标签的数组
@property (nonatomic, strong) NSMutableArray *customLabArr;

@property (nonatomic, assign) BOOL isAddLab;


@end

@implementation AddSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isAddLab = NO;

    self.customLabArr = [[NSMutableArray alloc] init];
    
    //输入框设置代理
    self.addSheetTextfield.delegate = self;
    
    //输入框切圆角
    self.addSheetTextfield.layer.cornerRadius = self.addSheetTextfield.frame.size.height / 2;
    self.addSheetTextfield.layer.masksToBounds = YES;
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(50,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    self.addSheetTextfield.leftView = leftView;
    self.addSheetTextfield.leftViewMode = UITextFieldViewModeAlways;
    self.addSheetTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //添加标签视图
    [self addSheetUi];
    //监听自定义标签文本输入
    [self addTargetMethod];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isAddLab = NO;
    [self.newsMenu layoutSubviews];
}


-(void)viewWillDisappear:(BOOL)animated{
    if (self.isAddLab) {
        return;
    }
    //取消标签选择
    [self.newsMenu dismissNewsMenu];
//    [IQKeyboardManager sharedManager].enable = YES;
    
}

#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"添加标签"];
}
-(BOOL)hideNavigationBottomLine{
    return NO;
}
//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"cha1") forState:UIControlStateNormal];
    return btn;
}
//左上返回按钮
-(void)left_button_event:(UIButton *)sender{
    [self.newsMenu dismissNewsMenu];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//添加标签视图
-(void)addSheetUi{
    //初始化
    ZZNewsSheetMenu *sheetMenu = [ZZNewsSheetMenu newsSheetMenu1];
    self.newsMenu = sheetMenu;
    self.newsMenu.pageOrqa = self.pageOrqu;
    sheetMenu.mySubjectArray = self.allLabArr;
    sheetMenu.recommendSubjectArray = @[@"体育",@"军事",@"音乐",@"电影",@"中国风",@"摇滚",@"小说",@"梦想",@"机器",@"电脑"].mutableCopy;
    sheetMenu.choosetype = postType;
    //设置视图界面,从新设置的时候 recommendSubjectArray 数组从新定义,然后在调用次方法
    [self.newsMenu updateNewSheetConfig:^(ZZNewsSheetConfig *cofig) {
        cofig.sheetItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 35);
    }];
    
    [self.view addSubview:self.newsMenu];
    //配置界面内容
    self.newsMenu.closeMenuButton.hidden = YES;
    self.newsMenu.editMenuButton.frame = CGRectMake(kScreen_Width - 70, 0,50, 30);
//    self.newsMenu.myTitleLab1.text = @"已选标签";
//    self.newsMenu.recommentTitleLab.text = @"推荐标签";
    
    __weak typeof(self) weakSelf = self;
    //回调编辑好的兴趣标签
    [self.newsMenu updataItmeArray:^(NSMutableArray *itemArray) {
        if (weakSelf.clossviewblock != nil) {
            weakSelf.clossviewblock(itemArray);
            weakSelf.allLabArr = itemArray;
        }
    }];
    
    //点击搜索按钮的回调
    [self.newsMenu setSearchBlock:^{
        SearchSheetLabVc *vc = [[SearchSheetLabVc alloc] init];
        weakSelf.isAddLab = YES;
        //搜索结束后回调过来的数组
        vc.dismissviewBlock = ^(NSMutableArray *itemArray) {
            NSMutableArray *larr = [[NSMutableArray alloc] init];
            larr = weakSelf.newsMenu.mySubjectArray;
            if (!kObjectIsEmpty(itemArray)) {
                lableModel2 *model = [[lableModel2 alloc] init];
                for (model in itemArray) {
                    [larr addObject:model.label_name];
                }
                weakSelf.newsMenu.mySubjectArray = larr;
                [weakSelf.newsMenu layoutSubviews];
            }
        };
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
       
    }];
    
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_labels_rand?limit=10&type=%@",self.pageOrqu]]
                                                 parameters:nil
                                                    success:^(id obj) {
                                                        
                                                        NSMutableArray *labArr = [[NSMutableArray alloc] init];
                                                        NSArray *arr = obj[@"data"];
                                                        NSDictionary *dict = @{
                                                                               @"label_name":@""
                                                                               };
                                                        for (dict in arr) {
                                                            [labArr addObject:dict[@"label_name"]];
                                                        }
                                                        weakSelf.newsMenu.recommendSubjectArray = labArr;
                                                        [weakSelf.newsMenu layoutSubviews];

                                                    }
                                                       fail:^(NSError *error) {
                                                           
                                                       }];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [sheetMenu addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - 私有方法 -
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.addSheetTextfield resignFirstResponder];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}


/**
 自定义标签点击确定按钮

 @param sender sender description
 */
- (IBAction)sureBtnClick:(UIButton *)sender {

    if (!kStringIsEmpty(self.addSheetTextfield.text)) {
        
        [self.customLabArr addObject:self.addSheetTextfield.text];
        
        [self.newsMenu.mySubjectArray addObject:self.addSheetTextfield.text];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ADDLABEL" object:self.addSheetTextfield.text];
        

        
//        UserInfoModel *user = [UserInfoModel shareUserModel];
//        [user loadUserInfoFromSanbox];
//        
//        [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"add_user_label?type=0&userid=%@&to_id=%@&label_name=%@",user.userid,]] parameters:nil success:^(id obj) {
//            
//        } fail:^(NSError *error) {
//            
//        }];
        
        
        [self.addSheetTextfield resignFirstResponder];
        self.addSheetTextfield.text = @"";
        [self textField1TextChange:self.addSheetTextfield];
    }
}

#pragma mark - 输入框代理方法 -
-(void)addTargetMethod{
    [self.addSheetTextfield addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
}
-(void)textField1TextChange:(UITextField *)textField{
//    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    if (textField.text.length) {
        self.sueBtn.userInteractionEnabled = YES;
        [self.sueBtn setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];
    }else{
        self.sueBtn.userInteractionEnabled = NO;
        [self.sueBtn setTitleColor:RGB(185, 185, 185) forState:UIControlStateNormal];
    }
}
//根据输入内容变换确认按钮颜色和可用性
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if ([textField.text isEqualToString:@""]) {
//        self.sueBtn.userInteractionEnabled = NO;
//        [self.sueBtn setTitleColor:RGB(185, 185, 185) forState:UIControlStateNormal];
//    }else{
//        self.sueBtn.userInteractionEnabled = YES;
//        [self.sueBtn setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];
//    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.addSheetTextfield resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    
    
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
