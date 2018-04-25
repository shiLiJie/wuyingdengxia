//
//  QuestionsViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "QuestionsViewController.h"
#import "QATableVIewCell.h"
#import "QuestionsAslVcViewController.h"

@interface QuestionsViewController ()<UITableViewDelegate,UITableViewDataSource>
//输入问题标题的text
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
//输入问题后联想的tableview
@property (weak, nonatomic) IBOutlet UITableView *lianxiangTableview;
//请求回来的联想数据数组
@property (nonatomic, strong) NSArray *dataArr;


@end

@implementation QuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据数组
    self.dataArr = [[NSArray alloc] init];
    //监听问题标题变化
    [self addTargetMethod];
    //设置代理
    self.lianxiangTableview.delegate = self;
    self.lianxiangTableview.dataSource = self;
    
    //上来联想tableview默认隐藏
    self.lianxiangTableview.hidden = YES;
}

#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"提问"];
}

-(UIColor*)set_colorBackground{
    return [UIColor whiteColor];
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

-(UIButton *)set_rightButton{
    UIButton *right = [[UIButton alloc] init];
    [right setTitle:@"下一步" forState:UIControlStateNormal];
    [right setTitleColor:RGB(191, 191, 191) forState:UIControlStateNormal];
    [right setFont: [UIFont systemFontOfSize:17]];
    [right setUserInteractionEnabled:NO];//默认禁用按钮
    return right;
}

-(void)right_button_event:(UIButton *)sender{
    QuestionsAslVcViewController *vc = [[QuestionsAslVcViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}
#pragma mark - textfield代理 -

-(void)addTargetMethod{
    [self.titleTextField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
}
-(void)textField1TextChange:(UITextField *)textField{
//    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    if (textField.text.length) {
        //有有效输入
        //做网络请求
        
        //回复按钮点击
        [self.right_button setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];
        [self.right_button setUserInteractionEnabled:YES];
        //数据赋值,刷新联想列表
        self.dataArr = @[@"1",@"2",@"3",@"4"];
        if (self.dataArr.count != 0) {
            self.lianxiangTableview.hidden = NO;
        }else{
            self.lianxiangTableview.hidden = YES;
        }
        [self.lianxiangTableview reloadData];
    }else{
        //无标题输入,停止联想,下一步按钮禁用
        self.dataArr = [[NSArray alloc] init];
        self.lianxiangTableview.hidden = YES;
        [self.right_button setTitleColor:RGB(191, 191, 191) forState:UIControlStateNormal];
        [self.right_button setUserInteractionEnabled:YES];
    }
}


#pragma mark - tableview代理 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"QATableVIewCell";
    QATableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QATableVIewCell" owner:nil options:nil] firstObject];
//        cell.headImage.tag = indexPath.row;
//        .cell.delegate = self;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    [self.delegate tableviewDidSelectPageWithIndex:indexPath];
//}


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
