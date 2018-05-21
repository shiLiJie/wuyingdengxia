//
//  TakeCarView.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "TakeCarView.h"
#import "takeCarCityModel.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"

@interface TakeCarView()

//车站信息
@property (nonatomic, strong) NSArray *stateArr;



@end

@implementation TakeCarView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"TakeCarView" owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
    //获取乘车信息
    [self getTakeCarMessage];
    return self;
}
//左侧城市按钮点击
- (IBAction)zuoBtnClick:(UIButton *)sender {
    
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0;i<self.stateArr.count; i++) {
        takeCarCityModel *model = self.stateArr[i];
        [arr addObject:model.sta_name];
    }
    
    self.takeCarViewkBlcok(arr, YES, NO);
    
//    __weak typeof(self) weakSelf = self;
//    [BRStringPickerView showStringPickerWithTitle:@"性别" dataSource:arr defaultSelValue:@"" resultBlock:^(id selectValue) {
//
//        NSLog(@"%@",selectValue);
//
//    }];
}
//右侧城市按钮点击
- (IBAction)youBtnClick:(UIButton *)sender {
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0;i<self.stateArr.count; i++) {
        takeCarCityModel *model = self.stateArr[i];
        [arr addObject:model.sta_name];
    }
    
    self.takeCarViewkBlcok(arr, NO, YES);
}
//中间旋转按钮点击
- (IBAction)xuanzhuanBtnClick:(UIButton *)sender {
    
    NSArray *arr = @[@"1",@"2",@"3",@"4"];
//    self.takeCarViewkBlcok(arr);
}

//选择乘车日期按钮点击
- (IBAction)chooseCarBtnClick:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"乘车日期" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        weakSelf.chengcheDate.text = selectValue;
        weakSelf.addtakeCarDatekBlcok(selectValue);

    }];
}

/**
 车次选择

 @param sender sender description
 */
- (IBAction)chooseCheci:(UIButton *)sender {
    self.choosechecikBlcok();
}

/**
 备选车次

 @param sender sender description
 */
- (IBAction)chooseBeixuanCheci:(UIButton *)sender {
    self.choosebeicheciBlcok();
}

/**
 备注

 @param sender sender description
 */
- (IBAction)beizhu:(UIButton *)sender {

    self.beizhuBlcok();
}

//获取乘车信息
-(void)getTakeCarMessage{
    //列车站点列表
    
    if (self.stateArr.count > 0) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:@"http://apis.juhe.cn/train/station.list.php?key=ba31b08d5a33f101ba2193f2daaf3492"
                                                parameters:nil
                                                   success:^(id obj) {
//                                                       NSLog(@"%@",obj);
                                                       NSArray *arr = obj[@"result"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[takeCarCityModel takeCarCitylWithDict:dict]];
                                                           
                                                       }
                                                       weakSelf.stateArr= arrayM;
                                                       
                                                   } fail:^(NSError *error) {
                                                       
                                                   }];
//    "result":[
//    {
//        "sta_name":"北京北", "sta_ename":"beijingbei", "sta_code":"VAP"
//    }
    
//    [[HttpRequest shardWebUtil] getNetworkRequestURLString:@"http://apis.juhe.cn/train/s2swithprice?start=%E4%B8%8A%E6%B5%B7&end=%E8%8B%8F%E5%B7%9E&traintype=&key=ba31b08d5a33f101ba2193f2daaf3492"
//                                                parameters:nil
//                                                   success:^(id obj) {
//                                                       NSLog(@"%@",obj);
//
//    } fail:^(NSError *error) {
//
//    }];
}

-(NSArray *)stateArr{
    if (!_stateArr) {
        _stateArr = [[NSArray alloc] init];
    }
    return _stateArr;
}

@end
