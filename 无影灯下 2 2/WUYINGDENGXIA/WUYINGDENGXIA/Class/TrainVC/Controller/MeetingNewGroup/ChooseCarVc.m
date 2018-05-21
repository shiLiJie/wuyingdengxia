//
//  ChooseCarVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "ChooseCarVc.h"
#define KCNSSTRING_ISEMPTY(str) (str == nil || [str isEqual:[NSNull null]] || str.length <= 0)

@interface ChooseCarVc ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>
{
    
    UISearchController *seachVC;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;



@property (nonatomic,retain)NSArray *dataArray;
@property (nonatomic,retain)NSMutableArray *dataArray1;
@property (nonatomic,retain)NSMutableArray *littleArray;
@property (nonatomic,retain)NSDictionary *allKeysDict;

@end

@implementation ChooseCarVc

-(void)viewWillDisappear:(BOOL)animated{
    seachVC.searchBar.hidden = YES;
    [seachVC.searchBar resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        [self setUpData];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            [self CreateUI];
        });
    });
    
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"请选择车站"];
}

-(UIColor*)set_colorBackground{
    return [UIColor whiteColor];
}

-(BOOL)hideNavigationBottomLine{
    return YES;
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{
    seachVC.searchBar.hidden = YES;
    [seachVC.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 私有方法 -
-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}


/**
 设置UI数据源
 */
-(void)setUpData{
    self.dataArray = [[NSArray alloc]init];
    //    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"]];
    
    self.allKeysDict =  [self createCharacter:self.zhanArr.mutableCopy];
    
    //    self.dataArray = @[@"北京",@"上海",@"广州",@"深圳",@"北京北"];
    //    _allKeysDict =  [self createCharacter:self.dataArray1];
    //    NSLog(@"_allKeysDict------%@",_allKeysDict);
    
    self.dataArray = [self.allKeysDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *letter1 = obj1;
        NSString *letter2 = obj2;
        if (KCNSSTRING_ISEMPTY(letter2)) {
            return NSOrderedDescending;
        }else if ([letter1 characterAtIndex:0] < [letter2 characterAtIndex:0]) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
}

- (void)CreateUI
{
    seachVC = [[UISearchController alloc]initWithSearchResultsController:nil];
    seachVC.searchResultsUpdater = self;
    seachVC.dimsBackgroundDuringPresentation = false;
    seachVC.searchBar.showsCancelButton = YES;
    seachVC.hidesNavigationBarDuringPresentation = NO;
    UIButton *canceLBtn = [seachVC.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@" 取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    seachVC.searchBar.placeholder= @"搜索车站";
    UIImageView *barImageView = [[[seachVC.searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    barImageView.layer.borderWidth = 1;
    
    UIImage* searchBarBg = [ChooseCarVc GetImageWithColor:RGB(181, 181, 181) andHeight:32.0f];
    //设置背景图片
    [seachVC.searchBar setBackgroundImage:searchBarBg];
    //设置背景色
    [seachVC.searchBar setBackgroundColor:RGB(181, 181, 181)];
    //设置文本框背景
//    [seachVC.searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    
    [seachVC.searchBar sizeToFit];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.sectionIndexColor = [UIColor blackColor];
    self.tableview.tableHeaderView = seachVC.searchBar;
    self.tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.tableview];
    
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

- (NSDictionary *)createCharacter:(NSMutableArray *)strArr
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *string in strArr) {
        
        if ([string length]) {
            NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:string];
            
            if (CFStringTransform((__bridge CFMutableStringRef)mutableStr, 0, kCFStringTransformMandarinLatin, NO)) {
            }
            if (CFStringTransform((__bridge CFMutableStringRef)mutableStr, 0, kCFStringTransformStripDiacritics, NO)) {
                NSString *str = [NSString stringWithString:mutableStr];
                str = [str uppercaseString];
                NSMutableArray *subArray = [dict objectForKey:[str substringToIndex:1]];
                if (!subArray) {
                    subArray = [NSMutableArray array];
                    [dict setObject:subArray forKey:[str substringToIndex:1]];
                }
                [subArray addObject:string];
            }
        }
    }
    return dict;
}

//创建右侧索引表，返回需要显示的索引表数组

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //
    //    if (!seachVC.active) {
    return self.dataArray.count;
    //    }else{
    //        return 1;
    //
    //    }
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView {
    //    if (!seachVC.active) {
    return self.dataArray;
    //    }else{
    //        return _littleArray;
    //    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (!seachVC.active) {
    return [(NSArray*)self.allKeysDict[self.dataArray[section]] count];
    //    }else{
    //
    //        if (_littleArray.count!=0) {
    //             return [(NSArray*)self.allKeysDict[self.littleArray[section]] count];
    //        }else{
    //
    //            return 0;
    //        }
    //
    //    }
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //    if (!seachVC.active) {
    return self.dataArray[section];
    //    }else{
    //
    //        return nil;
    //    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //    if (!seachVC.active) {
    cell.textLabel.text = [self.allKeysDict[self.dataArray[indexPath.section]] objectAtIndex:indexPath.row];
    //    }else{
    //
    //        cell.textLabel.text = [self.allKeysDict[self.littleArray[indexPath.section]] objectAtIndex:indexPath.row];
    //    }
    //
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.allKeysDict[self.dataArray[indexPath.section]] objectAtIndex:indexPath.row];
    
    self.choosecarViewkBlcok([self.allKeysDict[self.dataArray[indexPath.section]] objectAtIndex:indexPath.row]);
    
    seachVC.searchBar.hidden = YES;
    [seachVC.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
    
//    NSLog(@"%@",[self.allKeysDict[self.dataArray[indexPath.section]] objectAtIndex:indexPath.row]);
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    __weak typeof(self) weakSelf = self;
    //    [self.littleArray removeAllObjects];
    
    //    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchController.searchBar.text];
    //    self.littleArray = [[self.dataArray filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    //    NSLog(@"--------------------%@",_littleArray);
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [self.tableView reloadData];
    //    });
        
       
   

    //    NSLog(@"%@",self.zhanArr);
    
    

//    if ([searchController.searchBar.text isEqualToString:@""]) {
//
//        NSLog(@"searchController.searchBar.text-------%@",searchController.searchBar.text);
//
//        self.tableview.userInteractionEnabled = NO;
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//            self.zhanArr = self.zhanArrall;
//            [self setUpData];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //回调或者说是通知主线程刷新，
////                [self.tableview reloadData];
//                self.tableview.userInteractionEnabled = YES;
//            });
//        });
//
//    }else{
    if (!kStringIsEmpty(searchController.searchBar.text)) {
        
        NSPredicate *searchPredicate11 = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchController.searchBar.text];
        self.tableview.userInteractionEnabled = NO;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            weakSelf.zhanArr = [[weakSelf.zhanArr filteredArrayUsingPredicate:searchPredicate11] mutableCopy];
            [weakSelf setUpData];
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [weakSelf.tableview reloadData];
                weakSelf.tableview.userInteractionEnabled = YES;
                self.zhanArr = self.zhanArrall;
            });
        });
    }
    
        
        
        
//    }
    
    
    //    NSPredicate *searchPredicate1 = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchController.searchBar.text];
    //    self.littleArray = [[self.zhanArr filteredArrayUsingPredicate:searchPredicate1] mutableCopy];
    //    NSLog(@"--------------------%@",_littleArray);
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [self.tableView reloadData];
    //    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
