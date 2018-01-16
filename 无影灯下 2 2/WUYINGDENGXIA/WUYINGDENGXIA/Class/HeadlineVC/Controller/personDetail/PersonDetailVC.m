//
//  PersonDetailVC.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PersonDetailVC.h"
#import "PageTableViewCell.h"
#import "AnswerTableViewCell.h"

@interface PersonDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) int segeNum;

@end

@implementation PersonDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloaTableData:) name:@"PAGEORANSWERCHANGE" object:nil];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
}

// 参数类型是NSNotification

- (void)reloaTableData:(NSNotification *)notification{

    self.segeNum = [notification.userInfo[@"index"] intValue];
    [self.tableview reloadData];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    return self.dataArr.count;
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.segeNum == 1) {
        static NSString * AQID = @"AnswerTableViewCell";
        
        AnswerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AQID];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerTableViewCell" owner:nil options:nil] firstObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        static NSString * pageID = @"PageTableViewCell";
        
        PageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:pageID];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PageTableViewCell" owner:nil options:nil] firstObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
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
