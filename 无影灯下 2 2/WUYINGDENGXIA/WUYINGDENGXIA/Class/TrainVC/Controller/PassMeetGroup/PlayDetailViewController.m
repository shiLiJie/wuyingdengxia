//
//  PlayDetailViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/12.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PlayDetailViewController.h"
#import "inputView.h"
#import "IQKeyboardManager.h"


@interface PlayDetailViewController ()<inputViewDelegate>
//输入框
@property (nonatomic, strong) inputView *input;

@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;

@property (nonatomic,copy) NSString *inputStr;

@end

@implementation PlayDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pinglunBtn.layer.cornerRadius = CGRectGetHeight(self.pinglunBtn.frame)/2;//半径大小
    self.pinglunBtn.layer.masksToBounds = YES;//是否切割
}

#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:self.huifuerModel.meeting_title.length>0 ?self.huifuerModel.meeting_title : @""];
}

-(BOOL)hideNavigationBottomLine{
    return YES;
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

#pragma mark - 私有方法 -

- (IBAction)pinglunBtn:(UIButton *)sender {
    self.input = [[inputView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen] .bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.input];
    if (self.inputStr.length > 0) {
        self.input.inputTextView.text = self.inputStr;
    }
    self.input.delegate = self;
    [self.input inputViewShow];
}


#pragma mark - textinput代理 -

-(void)giveText:(NSString *)text{
    self.inputStr = text;
}

- (void)sendText:(NSString *)text{

    NSDictionary *dict = @{
//                           @"userid":self.userid,
//                           @"toid":self.articleid,
//                           @"comType":@"0",
//                           @"comContent":text,
//                           @"comment_to_type":@"4"
                           };
    NSLog(@"%@",dict);
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_comment"] parameters:dict success:^(id obj) {
        
        NSLog(@"%@",obj);
    } fail:^(NSError *error) {
        //
    }];
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
