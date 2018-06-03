//
//  SearchSheetLabCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _selectType{
    
    isSelect = 0,//标题类型
    noSelect    //内容类型
    
} selectType;

@interface SearchSheetLabCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *lableImage;


/**
 cell是否选中
 */
@property (nonatomic, assign) selectType selecttype;

/**
 是否选中更改cell
 */
-(void)changeCellWithSelectType;

@end
