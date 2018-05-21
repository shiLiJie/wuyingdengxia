//
//  ChooseCarGViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "ChooseCarGViewController.h"
#import "huocheModel.h"
#import "ChooseCarGCell.h"

@interface ChooseCarGViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ChooseCarGViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self respondsToSelector:@selector(set_colorBackground)]) {
        UIColor *backgroundColor =  [self set_colorBackground];
        UIImage *bgimage = [UIImage imageWithColor:backgroundColor];
        
        [self.navigationController.navigationBar setBackgroundImage:bgimage forBarMetrics:UIBarMetricsDefault];
    }
    
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //默认显示黑线
    blackLineImageView.hidden = NO;
    if ([self respondsToSelector:@selector(hideNavigationBottomLine)]) {
        if ([self hideNavigationBottomLine]) {
            //隐藏黑线
            blackLineImageView.hidden = YES;
        }
    }
    
    self.timeLab.text = self.time;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle =NO;
    
    self.tableview.backgroundColor = RGB(181, 181, 181);
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:self.title];
}

-(UIColor*)set_colorBackground{
    return RGB(45, 163, 255);
}

-(BOOL)hideNavigationBottomLine{
    return YES;
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"baifh") forState:UIControlStateNormal];
    return btn;
}


-(void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0xFFFFFF) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}


#pragma mark - tableviewdelegate -

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.huocheArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    ChooseCarGCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
    
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChooseCarGCell" owner:nil options:nil] firstObject];
    }
    huocheModel *model = self.huocheArr[indexPath.row];
    cell.startStep.text = model.start_station;
    cell.startTime.text = model.start_time;
    cell.endStep.text = model.end_station;
    cell.endTime.text = model.end_time;
    cell.runTime.text = model.run_time;
    cell.carG.text = model.train_no;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    huocheModel *model = self.huocheArr[indexPath.row];
    //回调选择的车次
    self.checikBlcok(model.train_no, self.isCheci);
    
    [self.navigationController popViewControllerAnimated:YES];
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
