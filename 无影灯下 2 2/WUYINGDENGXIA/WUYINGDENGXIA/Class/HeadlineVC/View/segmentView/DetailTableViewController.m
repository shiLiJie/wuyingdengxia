//
//  ViewController1.m
//  Linkage
//
//  Created by administrator on 2017/9/1.
//  Copyright © 2017年 JohnLai. All rights reserved.
//

#import "DetailTableViewController.h"
#import "UIColor+Tools.h"
#import "DetailTableViewCell.h"

@interface DetailTableViewController ()<UITableViewDataSource,UITableViewDelegate,DetailTableViewCellDelegate>

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) DetailTableViewCell * cell;


@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
    self.dataArr = @[@"1",@"1",@"1",@"1",@"1"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return self.dataArr.count;
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"DetailTableViewCell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    
    
    if (!self.cell) {
        
        self.cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil] firstObject];
    }
    
    self.cell.delegate = self;
    
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 160, 0);
    
    return self.cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.delegate tableviewDidSelectPageWithIndex:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.DidScrollBlock) {
        self.DidScrollBlock(scrollView.contentOffset.y);
    }
}

#pragma mark - cell点击头像和用户名代理方法 -
-(void)pushPublishPersonVc{
    [self.delegate clickUserNamePushPublishVc];
}

@end
