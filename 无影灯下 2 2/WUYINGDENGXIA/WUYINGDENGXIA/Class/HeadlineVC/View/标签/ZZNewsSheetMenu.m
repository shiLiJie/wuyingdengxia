//
//  ZZNewsSheetMenu.m
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZZNewsSheetMenu.h"
#import "ZZNewsSheetItem.h"

#define KScreenWidth   [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

static CGFloat const kNewsBottomSpace = 100.0f;
static NSTimeInterval const kAnimationDuration = 0.25f;

@interface ZZNewsSheetMenu(){
    CGPoint _lastPoint;
    ZZNewsSheetItem *_currentItem;
    ZZNewsSheetItem  *_placeHolderItem;
}

@property(nonatomic,weak)UIScrollView  *newsSheetScrollView;
@property(nonatomic,weak)UIView *menuNavitem;
@property(nonatomic,weak)UIView  *mySubjectView;
@property(nonatomic,strong)UIView  *recommendSubjectView;

@property (nonatomic, strong) UIButton *searchBtn;



@property(nonatomic,strong)NSMutableArray<ZZNewsSheetItem *> *mySubjectItemArray;
@property(nonatomic,strong)NSMutableArray<ZZNewsSheetItem*> *recommendSubjectItemArray;




@end


@implementation ZZNewsSheetMenu
@synthesize mySubjectArray = _mySubjectArray;
@synthesize recommendSubjectArray = _recommendSubjectArray;

#pragma mark - Public
- (void)showNewsMenu{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGFloat statuHeight =  [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect rect;
    if (kDevice_Is_iPhoneX) {
        rect = CGRectMake(0, 88, KScreenWidth, KScreenHeight - statuHeight);
    }else{
        rect = CGRectMake(0, 64, KScreenWidth, KScreenHeight - statuHeight);
    }
    
    [UIView animateWithDuration:kAnimationDuration delay:0.05 usingSpringWithDamping:0.8 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        self.frame = rect;
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
}

- (void)showNewsMenu1{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGFloat statuHeight =  [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect rect;
    if (kDevice_Is_iPhoneX) {
        rect = CGRectMake(0, 88, KScreenWidth, KScreenHeight - statuHeight-100);
    }else{
        rect = CGRectMake(0, 64, KScreenWidth, KScreenHeight - statuHeight-100);
    }
    [UIView animateWithDuration:kAnimationDuration delay:0.05 usingSpringWithDamping:0.8 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        self.frame = rect;
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
}

-(void)updataItmeArray:(clossViewBlock)block{
    
    self.clossviewblock = block;
}

- (void)dismissNewsMenu{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.clossviewblock != nil) {
        self.clossviewblock(self.mySubjectArray);
    }
    
    CGFloat statuHeight =  [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect rect = CGRectMake(0, KScreenHeight, KScreenWidth, KScreenHeight - statuHeight);
    [UIView animateWithDuration:kAnimationDuration  animations:^{
        self.frame = rect;
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setHiddenAllCornerFlag:(BOOL)hiddenAllCornerFlag{
    _hiddenAllCornerFlag = hiddenAllCornerFlag;
    [self hiddenAllFlag:hiddenAllCornerFlag];
}

#pragma mark - 初始化配置
- (void)awakeFromNib{
    [super awakeFromNib];
    [self commit];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _placeHolderItem = [ZZNewsSheetItem new];
        
        self.ishuanyipi = NO;
        
        //用户投稿或者发表问题时自定义标签通知方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLabel:) name:@"ADDLABEL" object:nil];
        
        [self commit];
        
    }
    return self;
}

//用户投稿或者发表问题时自定义标签通知方法
-(void)addLabel:(NSNotification *)noti{
    
//    NSLog(@"%@",self.mySubjectArray);
    
    NSString *info = [noti object];
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    muArr = self.mySubjectArray;
    [muArr removeLastObject];
    [muArr addObject:info];
    self.mySubjectArray = muArr;
    
//    NSLog(@"%@",self.mySubjectArray);
}


+(instancetype)newsSheetMenu{
    CGFloat statuHeight =  [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect rect = CGRectMake(0, KScreenHeight, KScreenWidth, KScreenHeight - statuHeight);
    return [[self alloc]initWithFrame:rect];
}

+(instancetype)newsSheetMenu1{
    CGFloat statuHeight =  [UIApplication sharedApplication].statusBarFrame.size.height;
    if (kDevice_Is_iPhoneX) {
        CGRect rect = CGRectMake(0, 105, KScreenWidth, KScreenHeight - statuHeight-145);
        return [[self alloc]initWithFrame:rect];
    }else{
        CGRect rect = CGRectMake(0, 75, KScreenWidth, KScreenHeight - statuHeight-120);
        return [[self alloc]initWithFrame:rect];
    }
    
    
}
- (void)commit{
    [self newsSheetScrollView];
    [self setUp];
}
- (void)setUp{
    

    
    [self setMainMemuNavaitem];
    
    [self setMySubject];
    [self setRecommentSubject];

    if (self.choosetype == postType){
        [self nodefaultConfing];
    }else{
        [self defaultConfing];
    }
    
    if (self.mySubjectArray.count <=0 || self.recommendSubjectArray <=0)
        return;
}

- (void)defaultConfing{
    self.hiddenAllCornerFlag = YES;
}

- (void)nodefaultConfing{
    self.hiddenAllCornerFlag = NO;
}
- (void)setMainMemuNavaitem{
    UIView * menuNav = [[UIView alloc]init];
    menuNav.backgroundColor = [UIColor whiteColor];
    [self.newsSheetScrollView addSubview:menuNav];
    self.menuNavitem = menuNav;
    
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
//    [closeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [closeButton setImage:GetImage(@"cha1") forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(dismissNewsMenu) forControlEvents:UIControlEventTouchUpInside];
//    closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [closeButton setFont:[UIFont boldSystemFontOfSize:15]];
    [closeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [menuNav addSubview:closeButton];
    self.closeMenuButton = closeButton;
    
    UIButton * editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitle:@"完成" forState:UIControlStateSelected];
    [editButton setTitleColor:RGB(45, 163, 255) forState:UIControlStateNormal];
    [editButton setTitleColor:RGB(45, 163, 255) forState:UIControlStateSelected];
    [editButton addTarget:self action:@selector(editMenu:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setFont:[UIFont boldSystemFontOfSize:15]];
    editButton.selected = !self.hiddenAllCornerFlag;
    [menuNav addSubview:editButton];
    self.editMenuButton = editButton;
    

}
//设置已有标签
- (void)setMySubject{
    UIView *mySubjectView = [[UIView alloc]initWithFrame:CGRectZero];
//    UIView *mySubjectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 100)];
    mySubjectView.backgroundColor = [UIColor whiteColor];
    [self.newsSheetScrollView addSubview:mySubjectView];
    self.mySubjectView = mySubjectView;
    
    UILabel *lab = [[UILabel alloc]init];
//    lab.text = @"导航设置";
    lab.textColor = [UIColor grayColor];
    lab.font = [UIFont boldSystemFontOfSize:12];
    [mySubjectView addSubview:lab];
    self.myTitleLab = lab;
    
    [self.mySubjectItemArray removeAllObjects];
    for (int i = 0; i<self.mySubjectArray.count; i++) {
        ZZNewsSheetItem *item = [[ZZNewsSheetItem alloc]init];
        item.itemTitle = self.mySubjectArray[i];
//        if (self.ishuanyipi) {
//            item.flagType = ZZCornerFlagTypeNone;
//        }else{
            item.flagType = ZZCornerFlagTypeDelete;
//        }
    
        [mySubjectView addSubview:item];
        [self.mySubjectItemArray addObject:item];
        [item setLongPressBlock:^(UILongPressGestureRecognizer *ges) {
            [self itemLongPress:ges];
        }];
        [item setItemCloseBlock:^(ZZNewsSheetItem *item) {
            [self updateMoveItem:item];
        }];
    }
}
//设置推荐标签
- (void)setRecommentSubject{
    
    
    UIView *recommendSubjectView = [[UIView alloc]initWithFrame:CGRectZero];
    recommendSubjectView.backgroundColor = [UIColor whiteColor];
    [self.newsSheetScrollView addSubview:recommendSubjectView];
    self.recommendSubjectView = recommendSubjectView;

    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"推荐导航";
    lab.textColor = RGB(51, 51, 51);
    lab.font = [UIFont boldSystemFontOfSize:15];
    [recommendSubjectView addSubview:lab];
    self.recommentTitleLab = lab;
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:GetImage(@"huanyipi") forState:UIControlStateNormal];
    btn.frame = CGRectMake(kScreen_Width-15-62, 7, 62, 15);
    [btn addTarget:self action:@selector(huanyipi) forControlEvents:UIControlEventTouchUpInside];
    [recommendSubjectView addSubview:btn];

    [self layoutSubviews];
    [self.recommendSubjectItemArray removeAllObjects];
    for (int i = 0; i<self.recommendSubjectArray.count; i++) {
        ZZNewsSheetItem *item = [[ZZNewsSheetItem alloc]init];
        item.itemTitle = self.recommendSubjectArray[i];
        item.longGestureEnable = NO;
//        if (self.ishuanyipi) {
//            item.flagType = ZZCornerFlagTypeAddition;
//        }else{
            item.flagType = ZZCornerFlagTypeAddition;
//        }
        [recommendSubjectView addSubview:item];
        [self.recommendSubjectItemArray addObject:item];
        [item setLongPressBlock:^(UILongPressGestureRecognizer *ges) {
            [self itemLongPress:ges];
        }];
        [item setItemCloseBlock:^(ZZNewsSheetItem *item) {
            [self updateMoveItem:item];
        }];
    }
}

//换一批
-(void)huanyipi{
    
    
    
    
    
    
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_labels_rand?limit=10&type=%@",self.pageOrqa]]
                                                 parameters:nil
                                                    success:^(id obj) {

                                                        NSMutableArray *labArr = [[NSMutableArray alloc] init];
                                                        NSArray *arr = obj[@"data"];
                                                        NSDictionary *dict = @{
                                                                               @"label_name":@""
                                                                               };
                                                        for (dict in arr) {
                                                            [labArr addObject:dict[@"label_name"]];
                                                        }

                                                        //    self.recommentBlock();

                                                        self.ishuanyipi = YES;
                                                        self.recommendSubjectArray = labArr;

                                                        //    [self setRecommentSubject];

                                                        //    self.hiddenAllCornerFlag = YES; 93
                                                        [self layoutSubviews];
                                                    }
                                                       fail:^(NSError *error) {

                                                       }];
    

//    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_user_key?user_id=10003&key_id=93"] parameters:nil success:^(id obj) {
//
//        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
//
//            [MBProgressHUD showSuccess:obj[@"msg"]];
//        }else{
//            [MBProgressHUD showError:obj[@"msg"]];
//        }
//    } fail:^(NSError *error) {
//
//    }];
    
    
}


/**
 投稿或提问时点击搜索标签
 */
-(void)searchSheetLab{
    self.searchBlock();
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.choosetype == postType) {
        //投稿或者提问时添加标签才会出现的框
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, kScreen_Width-80, 35)];
        [button setTitle:@"输入想要搜索标签的关键词" forState:UIControlStateNormal];
        [button setTitleColor:RGB(173, 173, 173) forState:UIControlStateNormal];
        [button setBackgroundColor:RGB(245, 245, 245)];
        [button setImage:GetImage(@"Fill 1") forState:UIControlStateNormal];
        button.titleLabel.font = SYSTEMFONT(12);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.layer.cornerRadius = 17.5;//半径大小
        button.layer.masksToBounds = YES;//是否切割
        [button addTarget:self action:@selector(searchSheetLab) forControlEvents:UIControlEventTouchUpInside];
        self.searchBtn = button;
        [self.newsSheetScrollView addSubview:self.searchBtn];
    }

    self.newsSheetScrollView.frame = self.bounds;
    CGFloat navitemHeight = 30.0f;
    
    if (self.choosetype == postType){
        self.menuNavitem.frame = CGRectMake(0, 45, self.bounds.size.width, navitemHeight);
        self.closeMenuButton.frame = CGRectZero;
        self.editMenuButton.frame = CGRectMake(self.bounds.size.width - 60, 0,50, self.menuNavitem.bounds.size.height);
    }else{
        self.menuNavitem.frame = CGRectMake(0, 14, self.bounds.size.width, navitemHeight);
        self.closeMenuButton.frame = CGRectMake(self.bounds.size.width - 60, 0,50, self.menuNavitem.bounds.size.height);
        self.editMenuButton.frame = CGRectMake(self.bounds.size.width - 60 - 50, 0,50, self.menuNavitem.bounds.size.height);
    }
    

    
    UILabel *lab = [[UILabel alloc] init];
    if (self.choosetype == postType){
        lab.text = @"已选标签";
    }else{
        lab.text = @"我的导航";
    }
    
    lab.textColor = RGB(51, 51, 51);
    lab.font = [UIFont boldSystemFontOfSize:15];
    CGSize size = [ZZNewsSheetConfig defaultCofing].sheetItemSize;
    NSInteger column = [ZZNewsSheetConfig defaultCofing].sheetMaxColumn;
    CGFloat margin = 1.0 * (KScreenWidth - size.width * column)/(column + 1);
    lab.frame = CGRectMake(margin, 0, 100, self.menuNavitem.bounds.size.height);
    
    self.myTitleLab1 = lab;
    [self.menuNavitem addSubview:self.myTitleLab1];
    
    [self updateAllView];
}


#pragma mark - 私有

- (void)updateMoveItem:(ZZNewsSheetItem *)item{
    if (item.flagType == ZZCornerFlagTypeDelete) {
        [self moveItemFromMySubjectToRecommend:item];
    }else if(item.flagType == ZZCornerFlagTypeAddition){
        [self moveItemFromRecommendToMySubject:item];
    }
    
    if ([ZZNewsSheetConfig defaultCofing].isHiddenWhenHasNoneRecomment) {
          self.recommentTitleLab.hidden = !self.recommendSubjectArray.count;
    }
    
    CGFloat animationDuration = kAnimationDuration;
    if (self.mySubjectArray.count <= 0 || self.recommendSubjectArray.count <= 0) {
        animationDuration =0.0f;
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self updateAllView];
    }];
}

- (void)moveItemFromMySubjectToRecommend:(ZZNewsSheetItem *)item{
    if (self.mySubjectItemArray.count == 1) {
        NSLog(@"最少留一个");
        return;
    }
    
    [self.mySubjectItemArray removeObject:item];
    [self.mySubjectArray removeObject:item.itemTitle];
    
    item.longGestureEnable = YES;
    item.flagType = ZZCornerFlagTypeAddition;
    
    [self.recommendSubjectItemArray addObject:item];
    [self.recommendSubjectArray addObject:item.itemTitle];
    
    if (item.superview) {
        [item removeFromSuperview];
        [self.recommendSubjectView addSubview:item];
    }
}
- (void)moveItemFromRecommendToMySubject:(ZZNewsSheetItem*)item{
    [self.recommendSubjectItemArray removeObject:item];
    [self.recommendSubjectArray removeObject:item.itemTitle];
    
    item.longGestureEnable = YES;
    item.flagType = ZZCornerFlagTypeDelete;
    
    [self.mySubjectItemArray addObject:item];
    [self.mySubjectArray addObject:item.itemTitle];
    
    if (item.superview) {
        [item removeFromSuperview];
        [self.mySubjectView addSubview:item];
    }
}

- (void)setUpGrimViews{
    CGSize size = [ZZNewsSheetConfig defaultCofing].sheetItemSize;
    NSInteger column = [ZZNewsSheetConfig defaultCofing].sheetMaxColumn;
    CGFloat margin = 1.0 * (KScreenWidth - size.width * column)/(column + 1);
    CGFloat itemHeight = size.height;
    CGFloat titleHeight = 30.0f;
    CGFloat itemWidth = size.width;
    
    [self.mySubjectItemArray enumerateObjectsUsingBlock:^(ZZNewsSheetItem *  _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        NSInteger currentRow = i / column ;
        NSInteger currentColumn = i % column;
        CGFloat orx = margin + currentColumn *margin + currentColumn*itemWidth;
//        CGFloat ory =titleHeight + margin + currentRow*margin + currentRow*itemHeight;
        CGFloat ory =margin/2 + currentRow*margin + currentRow*itemHeight;
         obj.frame = CGRectMake(orx, ory, itemWidth, itemHeight);
    }];
}

- (void)updateAllView{
    
    CGSize size = [ZZNewsSheetConfig defaultCofing].sheetItemSize;
    NSInteger column = [ZZNewsSheetConfig defaultCofing].sheetMaxColumn;
    CGFloat margin = 1.0 * (KScreenWidth - size.width * column)/(column + 1);
    CGFloat itemHeight = size.height;
    CGFloat titleHeight = 30.0f;
    CGFloat itemWidth = size.width;

    self.myTitleLab.frame = CGRectMake(margin, 0,KScreenWidth-2*margin, titleHeight);
    CGFloat mySubRow = (self.mySubjectItemArray.count-1) / column + 1;
    mySubRow = MAX(mySubRow, 0);
    for (NSInteger i = 0;i<self.mySubjectItemArray.count;i++) {
        ZZNewsSheetItem *item = self.mySubjectItemArray[i];
//        if (self.ishuanyipi) {
//            item.flagType = ZZCornerFlagTypeNone;
//        }else{
//            item.flagType = ZZCornerFlagTypeDelete;
//        }
        NSInteger currentRow = i / column ;
        NSInteger currentColumn = i % column;
        CGFloat orx = margin + currentColumn *margin + currentColumn*itemWidth;
//        CGFloat ory = titleHeight + margin + currentRow*margin + currentRow*itemHeight;
        CGFloat ory =margin/2 + currentRow*margin + currentRow*itemHeight;
        item.frame = CGRectMake(orx, ory, itemWidth, itemHeight);
    }

    CGFloat mySubHeight = titleHeight + 2 * margin + mySubRow * itemHeight + margin * (mySubRow - 1);
    self.mySubjectView.frame = CGRectMake(0,CGRectGetMaxY(self.menuNavitem.frame), KScreenWidth, mySubHeight);
    if (self.mySubjectItemArray.count <= 0) {
        mySubHeight = 100.0f;
        self.mySubjectView.frame = CGRectMake(0,CGRectGetMaxY(self.menuNavitem.frame), KScreenWidth, mySubHeight);
    }
    
    
    CGFloat recSubRow = (self.recommendSubjectItemArray.count-1) / column + 1;
    recSubRow = MAX(recSubRow, 0);
    for (NSInteger i = 0;i<self.recommendSubjectItemArray.count;i++) {
        ZZNewsSheetItem *item = self.recommendSubjectItemArray[i];
        NSInteger currentRow = i / column ;
        NSInteger currentColumn = i % column;
        CGFloat orx = margin + currentColumn *margin + currentColumn*itemWidth;
        CGFloat ory =titleHeight/2 + margin + currentRow*margin + currentRow*itemHeight;
        item.frame = CGRectMake(orx, ory, itemWidth, itemHeight);
    }
    CGFloat recSubHeight =titleHeight + 2 * margin+ recSubRow * itemHeight + margin * (recSubRow - 1);
    self.recommentTitleLab.frame = self.myTitleLab.frame;
    CGFloat recOry = CGRectGetMaxY(self.mySubjectView.frame);
    
    self.recommendSubjectView.frame = CGRectMake(0, recOry, KScreenWidth, recSubHeight);
    if (self.recommendSubjectItemArray.count <= 0) {
        recSubHeight = titleHeight;
        self.recommendSubjectView.frame = CGRectMake(0, recOry, KScreenWidth, titleHeight);
    }
    
    CGFloat scHeight = CGRectGetMaxY(self.recommendSubjectView.frame);
    self.newsSheetScrollView.contentSize = CGSizeMake(0, scHeight + kNewsBottomSpace);
    
}
- (void)hiddenAllFlag:(BOOL)hidden{
    for (UIView * mv in self.mySubjectView.subviews) {
        if ([mv isKindOfClass:[ZZNewsSheetItem class]]) {
            ZZNewsSheetItem * item = (ZZNewsSheetItem *)mv;
            item.cornerFlagHidden = hidden;
//            if (self.ishuanyipi) {
//                item.flagType = ZZCornerFlagTypeNone;
//            }else{
//                item.flagType = ZZCornerFlagTypeDelete;
//            }
            
            
        }
    }
    
    for (UIView * mv in self.recommendSubjectView.subviews) {
        if ([mv isKindOfClass:[ZZNewsSheetItem class]]) {
            ZZNewsSheetItem * item = (ZZNewsSheetItem *)mv;
            item.cornerFlagHidden = hidden;
        }
    }
}

#pragma mark -  LazyLoading
- (UIScrollView *)newsSheetScrollView{
    if (_newsSheetScrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        _newsSheetScrollView = scrollView;
    }
    return _newsSheetScrollView;
}

- (NSMutableArray *)recommendSubjectArray{
    if (_recommendSubjectArray == nil) {
        _recommendSubjectArray = [NSMutableArray array];
    }
    return _recommendSubjectArray;
}
- (NSMutableArray *)mySubjectArray{
    if (_mySubjectArray == nil) {
        _mySubjectArray = [NSMutableArray array];
    }
    return _mySubjectArray;
}

- (void)setMySubjectArray:(NSMutableArray *)mySubjectArray{
    _mySubjectArray = mySubjectArray;
    [self.newsSheetScrollView.subviews sortedArrayUsingSelector:@selector(removeFromSuperview)];
    [self setUp];
}

- (void)setRecommendSubjectArray:(NSMutableArray *)recommendSubjectArray{
    _recommendSubjectArray = recommendSubjectArray;
    [self.newsSheetScrollView.subviews sortedArrayUsingSelector:@selector(removeFromSuperview)];
    [self setUp];
}

- (NSMutableArray *)recommendSubjectItemArray{
    if (_recommendSubjectItemArray == nil) {
        _recommendSubjectItemArray = [NSMutableArray array];
    }
    return _recommendSubjectItemArray;
}
- (NSMutableArray *)mySubjectItemArray{
    if (_mySubjectItemArray == nil) {
        _mySubjectItemArray = [NSMutableArray array];
    }
    return _mySubjectItemArray;
}

#pragma mark - 事件
- (void)editMenu:(UIButton*)sender{
    self.ishuanyipi = NO;
    sender.selected = !sender.selected;
    self.hiddenAllCornerFlag = !sender.selected;
    NSString * title = sender.selected ? @"完成":@"编辑";
    [sender setTitle:title forState:UIControlStateNormal];
}

- (void)itemLongPress:(UILongPressGestureRecognizer *)gesture{
    ZZNewsSheetItem *item = (ZZNewsSheetItem *)gesture.view;
    CGPoint point = [gesture locationInView:self.mySubjectView];
    
    if (_currentItem && ![_currentItem isEqual:item]) {
        return;
    }
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self.mySubjectView bringSubviewToFront:item];
        [self.newsSheetScrollView bringSubviewToFront:self.mySubjectView];
        item.transform = CGAffineTransformMakeScale(1.2, 1.2);
        item.alpha = 0.8f;
        _lastPoint = point;
        _currentItem = item;
        NSInteger index = [self.mySubjectItemArray indexOfObject:item];
        [self.mySubjectItemArray  removeObject:item];
        [self.mySubjectItemArray  insertObject:_placeHolderItem atIndex:index];
    }
    
    CGRect tempFrame = item.frame;
    tempFrame.origin.x += point.x - _lastPoint.x;
    tempFrame.origin.y += point.y - _lastPoint.y;
    item.frame = tempFrame;
    _lastPoint = point;
    
    CGPoint bPoint = [gesture locationInView:self.recommendSubjectView];
    if (CGRectContainsPoint(self.recommendSubjectView.bounds, bPoint)) {
        [self caculatorEndPositon];
        [self updateMoveItem:item];
        return;
    }
    
    
    [self.mySubjectItemArray enumerateObjectsUsingBlock:^(ZZNewsSheetItem *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, point) && obj != item) {
            
            [self.mySubjectItemArray removeObject:_placeHolderItem];
            [self.mySubjectItemArray insertObject:_placeHolderItem atIndex:idx];
            
            
            if (obj.itemTitle != nil) {
                [self.mySubjectArray removeObject:item.itemTitle];
                [self.mySubjectArray insertObject:item.itemTitle atIndex:idx];
            }

            *stop = YES;
            
            [UIView animateWithDuration:kAnimationDuration animations:^{
                [self setUpGrimViews];
            }];
        }
    }];
    
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self caculatorEndPositon];
    }
}

- (void)caculatorEndPositon{
    long index = [self.mySubjectItemArray indexOfObject:_placeHolderItem];
    [self.mySubjectItemArray removeObject:_placeHolderItem];
    [self.mySubjectItemArray insertObject:_currentItem atIndex:index];
    
   
    [UIView animateWithDuration:kAnimationDuration animations:^{
        _currentItem.transform = CGAffineTransformIdentity;
        _currentItem.alpha = 1.0f;
        [self setUpGrimViews];
    } completion:^(BOOL finished) {
        _currentItem = nil;
        _lastPoint = CGPointZero;
    }];
    
}


-(void)updateNewSheetConfig:(newsSheetBlock)block{
    ZZNewsSheetConfig *cofig = [ZZNewsSheetConfig defaultCofing];
    if (block) {
         block(cofig);
    }

    [self.newsSheetScrollView.subviews sortedArrayUsingSelector:@selector(removeFromSuperview)];
     [self setUp];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
@end
