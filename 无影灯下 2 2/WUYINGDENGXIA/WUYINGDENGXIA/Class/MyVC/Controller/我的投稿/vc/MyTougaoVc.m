//
//  MyTougaoVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyTougaoVc.h"
#import "MyTougaoCell.h"
#import "PageDetailViewController.h"
#import "MyTougaoModel.h"

@interface MyTougaoVc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UIImageView *imageview;
@end

@implementation MyTougaoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.dataArr = [[NSArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height)];
    self.imageview.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageview];
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (user.loginStatus){
        //获取我的投稿信息
        [self getMytougaoInfo];
    }
    
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"我的投稿"];
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

//获取我的投稿信息
-(void)getMytougaoInfo{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    __weak typeof(self) weakSelf = self;
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_myarticle?userid=%@",user.userid]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       NSArray *arr = obj[@"data"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[MyTougaoModel MytougaoWithDict:dict]];
                                                           
                                                       }
                                                       weakSelf.dataArr= [[arrayM reverseObjectEnumerator] allObjects];
                                                       [weakSelf.tableView reloadData];
    }
                                                      fail:^(NSError *error) {
        
    }];
}

#pragma mark - tableviewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.dataArr.count == 0) {
        
        self.imageview.image = GetImage(@"wutougao");
        self.imageview.hidden = NO;
        return 0;
    }else{
        self.imageview.hidden = YES;
        return self.dataArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"MyTougaoCell";
    MyTougaoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];

    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTougaoCell" owner:nil options:nil] firstObject];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyTougaoModel *model = [[MyTougaoModel alloc] init];
    model = self.dataArr[indexPath.row];
    cell.tougaoTitle.text = model.article_title;
    cell.tougaoDetail.text = model.article_content;
    NSArray *array = [model.ctime componentsSeparatedByString:@" "];
    if (array.count>0) {
        cell.time.text = array[0];
    }
    if ([model.is_check isEqualToString:@"0"]) {
        cell.choosetype = waitType;
    }
    if ([model.is_check isEqualToString:@"1"]) {
        cell.choosetype = susscessType;
    }
    if ([model.is_check isEqualToString:@"2"]) {
        cell.choosetype = tuigaoType;
    }
    [cell setUIWithchooseType:cell.choosetype];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTougaoModel *model = [[MyTougaoModel alloc] init];
    model = self.dataArr[indexPath.row];
    PageDetailViewController *vc = [[PageDetailViewController alloc] init];
    vc.articleid = model.article_id;
    vc.userid = model.user_id;
    vc.MyPage = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
