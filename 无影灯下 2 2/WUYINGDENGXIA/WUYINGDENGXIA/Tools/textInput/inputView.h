//
//  inputView.h
//  textInput
//
//  Created by fangliguo on 2017/4/11.
//  Copyright © 2017年 fangliguo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol inputViewDelegate <NSObject>

- (void)sendText:(NSString *)text;
- (void)giveText:(NSString *)text;

@end

@interface inputView : UIView

@property (nonatomic, strong) UITextView *inputTextView;

- (void)inputViewShow;
- (void)inputViewHiden;
@property (nonatomic, weak) id<inputViewDelegate>delegate;

@end
