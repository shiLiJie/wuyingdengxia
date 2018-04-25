//
//  MeetingNewViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MeetingNewViewController.h"
#import "MeetingNewCell.h"

@interface MeetingNewViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MeetingNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    return self.dataArr.count;
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreen_Height * 0.29;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"MeetingNewCell";
    MeetingNewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MeetingNewCell" owner:nil options:nil] firstObject];
        cell.baomingBtn.layer.cornerRadius = CGRectGetHeight(cell.baomingBtn.frame)/2;//2.0是圆角的弧度，根据需求自己更改
        cell.baomingBtn.layer.masksToBounds = YES;
        cell.baomingBtn.layer.borderColor = RGB(245, 166, 35).CGColor;//设置边框颜色
        [cell.baomingBtn setTitleColor:RGB(245, 166, 35) forState:UIControlStateNormal];
        cell.baomingBtn.layer.borderWidth = 0.5f;//设置边框颜色
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.delegate meetTbleviewDidSelectPageWithIndex:indexPath];
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
