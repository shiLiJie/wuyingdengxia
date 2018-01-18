//
//  AnswerTableVC.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "AnswerTableVC.h"
#import "AnswerTableViewCell.h"

@interface AnswerTableVC ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation AnswerTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    return self.dataArr.count;
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * AQID = @"AnswerTableViewCell";
    
    AnswerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AQID];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerTableViewCell" owner:nil options:nil] firstObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
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
