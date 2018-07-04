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
#import "QusetionModel.h"
#import "AnswerViewController.h"

@interface QuestionsViewController ()<UITableViewDelegate,UITableViewDataSource>
//输入问题标题的text
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
//输入问题后联想的tableview
@property (weak, nonatomic) IBOutlet UITableView *lianxiangTableview;
//请求回来的联想数据数组
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) QATableVIewCell * cell;


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
    self.lianxiangTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //上来联想tableview默认隐藏
    self.lianxiangTableview.hidden = YES;
    //估算高度
    self.lianxiangTableview.estimatedRowHeight = 300;
    self.lianxiangTableview.rowHeight = UITableViewAutomaticDimension;
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
    right.frame = CGRectMake(kScreen_Width-100, 0, 60, 60);
    right.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [right setUserInteractionEnabled:NO];//默认禁用按钮
    return right;
}

-(void)right_button_event:(UIButton *)sender{
    QuestionsAslVcViewController *vc = [[QuestionsAslVcViewController alloc] init];
    vc.titleStr = self.titleTextField.text;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}


/**
 提问联想

 @param key 关键字
 */
-(void)getQuestionWithKey:(NSString *)key{
    __weak typeof(self) weakSelf = self;
        NSString  *url = [[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"getRealtedQuestionList?keyword=%@",key]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:url
                                                parameters:nil
                                                   success:^(id obj) {
                                                       if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                           
                                                           NSArray *arr = obj[@"data"];
                                                           NSMutableArray *arrayM = [NSMutableArray array];
                                                           for (int i = 0; i < arr.count; i ++) {
                                                               NSDictionary *dict = arr[i];
                                                               [arrayM addObject:[QusetionModel QusetionWithDict:dict]];
                                                               
                                                           }
                                                           weakSelf.dataArr= arrayM;
                                                           
                                                           if (weakSelf.dataArr.count != 0) {
                                                               weakSelf.lianxiangTableview.hidden = NO;
                                                           }else{
                                                               weakSelf.lianxiangTableview.hidden = YES;
                                                           }
                                                           [weakSelf.lianxiangTableview reloadData];
                                                           
                                                       }else{
                                                           
                                                       }
                                                       
        
    } fail:^(NSError *error) {
        
    }];
}

//获取多长时间之前
-(NSString *)getBeforeTimeWithTime:(NSString *)str{
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval/60 < 1) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return result;
    
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
        [self getQuestionWithKey:textField.text];
        
        //回复按钮点击
        [self.right_button setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];
        [self.right_button setUserInteractionEnabled:YES];


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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 145;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    static NSString * reuseID = @"QATableVIewCell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
//    self.cell.delegate = self;
    
    QusetionModel *model = self.dataArr[indexPath.row];
    
    if ([model.question_image isKindOfClass:[NSNull class]]) {
        //纯文字
        self.cell = [[NSBundle mainBundle] loadNibNamed:@"QATableVIewCell" owner:nil options:nil][0];
        self.cell.headImage.tag = indexPath.row;
        self.cell.userName.text = [NSString stringWithFormat:@"%@",model.user_name];
        [self.cell.headImage sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headimg]] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
        self.cell.mainTitle.text = [NSString stringWithFormat:@"%@",model.question_title];
        self.cell.detailPage.text = [NSString stringWithFormat:@"%@",model.question_content];
        self.cell.answerNum.text = [NSString stringWithFormat:@"已回答 %@",model.answer_num];
        self.cell.mooncash.text = [NSString stringWithFormat:@"%@",model.moon_cash];
        self.cell.answerTime.text = [NSString stringWithFormat:@"%@",[self getBeforeTimeWithTime:model.last_answer_time]];
        
        return self.cell;
    }
    NSArray *array = [model.question_image componentsSeparatedByString:@","]; //字符串按照,分隔成数组
    
    if (array.count == 1) {
        if (kStringIsEmpty(array[0])) {
            //纯文字
            self.cell = [[NSBundle mainBundle] loadNibNamed:@"QATableVIewCell" owner:nil options:nil][0];
            self.cell.headImage.tag = indexPath.row;
            self.cell.userName.text = [NSString stringWithFormat:@"%@",model.user_name];
            [self.cell.headImage sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headimg]] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
            self.cell.mainTitle.text = [NSString stringWithFormat:@"%@",model.question_title];
            self.cell.detailPage.text = [NSString stringWithFormat:@"%@",model.question_content];
            self.cell.answerNum.text = [NSString stringWithFormat:@"已回答 %@",model.answer_num];
            self.cell.mooncash.text = [NSString stringWithFormat:@"%@",model.moon_cash];
            self.cell.answerTime.text = [NSString stringWithFormat:@"%@",[self getBeforeTimeWithTime:model.last_answer_time]];
        }else{
            //一张图
            self.cell = [[NSBundle mainBundle] loadNibNamed:@"QATableVIewCell" owner:nil options:nil][1];
            self.cell.headImage1.tag = indexPath.row;
            self.cell.userName1.text = [NSString stringWithFormat:@"%@",model.user_name];
            [self.cell.headImage1 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headimg]] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
            self.cell.mainTitle1.text = [NSString stringWithFormat:@"%@",model.question_title];
            self.cell.detailPage1.text = [NSString stringWithFormat:@"%@",model.question_content];
            self.cell.answerNum1.text = [NSString stringWithFormat:@"已回答 %@",model.answer_num];
            self.cell.mooncash1.text = [NSString stringWithFormat:@"%@",model.moon_cash];
            self.cell.answerTime1.text = [NSString stringWithFormat:@"%@",[self getBeforeTimeWithTime:model.last_answer_time]];
            [self.cell.image1 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:GetImage(@"")];
        }
        
    }else if (array.count == 2){
        //一张图
        self.cell = [[NSBundle mainBundle] loadNibNamed:@"QATableVIewCell" owner:nil options:nil][1];
        self.cell.headImage1.tag = indexPath.row;
        self.cell.userName1.text = [NSString stringWithFormat:@"%@",model.user_name];
        [self.cell.headImage1 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headimg]] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
        self.cell.mainTitle1.text = [NSString stringWithFormat:@"%@",model.question_title];
        self.cell.detailPage1.text = [NSString stringWithFormat:@"%@",model.question_content];
        self.cell.answerNum1.text = [NSString stringWithFormat:@"已回答 %@",model.answer_num];
        self.cell.mooncash1.text = [NSString stringWithFormat:@"%@",model.moon_cash];
        self.cell.answerTime1.text = [NSString stringWithFormat:@"%@",[self getBeforeTimeWithTime:model.last_answer_time]];
        [self.cell.image1 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:GetImage(@"")];
        
    }else if (array.count >= 3){
        //三张图
        self.cell = [[NSBundle mainBundle] loadNibNamed:@"QATableVIewCell" owner:nil options:nil][2];
        self.cell.headImage2.tag = indexPath.row;
        self.cell.userName2.text = [NSString stringWithFormat:@"%@",model.user_name];
        [self.cell.headImage2 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headimg]] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
        self.cell.mainTitle2.text = [NSString stringWithFormat:@"%@",model.question_title];
        self.cell.detailPage2.text = [NSString stringWithFormat:@"%@",model.question_content];
        self.cell.answerNum2.text = [NSString stringWithFormat:@"已回答 %@",model.answer_num];
        self.cell.mooncash2.text = [NSString stringWithFormat:@"%@",model.moon_cash];
        self.cell.answerTime2.text = [NSString stringWithFormat:@"%@",[self getBeforeTimeWithTime:model.last_answer_time]];
        [self.cell.image21 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:GetImage(@"")];
        [self.cell.image22 sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:GetImage(@"")];
        [self.cell.image23 sd_setImageWithURL:[NSURL URLWithString:array[2]] placeholderImage:GetImage(@"")];
    }
    
    [self.cell setLabelSpace];
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return self.cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AnswerViewController *vc = [[AnswerViewController alloc] init];
    vc.questionModel = [[QusetionModel alloc] init];
    vc.questionModel = self.dataArr[indexPath.row];
    vc.choosetype = myquestionType;
    [self.navigationController pushViewController:vc animated:YES];
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
