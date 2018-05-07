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

@property (nonatomic, strong) NSArray *meetingArr;


@end

@implementation MeetingNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //获取会议
    [self getMeetInfo];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//获取会议
-(void)getMeetInfo{
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:@"get_allmeeting"] parameters:nil success:^(id obj) {
        
        NSArray *arr = obj[@"data"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 0; i < arr.count; i ++) {
            NSDictionary *dict = arr[i];
            [arrayM addObject:[meetingModel meetWithDict:dict]];
            
        }
        self.meetingArr= arrayM;
        
        [self.tableview reloadData];
        
    } fail:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.meetingArr.count;
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
        cell.baomingBtn.layer.borderColor = RGB(245, 166, 35).CGColor;//设置边框颜色
        [cell.baomingBtn setTitleColor:RGB(245, 166, 35) forState:UIControlStateNormal];
        cell.baomingBtn.layer.borderWidth = 0.5f;//设置边框颜色
        
        meetingModel *model = [[meetingModel alloc] init];
        model = self.meetingArr[indexPath.row];
        cell.meetImage.image = GetImage(model.meeting_image);
        cell.meetName.text = model.meet_title;
        cell.meetTime.text = model.begin_time;
        if (![model.isfinish isEqualToString:@"0"]) {
            cell.baomingBtn.layer.borderColor = RGB(198, 198, 198).CGColor;//设置边框颜色
            [cell.baomingBtn setTitle:@"未开始" forState:UIControlStateNormal];
            [cell.baomingBtn setTitleColor:RGB(198, 198, 198) forState:UIControlStateNormal];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    meetingModel *model = [[meetingModel alloc] init];
    model = self.meetingArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(meetTbleviewDidSelectPageWithIndex:meetingModel:)]) {
        [self.delegate meetTbleviewDidSelectPageWithIndex:indexPath meetingModel:model];
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
