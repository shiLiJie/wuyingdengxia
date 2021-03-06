//
//  YijieshuVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "YijieshuVc.h"
#import "YijieshuCell.h"
#import "MyHuodongModel.h"

@interface YijieshuVc ()

@property (nonatomic, strong) UIImageView *imageview;
@end

@implementation YijieshuVc

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (kDevice_Is_iPhoneX) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 133, 0);
    }else{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 113, 0);
    }
    
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -80, self.view.frame.size.width, self.view.frame.size.height)];
    self.imageview.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageview];
}

//-(void)setYijieshuArr:(NSMutableArray *)yijieshuArr{
//
//    [self.tableView reloadData];
//}

#pragma mark - tableviewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.yijieshuArr.count == 0) {
        
        self.imageview.image = GetImage(@"wuhuodong");
        self.imageview.hidden = NO;
        return 0;
    }else{
        self.imageview.hidden = YES;
        return self.yijieshuArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 93;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"YijieshuCell";
    YijieshuCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
//    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YijieshuCell" owner:nil options:nil] firstObject];
//    }
    
    MyHuodongModel *model = [[MyHuodongModel alloc] init];
    model = self.yijieshuArr[indexPath.row];
    if (!kStringIsEmpty(model.meeting_image)) {
        [cell.image sd_setImageWithURL:[NSURL URLWithString:model.meeting_image] placeholderImage:GetImage(@"")];
    }
    
    if (!kStringIsEmpty(model.meet_title)) {
        cell.titleLab.text = model.meet_title;
    }else{
        cell.titleLab.text = @"";
    }
    
    cell.timeLab.text = [NSString stringWithFormat:@"%@-%@",model.begin_time,model.end_time];
    if ([model.is_sign isEqualToString:@"0"]) {
        cell.choosetype = weiqiandaoType;
        [cell setUpUi:cell.choosetype];
    }else{
        cell.choosetype = yiqiandaoType;//已签到
        [cell setUpUi:cell.choosetype];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(tableviewDidSelectPageWithIndex4:)]) {
        [self.delegate tableviewDidSelectPageWithIndex4:indexPath];
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
