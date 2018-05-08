//
//  QATableVIewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "QATableVIewController.h"
#import "QATableVIewCell.h"
#import "QusetionModel.h"

@interface QATableVIewController ()<UITableViewDelegate,UITableViewDataSource,QATableVIewCellDelegate>

@property (nonatomic, strong) QATableVIewCell * cell;
@end

@implementation QATableVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取标签下对应问答
    [self getQusetionWithLabel];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//获取标签下对应问答
-(void)getQusetionWithLabel{

    NSString  *url = [[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_question_bylabel?label=%@",self.lablemodel.key_name]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString  *url1 = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_question_bylabel?label=%@",self.lablemodel.key_id]];
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:url1
                                                parameters:nil
                                                   success:^(id obj) {
        NSLog(@"%@",obj);
                                                       [self.tableview reloadData];
    }
                                                      fail:^(NSError *error) {
        //
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    return self.dataArr.count;
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"QATableVIewCell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    
    if (!self.cell) {
        
        self.cell = [[[NSBundle mainBundle] loadNibNamed:@"QATableVIewCell" owner:nil options:nil] firstObject];
        self.cell.headImage.tag = indexPath.row;
        self.cell.delegate = self;
        
    }
    
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    
    return self.cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.delegate QAtableviewDidSelectPageWithIndex:indexPath];
}

#pragma mark - cell代理方法 -
//监听点击table点击的索引
-(void)tableviewDidSelectUserHeadImage:(NSInteger)indexPath{
    //推出个人展示页
    [self.delegate clickHeadImageJumpToPersonDetailPage:indexPath];
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
