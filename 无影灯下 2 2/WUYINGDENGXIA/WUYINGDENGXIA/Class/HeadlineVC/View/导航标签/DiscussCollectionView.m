//
//  DiscussCollectionView.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "DiscussCollectionView.h"
#import "DiscussCell.h"


static NSString *ID = @"DiscussCell";

@interface DiscussCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *modelArr;

@end

@implementation DiscussCollectionView
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        
        [self registerNib:[UINib nibWithNibName:[[DiscussCell class] description] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ID];
        
        self.modelArr = [[NSArray alloc] init];
        
        [self getDisNetData];
        
    }
    
    return self;
    
}
//讨论网络数据获取
-(void)getDisNetData{
    //请求后台热门讨论
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_hot_labelList?key_id=0"]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       NSArray *arr = obj[@"data"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[discussModel discussWithDict:dict]];
                                                           
                                                       }
                                                       self.modelArr= arrayM;
                                                       [self reloadData];
                                                   }
                                                      fail:^(NSError *error) {
                                                          
                                                      }];
}

//返回collection view里区(section)的个数，如果没有实现该方法，将默认返回1：

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

//返回指定区(section)包含的数据源条目数(number of items)，该方法必须实现：

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return  self.modelArr.count;
    
}

//返回某个indexPath对应的cell，该方法必须实现：

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DiscussCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    discussModel *model = [[discussModel alloc] init];
    model = self.modelArr[indexPath.row];
    
    cell.discussLab.text = model.key_dis_title;
    
    cell.layer.cornerRadius = 3;
    cell.contentView.layer.cornerRadius = 3.0f;
    cell.contentView.layer.borderWidth = 0.5f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.layer.shadowColor = RGBA(210, 208, 208,0.7).CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.layer.shadowRadius = 3.0f;
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath; 
    
    return cell;
    
}

//设定collectionView(指定区)的边距

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 20, 5,6);
}

//点击每个item实现的方法：

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    discussModel *model = [[discussModel alloc] init];
    model = self.modelArr[indexPath.row];
    

    if ([self.delegate1 respondsToSelector:@selector(clickDiscussToIndex:discussModel:)]) {
        [self.delegate1 clickDiscussToIndex:indexPath.row discussModel:model];
    }
    
}



@end
