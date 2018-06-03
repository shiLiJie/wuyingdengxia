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
#import "SignUpResultVC.h"
#import "ChooseCarVc.h"
#import "huocheModel.h"
#import "ChooseCarGViewController.h"

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
//火车票数组
@property (nonatomic, strong) NSArray *huocheArr;

//提交报名需要的信息存储
@property (nonatomic, strong) NSMutableDictionary *baomingDict;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.huocheArr = [[NSArray alloc] init];
    //设置UI
    [self setupUi];
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    //初始化提交字典
    self.baomingDict = @{
                           @"user_id":user.userid,
                           @"meet_id":self.meetdetailModel.meet_id,
                           @"take_type":@"火车",
                           @"car_num1":@" ",
                           @"from1":@" ",
                           @"to1":@" ",
                           @"car_num1b":@" ",
                           @"from1b":@" ",
                           @"to1b":@" ",
                           @"car_num2":@" ",
                           @"from2":@" ",
                           @"to2":@" ",
                           @"car_num2b":@" ",
                           @"from2b":@" ",
                           @"to2b":@" ",
                           @"special1":@" ",
                           @"special2":@" ",
                           @"begin_time":@" ",
                           @"end_time":@" ",
                           @"remark":@" ",
                           }.mutableCopy;
}

//由于Scroller不滚动,没办法才在didappear里设置滚动范围
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.acrollerView.contentSize =  CGSizeMake(0, CGRectGetMaxY(self.zhusuView.frame));
    
    //设置阴影
    CALayer *layer = [CALayer layer];
    layer.frame = self.pushBtn.frame;
    layer.backgroundColor = RGB(45, 163, 255).CGColor;
    layer.shadowColor = RGB(45, 163, 255).CGColor;
    layer.shadowOffset = CGSizeMake(0, 2);
    layer.shadowOpacity = 0.5;
    layer.cornerRadius = 42/2;
    [self.view.layer addSublayer:layer];
    //一到最上层
    [self.view bringSubviewToFront:self.pushBtn];
    
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
    __weak typeof(self) weakSelf = self;
    self.takecarView.takeCarViewkBlcok = ^(NSArray *arr, BOOL isZuo, BOOL isYou) {
        ChooseCarVc *car = [[ChooseCarVc alloc] init];
        car.zhanArr = arr;
        car.zhanArrall = arr;
        [weakSelf.navigationController pushViewController:car animated:YES];
        car.choosecarViewkBlcok = ^(NSString *car) {
            if (isZuo) {
//                NSLog(@"%@",car);
                [weakSelf.takecarView.zuoCity setTitle:car forState:UIControlStateNormal];
                [weakSelf.baomingDict setValue:car forKey:@"from1"];
            }else{
                [weakSelf.takecarView.youCity setTitle:car forState:UIControlStateNormal];
                [weakSelf.baomingDict setValue:car forKey:@"to1"];
            }
        };
    };
    
    //查询火车票
    self.takecarView.addtakeCarDatekBlcok = ^(NSString *str) {
        
    };
    //选车次
    self.takecarView.choosechecikBlcok = ^{
        [weakSelf getChepiaoInfoWithDaate:weakSelf.takecarView.chengcheDate.text start:weakSelf.takecarView.zuoCity.currentTitle end:weakSelf.takecarView.youCity.currentTitle TakeCarView:weakSelf.takecarView isCheci:YES isOne:YES];
        
    };
    //备选车次
    self.takecarView.choosebeicheciBlcok = ^{
        [weakSelf getChepiaoInfoWithDaate:weakSelf.takecarView.chengcheDate.text start:weakSelf.takecarView.zuoCity.currentTitle end:weakSelf.takecarView.youCity.currentTitle TakeCarView:weakSelf.takecarView isCheci:NO isOne:YES];
    };
    //备注
    self.takecarView.beizhuBlcok = ^{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"备注" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        //增加确定按钮；
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
            UITextField *beizhuTextfield = alertController.textFields.firstObject;
            weakSelf.takecarView.beizhuLab.text = beizhuTextfield.text;
            [weakSelf.baomingDict setValue:beizhuTextfield.text forKey:@"special1"];
        }]];
        //增加取消按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        //定义第一个输入框；
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入备注";
        }];
        [weakSelf presentViewController:alertController animated:true completion:nil];

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


/**
 查询车次

 @param date 时间
 @param start 始发站
 @param end 终点站
 */
-(void)getChepiaoInfoWithDaate:(NSString *)date
                         start:(NSString *)start
                           end:(NSString *)end
                   TakeCarView:(TakeCarView *)TakecarView
                       isCheci:(BOOL)ischeci
                         isOne:(BOOL)isone{
    

//    start = @"北京";
//    end = @"洛阳";
    if (![start isEqualToString:@"请选择"] && ![end isEqualToString:@"请选择"] && ![date isEqualToString:@"选择乘车日期"]) {
        //发送查询车票请求
        NSString  *url = [[NSString stringWithFormat:@"http://apis.juhe.cn/train/s2swithprice?start=%@&end=%@&date=%@&key=ba31b08d5a33f101ba2193f2daaf3492",start,end,date] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        __weak typeof(self) weakSelf = self;
        [[HttpRequest shardWebUtil] getNetworkRequestURLString:url
                                                    parameters:nil
                                                       success:^(id obj) {
                                                           
                                                           NSArray *arr = obj[@"result"][@"list"];
                                                           
                                                           if ([arr isKindOfClass:[NSNull class]]) {
                                                               [MBProgressHUD showError:@"无票"];
                                                               return;
                                                           }
                                                           NSMutableArray *arrayM = [NSMutableArray array];
                                                           for (int i = 0; i < arr.count; i ++) {
                                                               NSDictionary *dict = arr[i];
                                                               [arrayM addObject:[huocheModel huochepiaoWithDict:dict]];
                                                               
                                                           }
                                                           weakSelf.huocheArr= arrayM;
                                                           ChooseCarGViewController *vc = [[ChooseCarGViewController alloc] init];
                                                           vc.huocheArr = [[NSArray alloc] init];
                                                           vc.huocheArr = weakSelf.huocheArr;
                                                           vc.time = date;
                                                           vc.title = [NSString stringWithFormat:@"%@-%@",start,end];
                                                           vc.isCheci = ischeci;
                                                           [weakSelf.navigationController pushViewController:vc animated:YES];

                                                           vc.checikBlcok = ^(NSString *str, BOOL isCheci) {
                                                               
                                                               if (isone) {
                                                                   //第一个选车模块
                                                                   if (ischeci) {
                                                                       TakecarView.checi.text = str;
                                                                       [weakSelf.baomingDict setValue:str forKey:@"car_num1"];
                                                                   }else{
                                                                       TakecarView.beixuanCheci.text = str;
                                                                       [weakSelf.baomingDict setValue:str forKey:@"car_num1b"];
                                                                   }
                                                               }else{
                                                                   //第二个选车模块
                                                                   if (ischeci) {
                                                                       TakecarView.checi.text = str;
                                                                       [weakSelf.baomingDict setValue:str forKey:@"car_num2"];
                                                                   }else{
                                                                       TakecarView.beixuanCheci.text = str;
                                                                       [weakSelf.baomingDict setValue:str forKey:@"car_num2b"];
                                                                   }
                                                               }
                                                               
                                                           };
                                                           
                                                       } fail:^(NSError *error) {
                                                           
                                                       }];
    }else
    {
        [MBProgressHUD showOneSecond:@"请完善乘车信息"];
    }
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
    
    __weak typeof(self) weakSelf = self;
    //回调回来选择好的信息
    takecarView.takeCarViewkBlcok = ^(NSArray *arr, BOOL isZuo, BOOL isYou) {
        ChooseCarVc *car = [[ChooseCarVc alloc] init];
        car.zhanArr = arr;
        car.zhanArrall = arr;
        [weakSelf.navigationController pushViewController:car animated:YES];
        car.choosecarViewkBlcok = ^(NSString *car) {
            if (isZuo) {
                [takecarView.zuoCity setTitle:car forState:UIControlStateNormal];
                [weakSelf.baomingDict setValue:car forKey:@"from2"];
            }else{
                [takecarView.youCity setTitle:car forState:UIControlStateNormal];
                [weakSelf.baomingDict setValue:car forKey:@"from2"];
            }
            
        };
    };
    
    //查询火车票
    takecarView.addtakeCarDatekBlcok = ^(NSString *str) {
        
    };
    //选车次
    takecarView.choosechecikBlcok = ^{
        [weakSelf getChepiaoInfoWithDaate:takecarView.chengcheDate.text start:takecarView.zuoCity.currentTitle end:takecarView.youCity.currentTitle TakeCarView:takecarView isCheci:YES isOne:NO];
        
    };
    //备选车次
    takecarView.choosebeicheciBlcok = ^{
        [weakSelf getChepiaoInfoWithDaate:takecarView.chengcheDate.text start:takecarView.zuoCity.currentTitle end:takecarView.youCity.currentTitle TakeCarView:takecarView isCheci:NO isOne:NO];
    };
    //备注
    takecarView.beizhuBlcok = ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"备注" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        //增加确定按钮；
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
            UITextField *beizhuTextfield = alertController.textFields.firstObject;
            takecarView.beizhuLab.text = beizhuTextfield.text;
            [weakSelf.baomingDict setValue:beizhuTextfield.text forKey:@"special2"];
        }]];
        //增加取消按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        //定义第一个输入框；
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入备注";
        }];
        [weakSelf presentViewController:alertController animated:true completion:nil];
    };
    
    self.zhusuViewConstraint.constant = 300 * (self.addNum + 1) + 10;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{

        self.acrollerView.contentSize =  CGSizeMake(0, CGRectGetMaxY(self.zhusuView.frame));
    });


    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        self.zhusuViewConstraint.constant = 300 * (self.addNum + 1) + 10;
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            self.acrollerView.contentSize =  CGSizeMake(0, CGRectGetMaxY(self.zhusuView.frame));
        });
    });
}

//选择入住日期按钮点击
- (IBAction)ruzhuBtnClick:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    [BRDatePickerView showDatePickerWithTitle:@"入住日期"
                                     dateType:UIDatePickerModeDate
                              defaultSelValue:@""
                                   minDateStr:@""
                                   maxDateStr:@""
                                 isAutoSelect:YES
                                  resultBlock:^(NSString *selectValue) {
                                      //回调设置选好的日期
                                      [weakSelf.ruzhuBtn setTitle:selectValue forState:UIControlStateNormal];
                                      //计算天数并显示
                                      [weakSelf planDays];
                                      
    }];
}
//选择离开日期按钮点击
- (IBAction)likaiBtnClick:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    [BRDatePickerView showDatePickerWithTitle:@"离开日期"
                                     dateType:UIDatePickerModeDate
                              defaultSelValue:@""
                                   minDateStr:@""
                                   maxDateStr:@""
                                 isAutoSelect:YES
                                  resultBlock:^(NSString *selectValue) {
                                      //回调设置选好的日期
                                      [weakSelf.likaiBtn setTitle:selectValue forState:UIControlStateNormal];
                                      //计算天数并显示
                                      [weakSelf planDays];
    }];
}
//计算天数方法
-(void)planDays{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [dateFormatter dateFromString:self.ruzhuBtn.currentTitle];
    NSDate *dateToString = [dateFormatter dateFromString:self.likaiBtn.currentTitle];

    int timediff = [dateToString timeIntervalSince1970]-[dateFromString timeIntervalSince1970];
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((int)timediff)/(3600*24);  //一天是24小时*3600秒
    NSString * dateValue = [NSString stringWithFormat:@"%i",days];
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        [self.totalDateBtn setTitle:[NSString stringWithFormat:@"共%@天",dateValue] forState:UIControlStateNormal];
    });
}

//提交按钮点击方法
- (IBAction)pushBtnClick:(UIButton *)sender {
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    [self.baomingDict setValue:self.ruzhuBtn.currentTitle forKey:@"begin_time"];
    [self.baomingDict setValue:self.likaiBtn.currentTitle forKey:@"end_time"];
    
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_attend"] parameters:self.baomingDict success:^(id obj) {
        
        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
            
            SignUpResultVC *vc = [[SignUpResultVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            [MBProgressHUD showError:obj[@"msg"]];
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    

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
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    static NSString *cellIndentifier = @"SignUpTableViewCell";//这里的cellID就是cell的xib对应的名称
    SignUpTableViewCell *cell = (SignUpTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(nil == cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIndentifier owner:self options:nil];
        if (indexPath.section == 0) {
            cell = [nib objectAtIndex:indexPath.row];
            cell.meetName.text = self.meetdetailModel.meet_title;
            cell.meetTime.text = [NSString stringWithFormat:@"%@",self.meetdetailModel.begin_time];
            
        }else{
            cell = [nib objectAtIndex:indexPath.row+2];
            
            cell.userName.text = user.userReal_name;
            cell.userPhone.text = user.phoneNum;
            cell.userShenfenid.text = user.useravatar_id;
            cell.userSex.text = user.usersex;
            cell.danwei.text = user.userUnit;
            cell.bumen.text = user.userOffice;
            cell.zhiwu.text = user.userPost;

        }
        
    }
    
    return cell;
}

-(void)dealloc{
    
    
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
