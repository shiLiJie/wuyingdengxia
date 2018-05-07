//
//  PastViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PastViewController.h"
#import "MeetingNewCell.h"


@interface PastViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *huiguArr;


@end

@implementation PastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取往期回顾
    [self getHuiguInfo];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
        self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//获取往期回顾
-(void)getHuiguInfo{
    
    __weak typeof(self) weakSelf = self;
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:@"get_allreplay"] parameters:nil success:^(id obj) {
        
        NSArray *arr = obj[@"data"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 0; i < arr.count; i ++) {
            NSDictionary *dict = arr[i];
            [arrayM addObject:[huiguModel huiguWithDict:dict]];

        }
        weakSelf.huiguArr = arrayM;

        [weakSelf.tableview reloadData];
        
    } fail:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.huiguArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreen_Height * 0.3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"MeetingNewCell";
    MeetingNewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MeetingNewCell" owner:nil options:nil] firstObject];
        cell.baomingBtn.layer.cornerRadius = CGRectGetHeight(cell.baomingBtn.frame)/2;//2.0是圆角的弧度，根据需求自己更改
        cell.baomingBtn.layer.masksToBounds = YES;
        [cell.baomingBtn setTitle:@"已结束" forState:UIControlStateNormal];
        cell.baomingBtn.layer.borderColor = RGB(198, 198, 198).CGColor;//设置边框颜色
        [cell.baomingBtn setTitleColor:RGB(198, 198, 198) forState:UIControlStateNormal];
        cell.baomingBtn.layer.borderWidth = 0.5f;//设置边框颜色
        
        huiguModel *model = [[huiguModel alloc] init];
        model = self.huiguArr[indexPath.row];

        cell.meetName.text = model.replay_title;
        cell.meetTime.text = model.begin_time;

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    huiguModel *model = [[huiguModel alloc] init];
    model = self.huiguArr[indexPath.row];
    [self.delegate passTableviewDidSelectPageWithIndex:indexPath huiguModel:model];
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
