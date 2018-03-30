//
//  SignUpViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignUpTableViewCell.h"
#import "TakeCarView.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"

@interface SignUpViewController ()<UITableViewDelegate,UITableViewDataSource>
//scroller
@property (weak, nonatomic) IBOutlet UIScrollView *acrollerView;
//容器view
@property (weak, nonatomic) IBOutlet UIView *contentview;
//列表
@property (weak, nonatomic) IBOutlet UITableView *tableview;
//提交按钮
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;
//报名上部分cell内容
@property (nonatomic, strong) SignUpTableViewCell *signUpCell;
//乘车信息选择view
@property (nonatomic, strong) TakeCarView *takecarView;
//底部住宿信息view
@property (weak, nonatomic) IBOutlet UIView *zhusuView;
//选择入住日期按钮
@property (weak, nonatomic) IBOutlet UIButton *ruzhuBtn;
//选择离开日期按钮
@property (weak, nonatomic) IBOutlet UIButton *likaiBtn;
//总共住几天按钮,不点击,只展示
@property (weak, nonatomic) IBOutlet UIButton *totalDateBtn;
//住宿view距离上个控件的约束,添加乘车信息是约束增大
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhusuViewConstraint;
//添加乘车信息的次数
@property (nonatomic, assign) int addNum;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self setupUi];
}

//由于Scroller不滚动,没办法才在didappear里设置滚动范围
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.acrollerView.contentSize =  CGSizeMake(0, CGRectGetMaxY(self.zhusuView.frame));
}

#pragma mark - UI -
//设置UI
-(void)setupUi{
    
    //先添加一个选择乘车信息view占位
    self.takecarView = [[TakeCarView alloc] initWithFrame:
                        CGRectMake(0, CGRectGetMaxY(self.tableview.frame)+10, CGRectGetWidth(self.acrollerView.frame), 295)
                        ];

    [self.acrollerView addSubview:self.takecarView];
    
    [self.takecarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.contentview.mas_bottom).with.offset(10);
        make.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(300);
    }];

    //回调回来选择好的信息
    self.takecarView.takeCarViewkBlcok = ^(NSArray *arr) {
        
    };
    
    //隐藏底部线,设置代理
    self.tableview.separatorStyle =NO;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    //禁止滚动
    self.tableview.userInteractionEnabled = NO;
    
    //报名按钮切圆角
    self.pushBtn.layer.cornerRadius = CGRectGetHeight(self.pushBtn.frame)/2;//半径大小
    self.pushBtn.layer.masksToBounds = YES;//是否切割
    //初始化时候添加乘车次数为0;
    self.addNum = 0 ;

}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"填写报名信息"];
}

-(UIColor*)set_colorBackground{
    return [UIColor whiteColor];
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

#pragma mark - 私有方法 -
-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

//字符串转日期
- (NSDate *)StringTODate:(NSString *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MMMM-dd HH:mm:ss";
    [dateFormatter setMonthSymbols:[NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil]];
    NSDate * ValueDate = [dateFormatter dateFromString:sender];
    return ValueDate;
}

//添加乘车信息按钮点击
- (IBAction)addCarBtnClick:(UIButton *)sender {
    //添加乘车信息的次数 + 1
    self.addNum = self.addNum + 1;
    
    //先添加一个选择乘车信息view占位
    TakeCarView *takecarView = [[TakeCarView alloc] initWithFrame:
                        CGRectMake(0, CGRectGetMaxY(self.tableview.frame)+10, CGRectGetWidth(self.acrollerView.frame), 295)
                        ];
    
    [self.acrollerView addSubview:takecarView];
    //设置增加乘车信息的view约束
    [takecarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.contentview.mas_bottom).with.offset(300 * self.addNum +11);
        make.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(300);
    }];
    
    //回调回来选择好的信息
    takecarView.takeCarViewkBlcok = ^(NSArray *arr) {
        
    };
    
    self.zhusuViewConstraint.constant = 300 * (self.addNum + 1) + 10;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        self.acrollerView.contentSize =  CGSizeMake(0, CGRectGetMaxY(self.zhusuView.frame));
    });
    
}
//选择入住日期按钮点击
- (IBAction)ruzhuBtnClick:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    [BRDatePickerView showDatePickerWithTitle:@"入住日期" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
        [weakSelf.ruzhuBtn setTitle:selectValue forState:UIControlStateNormal];
    }];
}
//选择离开日期按钮点击
- (IBAction)likaiBtnClick:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    [BRDatePickerView showDatePickerWithTitle:@"离开日期" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
        [weakSelf.likaiBtn setTitle:selectValue forState:UIControlStateNormal];
        
//
//        //字符串转NSDate格式的方法
//        NSDate * ValueDate = [self StringTODate:self.ruzhuBtn.titleLabel.text];
//        NSDate * ValueDate1 = [self StringTODate:selectValue];
//        //计算两个中间差值(秒)
//        NSTimeInterval time = [ValueDate timeIntervalSinceDate:ValueDate1];
//
//        //开始时间和结束时间的中间相差的时间
//        int days;
//        days = ((int)time)/(3600*24);  //一天是24小时*3600秒
//        NSString * dateValue = [NSString stringWithFormat:@"%i",days];
//
//        NSLog(@"打印出时间的差值--->>%@",dateValue);
        
        //创建日期格式化对象
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateFromString = [dateFormatter dateFromString:@"2012-05-10"];
        NSDate *dateToString = [dateFormatter dateFromString:@"2012-05-11"];
        int timediff = [dateToString timeIntervalSince1970]-[dateFromString timeIntervalSince1970];
        //开始时间和结束时间的中间相差的时间
        int days;
        days = ((int)timediff)/(3600*24);  //一天是24小时*3600秒
        NSString * dateValue = [NSString stringWithFormat:@"%i",days];
        
        NSLog(@"打印出时间的差值--->>%@",dateValue);
        
    }];
}
//提交按钮点击方法
- (IBAction)pushBtnClick:(UIButton *)sender {
    
}

#pragma mark - tableview代理 -
//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }else{
        return 7;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"SignUpTableViewCell";//这里的cellID就是cell的xib对应的名称
    SignUpTableViewCell *cell = (SignUpTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(nil == cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIndentifier owner:self options:nil];
        if (indexPath.section == 0) {
            cell = [nib objectAtIndex:indexPath.row];
        }else{
            cell = [nib objectAtIndex:indexPath.row+2];
        }
        
    }
    
    return cell;
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
