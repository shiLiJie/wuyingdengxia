//
//  SearchSheetLabVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "SearchSheetLabVc.h"
#import "SearchSheetLabCell.h"

#import "lableModel2.h"

@interface SearchSheetLabVc ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) SearchSheetLabCell *cell;

//返回给上个视图的标签数组
@property (nonatomic, strong) NSMutableArray *searchLabaArr;
//当前页搜索到的标签数组
@property (nonatomic, strong) NSMutableArray *labaArr;
//多选选中的行
@property (strong, nonatomic) NSMutableArray  *selectIndexs;



@end

@implementation SearchSheetLabVc

-(void)viewWillDisappear:(BOOL)animated{
    
    NSMutableArray *indexArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.selectIndexs.count; i ++) {
        NSIndexPath *indext = self.selectIndexs[i];
        [indexArr addObject:[NSString stringWithFormat:@"%ld",(long)indext.row]];
    }
    
    NSLog(@"indexArr -------   %@",indexArr);
    
    for (int i = 0; i < indexArr.count; i ++) {
        [self.searchLabaArr addObject:self.labaArr[i]];
    }
    
    NSLog(@"searchLabaArr --   %@",self.searchLabaArr);
    
    //取消视图时候回传搜索选中的标签数组
    self.dismissviewBlock(self.searchLabaArr);
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.searchBar becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchLabaArr = [[NSMutableArray alloc] init]; 
    self.labaArr = [[NSMutableArray alloc] init];
    self.selectIndexs = [[NSMutableArray alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    [self addSearchBar];
  
}

+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

//添加搜索框
-(void)addSearchBar{
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,kScreen_Width-130,30)];
    
    //UIColor *color =  self.navigationController.navigationBar.tintColor;
    //[titleView setBackgroundColor:color];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width - 130, 30)];
    self.searchBar.placeholder = @"输入想要搜索标签的关键词";
    self.searchBar.layer.cornerRadius = 15;
    self.searchBar.layer.masksToBounds = YES;
    
    //设置背景图是为了去掉上下黑线
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    
    UIImage* searchBarBg = [SearchSheetLabVc GetImageWithColor:RGB(245, 245, 245) andHeight:32.0f];
    //设置背景图片
    [self.searchBar setBackgroundImage:searchBarBg];
    
    // 设置SearchBar的主题颜色
    self.searchBar.barTintColor = RGB(245, 245, 245);
    //设置背景色
    [self.searchBar setBackgroundColor:RGB(245, 245, 245)];
    // 修改cancel
    self.searchBar.barStyle = UIBarStyleDefault;
    self.searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    //self.searchBar.searchBarStyle = UISearchBarStyleMinimal;//没有背影，透明样式
    self.searchBar.delegate = self;
    
//    self.searchBar.showsCancelButton = YES;
//
//    // 修改cancel
////    self.searchBar.showsSearchResultsButton=YES;
//
//    UIButton *canceLBtn = [self.searchBar valueForKey:@"cancelButton"];
//    [canceLBtn setTitle:@" 取消" forState:UIControlStateNormal];
//    [canceLBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//
//    //5. 设置搜索Icon
//    [self.searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    /*这段代码有个特别的地方就是通过KVC获得到UISearchBar的私有变量
     
          searchField（类型为UITextField），设置SearchBar的边框颜色和圆角实际上也就变成了设置searchField的边框颜色和圆角，你可以试试直接设置SearchBar.layer.borderColor和cornerRadius，会发现这样做是有问题的。*/
    
    //一下代码为修改placeholder字体的颜色和大小
    UITextField*searchField = [_searchBar valueForKey:@"_searchField"];
    
    //2. 设置圆角和边框颜色
    if(searchField) {
        
        [searchField setBackgroundColor:[UIColor clearColor]];
        
        //        searchField.layer.borderColor = [UIColor colorWithRed:49/255.0f green:193/255.0f blue:123/255.0f alpha:1].CGColor;
        
        //        searchField.layer.borderWidth = 1;
        
        //        searchField.layer.cornerRadius = 23.0f;
        
        //        searchField.layer.masksToBounds = YES;
        
        // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
        [searchField setValue:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        
    }
    
    // 输入文本颜色
    searchField.textColor= RGB(51, 51, 51);
    searchField.font= [UIFont systemFontOfSize:15];
    
    // 默认文本大小
    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    
    //只有编辑时出现出现那个叉叉
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [titleView addSubview:self.searchBar];
    //Set to titleView
    self.navigationItem.titleView = titleView;
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"cha1") forState:UIControlStateNormal];
    return btn;
}
//左上返回按钮
-(void)left_button_event:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

//右侧按钮设置点击
-(UIButton *)set_rightButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(kScreen_Width-44, 0, 44, 60);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(30, 150, 255) forState:UIControlStateNormal];
    
    return btn;
}

//右侧确定按钮
-(void)right_button_event:(UIButton *)sender{
    

    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - tableviewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.labaArr.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"SearchSheetLabCell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    self.cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchSheetLabCell" owner:nil options:nil] firstObject];

    
    lableModel2 *model = self.labaArr[indexPath.row];
    self.cell.labelName.text = model.label_name;
    self.cell.tag = indexPath.row;
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cell.accessoryType = UIAccessibilityTraitNone;
    for (NSIndexPath *index in _selectIndexs) {
        if (indexPath == index) {
            self.cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.cell.selecttype = noSelect;
//            [self.cell changeCellWithSelectType];
        }
    }
    
    return self.cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchSheetLabCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) { //如果为选中状态
        cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
        cell.selecttype = noSelect;
//        [cell changeCellWithSelectType];
       
        [_selectIndexs removeObject:indexPath]; //数据移除
    }else { //未选中
        cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
        [_selectIndexs addObject:indexPath]; //添加索引数据到数组
        cell.selecttype = isSelect;
//        [cell changeCellWithSelectType];
    }
    
//    if (self.cell.selecttype == noSelect) {
//
//        self.cell.selecttype = isSelect;
//        [self.cell changeCellWithSelectType];
//
//    }else{
//        self.cell.selecttype = noSelect;
//        [self.cell changeCellWithSelectType];
//
//    }
}

#pragma mark - 搜索框代理方法 -

/**
 根据搜索关键词搜索标签

 @param key 关键词
 */
-(void)searchWithKey:(NSString *)key
{
    NSString *searchTerm = key;
    NSString *url = [BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_article_labelList_bykey?key=%@",searchTerm]];
    NSString  *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    __weak typeof(self) weakSelf = self;
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:urlStr
                                                parameters:nil
                                                   success:^(id obj) {
                                                       
                                                       NSArray *arr = obj[@"data"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[lableModel2 lable2WithDict:dict]];
                                                           
                                                       }
                                                       weakSelf.labaArr= arrayM;
                                                       
                                                       [weakSelf.tableView reloadData];
                                                       
                                                   }
                                                      fail:^(NSError *error) {
                                                          
                                                      }];
    
}

//点击键盘上的search按钮时调用

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchWithKey:searchBar.text];
}

//输入文本实时更新时调用

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
 
        [self.labaArr removeAllObjects];
        [self.tableView reloadData];
        
        return;
    }
    
    
    [self searchWithKey:searchBar.text];
}

//点击搜索框时调用

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.tableView reloadData];
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
