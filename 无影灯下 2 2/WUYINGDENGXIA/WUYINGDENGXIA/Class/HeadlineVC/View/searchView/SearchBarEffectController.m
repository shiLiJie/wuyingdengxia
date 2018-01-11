//
//  SearchBarEffectController.m
//  微信搜索模糊效果
//
//  Created by MAC on 17/4/1.
//  Copyright © 2017年 MyanmaPlatform. All rights reserved.
//

#import "SearchBarEffectController.h"
#import "Masonry.h"

#define kWindow [UIApplication sharedApplication].keyWindow
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface SearchBarEffectController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UISearchBar * searchBar;

@property(nonatomic , strong)UIView * backView;
@property(nonatomic , strong)UIView * headView;
@property(nonatomic , strong)NSMutableArray * serverDataArr;
@property(nonatomic , copy)  NSString *searchStr;
@property(nonatomic , strong)UIButton *cancelBtn;

@end

@implementation SearchBarEffectController
static NSString * const searchCell= @"searchCell";

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
         self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self setUpSearch];
        
    }
    return self;
}

#pragma mark - 添加控件 -
- (NSMutableArray *)serverDataArr
{
    if (_serverDataArr == nil) {
        _serverDataArr = [NSMutableArray array];
    }
    return _serverDataArr;
}
- (UIView *)headView
{
    if (_headView == nil) {
        _headView = [[UIView alloc]init];
        _headView.frame = CGRectMake(0, 0, kScreenW, 20);
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

-(UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        _cancelBtn.frame = CGRectMake(kScreenW-60, 20, 40, 40);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.frame = CGRectMake(0, 15, kScreenW-70, 44);
        // 去除searchbar上下两条黑线及设置背景
        _searchBar.barTintColor = [UIColor whiteColor];
        _searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
        _searchBar.layer.borderWidth = 0;
        [_searchBar sizeToFit];
        [_searchBar setPlaceholder:@"输入关键词"];
        [_searchBar setDelegate:self];
        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
        [_searchBar setTranslucent:NO];//设置是否透明
        [_searchBar setSearchBarStyle:UISearchBarStyleProminent];
        _searchBar.tintColor = [UIColor blackColor];
        //设置searchbar背景颜色
        for (UIView *subView in _searchBar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                    textField.font = [UIFont systemFontOfSize:12];
                    
                    //设置输入框边框的颜色
                    //                    textField.layer.borderColor = [UIColor blackColor].CGColor;
                    //                    textField.layer.borderWidth = 1;
                    
                    //设置输入字体颜色
                    //                    textField.textColor = [UIColor lightGrayColor];
                    
                    //设置默认文字颜色
                    //                    UIColor *color = [UIColor grayColor];
                    //                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索感兴趣的内容"
                    //                                                                                        attributes:@{NSForegroundColorAttributeName:color}]];
                    //                    //修改默认的放大镜图片
                    //                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
                    //                    imageView.backgroundColor = [UIColor clearColor];
                    //                    imageView.image = [UIImage imageNamed:@"gww_search_ misplaces"];
                    //                    textField.leftView = imageView;
                }
            }
        }
        
    }
    return _searchBar;
}
- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return  _backView;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
    
}
- (void)setEffectArray:(NSArray *)effectArray
{
    _effectArray = effectArray;
    
}
//添加各种view
- (void)setUpSearch
{

    [self addSubview:self.headView];
    [self addSubview:self.searchBar];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.backView];
    //添加searchbar后直接变成第一响应者
    [self.searchBar becomeFirstResponder];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_searchBar.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(kScreenH);
    }];
}

#pragma mark - 数据tableview代理方法 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [_backView addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    if (self.searchStr.length == 0) {
        return self.effectArray.count;
    }else{
        return self.serverDataArr.count;
    }
    

//    NSLog(@"%lu",(unsigned long)self.serverDataArr.count);
//    return self.serverDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:searchCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchCell];
    }
    if (self.searchStr.length == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.effectArray[indexPath.row]];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_serverDataArr[indexPath.row][@"nickName"]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchStr.length == 0){
        return 30;
    }else{
        return 46;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchStr.length == 0){
        [self.delegate didSelectKey:self.effectArray[indexPath.row]];
    }else{
        [self.delegate didSelectKey:self.serverDataArr[indexPath.row][@"nickName"]];
    }
    
//    [self hidden];
}

#pragma mark - searchbar搜索代理方法 -
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
//    [_backView addSubview:self.tableView];
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(_backView.mas_bottom);
//    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchStr = searchText;
    [self filterContentForSearchText:searchText scope:self.searchBar.scopeButtonTitles[1]];
}

#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容 -
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.effectArray.count; i++) {
        
        NSString * storeString = self.effectArray[i];
        NSRange storeRange = NSMakeRange(0, storeString.length);
        
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        
        if (foundRange.length) {
            
            NSDictionary *dic=@{@"nickName":storeString};
            [tempResults addObject:dic];
        }
    }
    [self.serverDataArr removeAllObjects];
    [self.serverDataArr addObjectsFromArray:tempResults];
    [self.tableView reloadData];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    [self hidden];
    
}
- (void)hidden
{
    [self removeFromSuperview];
}
- (void)show
{
    [UIView transitionWithView:kWindow duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [kWindow addSubview:self];
    } completion:^(BOOL finished) {
        finished = NO;
    }];
    
}
//取消按钮点击方法
-(void)cancelBtnClick{
    
    [self hidden];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.searchBar resignFirstResponder];
}

@end
