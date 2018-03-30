//
//  MyDetailViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/19.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyDetailViewController.h"
#import "BRPickerView.h"
#import "BRTextField.h"
#import "NSDate+BRAdd.h"

@interface MyDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) BRTextField *nameTF;//昵称
@property (nonatomic, strong) BRTextField *cityTF;//城市
@property (nonatomic, strong) BRTextField *yiyuanTF;//医院
@property (nonatomic, strong) BRTextField *keshiTF;//科室
@property (nonatomic, strong) BRTextField *zhichengTF;//职称
@property (nonatomic, strong) BRTextField *zhiwuTF;//职务
@property (nonatomic, strong) BRTextField *danweiTF;//单位
@property (nonatomic, strong) BRTextField *zhiweiTF;//职位
@property (nonatomic, strong) BRTextField *xuexiaoTF;//学校
@property (nonatomic, strong) BRTextField *zhuanyeTF;//专业
@property (nonatomic, strong) BRTextField *xueliTF;//学历
@property (nonatomic, strong) BRTextField *ruxuenianfenTF;//入学年份

@property (nonatomic, strong) NSArray *titleArr;


@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"个人资料"];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:CHINESE_SYSTEM(18) range:NSMakeRange(0, title.length)];
    return title;
}

#pragma mark - tableviewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 25;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            {
                return 2;
            }
            break;
        case 1:
            {
                return 4;
            }
            break;
        case 2:
            {
                return 2;
            }
            break;
        case 3:
            {
                return 4;
            }
            break;

        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * pageID = @"MyTableViewCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:pageID];
    
    if(cell==nil){
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pageID];
        
    }
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupNameTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"昵称";
            }
            if (indexPath.row == 1) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupcityTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"城市";
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupyiyuanTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"医院";
            }
            if (indexPath.row == 1) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupkeshiTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"科室";
            }
            if (indexPath.row == 2) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupzhichengTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"职称";
            }
            if (indexPath.row == 3) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupzhiwuTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"行政职务";
            }
            
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupdanweiTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"单位";
            }
            if (indexPath.row == 1) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupzhiweiTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"职位";
            }
        }
            break;
        case 3:
        {
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupxuexiaoTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"学校";
            }
            if (indexPath.row == 1) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupzhuanyeTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"专业";
            }
            if (indexPath.row == 2) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupxueliTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"学历";
            }
            if (indexPath.row == 3) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupruxuenianfenTF:cell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"入学年份";
            }
            
        }
            break;
        default:
            break;

    }
    return cell;
}

- (BRTextField *)getTextField:(UITableViewCell *)cell {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 230, 0, 200, 50)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f];
    textField.textAlignment = NSTextAlignmentRight;
    textField.textColor = RGB_HEX(0x666666, 1.0);
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

#pragma mark - 姓名 textField
- (void)setupNameTF:(UITableViewCell *)cell {
    if (!_nameTF) {
        _nameTF = [self getTextField:cell];
        _nameTF.placeholder = @"请输入";
        _nameTF.returnKeyType = UIReturnKeyDone;
        _nameTF.tag = 0;
    }
}
- (void)setupcityTF:(UITableViewCell *)cell {
    if (!_cityTF) {
        _cityTF = [self getTextField:cell];
        _cityTF.placeholder = @"请选择";
        _cityTF.tag = 1;
        __weak typeof(self) weakSelf = self;
        _cityTF.tapAcitonBlock = ^{
            [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@0, @0, @0] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
                weakSelf.cityTF.text = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
            }];
        };
    }
}
- (void)setupyiyuanTF:(UITableViewCell *)cell {
    if (!_yiyuanTF) {
        _yiyuanTF = [self getTextField:cell];
        _yiyuanTF.placeholder = @"请输入";
        _yiyuanTF.returnKeyType = UIReturnKeyDone;
        _yiyuanTF.tag = 2;
    }
}
- (void)setupkeshiTF:(UITableViewCell *)cell {
    if (!_keshiTF) {
        _keshiTF = [self getTextField:cell];
        _keshiTF.placeholder = @"请输入";
        _keshiTF.returnKeyType = UIReturnKeyDone;
        _keshiTF.tag = 3;
    }
}
- (void)setupzhichengTF:(UITableViewCell *)cell {
    if (!_zhichengTF) {
        _zhichengTF = [self getTextField:cell];
        _zhichengTF.placeholder = @"请输入";
        _zhichengTF.returnKeyType = UIReturnKeyDone;
        _zhichengTF.tag = 4;
    }
}
- (void)setupzhiwuTF:(UITableViewCell *)cell {
    if (!_zhiwuTF) {
        _zhiwuTF = [self getTextField:cell];
        _zhiwuTF.placeholder = @"请输入";
        _zhiwuTF.returnKeyType = UIReturnKeyDone;
        _zhiwuTF.tag = 5;
    }
}
- (void)setupdanweiTF:(UITableViewCell *)cell {
    if (!_danweiTF) {
        _danweiTF = [self getTextField:cell];
        _danweiTF.placeholder = @"请输入";
        _danweiTF.returnKeyType = UIReturnKeyDone;
        _danweiTF.tag = 6;
    }
}
- (void)setupzhiweiTF:(UITableViewCell *)cell {
    if (!_zhiweiTF) {
        _zhiweiTF = [self getTextField:cell];
        _zhiweiTF.placeholder = @"请输入";
        _zhiweiTF.returnKeyType = UIReturnKeyDone;
        _zhiweiTF.tag = 7;
    }
}
- (void)setupxuexiaoTF:(UITableViewCell *)cell {
    if (!_xuexiaoTF) {
        _xuexiaoTF = [self getTextField:cell];
        _xuexiaoTF.placeholder = @"请输入";
        _xuexiaoTF.returnKeyType = UIReturnKeyDone;
        _xuexiaoTF.tag = 8;
    }
}
- (void)setupzhuanyeTF:(UITableViewCell *)cell {
    if (!_zhuanyeTF) {
        _zhuanyeTF = [self getTextField:cell];
        _zhuanyeTF.placeholder = @"请输入";
        _zhuanyeTF.returnKeyType = UIReturnKeyDone;
        _zhuanyeTF.tag = 9;
    }
}
- (void)setupxueliTF:(UITableViewCell *)cell {
    if (!_xueliTF) {
        _xueliTF = [self getTextField:cell];
        _xueliTF.placeholder = @"请输入";
        _xueliTF.returnKeyType = UIReturnKeyDone;
        _xueliTF.tag = 10;
    }
}
- (void)setupruxuenianfenTF:(UITableViewCell *)cell {
    if (!_ruxuenianfenTF) {
        _ruxuenianfenTF = [self getTextField:cell];
        _ruxuenianfenTF.placeholder = @"请选择";
        _ruxuenianfenTF.tag = 11;
        __weak typeof(self) weakSelf = self;
        _ruxuenianfenTF.tapAcitonBlock = ^{
            [BRDatePickerView showDatePickerWithTitle:@"入学年份" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.ruxuenianfenTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                weakSelf.ruxuenianfenTF.text = selectValue;
            }]; 
        };
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 2 || textField.tag == 3 || textField.tag == 4 || textField.tag == 5 || textField.tag == 6 || textField.tag == 7 || textField.tag ==  8 || textField.tag == 9 || textField.tag == 10) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"* 姓名", @"* 性别", @"* 出生年月", @"   出生时刻", @"* 联系方式", @"* 地址", @"   学历", @"   其它",@"* 姓名", @"* 性别", @"* 出生年月", @"   出生时刻"];
    }
    return _titleArr;
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
