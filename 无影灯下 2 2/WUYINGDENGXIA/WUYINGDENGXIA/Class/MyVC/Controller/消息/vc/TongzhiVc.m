//
//  TongzhiVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "TongzhiVc.h"
#import "XiaoxiCell.h"
#import "canhuiModel.h"
#import "tuigaoModel.h"

@interface TongzhiVc ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation TongzhiVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - tableviewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 73;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"XiaoxiCell";
    XiaoxiCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
//    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XiaoxiCell" owner:nil options:nil] firstObject];
//    }
    
    NSDictionary *dict = self.dataArr[indexPath.row];
    if ([dict[@"type"] isEqualToString:@"1"]) {
        cell.xiaoxiTitle.text = @"退稿通知";
        cell.xiaoxiDetail.text = dict[@"content"];
        cell.xiaoxiType = tuigaoType;
        [cell setUpImage];
    }
    else
    
    if ([dict[@"type"] isEqualToString:@"2"]) {
        cell.xiaoxiType = canhuiType;
        cell.xiaoxiTitle.text = @"参会通知";
        cell.xiaoxiDetail.text = dict[@"content"];
        [cell setUpImage];
    }
    else
    {
        cell.xiaoxiType = wenjuanType;
        cell.xiaoxiTitle.text = @"问卷调查";
        [cell setUpImage];
    }
    //设置背景色,切圆角,点击不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict = self.dataArr[indexPath.row];
    if ([dict[@"type"] isEqualToString:@"1"]){
        
        [self.delegate transIndex:indexPath isTuigao:YES dataDict:dict];
        
    }else{
        
        [self.delegate transIndex:indexPath isTuigao:NO dataDict:dict];
    }
    
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
