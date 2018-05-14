//
//  AnswerViewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"
#import "QusetionModel.h"

typedef enum _queschooseType{
    
    questionType = 0,//标题类型
    myquestionType    //内容类型
    
} queschooseType;

@interface AnswerViewController : BaseViewController

@property (nonatomic, strong) QusetionModel *questionModel;

@property (nonatomic, assign) queschooseType choosetype;

-(void)setUpUi:(queschooseType)choosetype;


@end
