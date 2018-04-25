//
//  TabBarControllerConfig.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/19.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "TabBarControllerConfig.h"
#import "LJNavigationController.h"
#import "QuickQAViewController.h"


@interface TabBarControllerConfig()<CYLTabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation TabBarControllerConfig

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control{
    
    
}

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController
{
    if (_tabBarController == nil) {
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
        
    }
    return _tabBarController;
}


- (NSArray *)viewControllers {
    HeadlineViewController *firstViewController = [[HeadlineViewController alloc] init];
    LJNavigationController *firstNavigationController = [[LJNavigationController alloc]initWithRootViewController:firstViewController];

    TrainViewController *secondViewController = [[TrainViewController alloc]init];
    LJNavigationController *secondNavigationController = [[LJNavigationController alloc]initWithRootViewController:secondViewController];
    
//    QuickQAViewController *fourViewController1 = [[QuickQAViewController alloc]init];
//    LJNavigationController *fourNavigationController1 = [[LJNavigationController alloc]initWithRootViewController:fourViewController1];

    InforViewController *thirdViewController = [[InforViewController alloc]init];
    LJNavigationController *thirdNavigationController = [[LJNavigationController alloc]initWithRootViewController:thirdViewController];
    
    MyViewController *fourViewController = [[MyViewController alloc]init];
    LJNavigationController *fourNavigationController = [[LJNavigationController alloc]initWithRootViewController:fourViewController];
    


    
    NSArray *viewControllers = @[firstNavigationController,
                                 secondNavigationController,
//                                 fourNavigationController1,
                                 thirdNavigationController,
                                 fourNavigationController];
    
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {

    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"index-1",
                                                 CYLTabBarItemSelectedImage : @"index",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"活动",
                                                  CYLTabBarItemImage : @"huodong",
                                                  CYLTabBarItemSelectedImage : @"huodong1",
                                                  };
//    NSDictionary *fourTabBarItemsAttributes1 = @{
//                                                 CYLTabBarItemTitle : @"",
//                                                 CYLTabBarItemImage : @"",
//                                                 CYLTabBarItemSelectedImage : @"",
//                                                 };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"管理工具",
                                                 CYLTabBarItemImage : @"Page 1",
                                                 CYLTabBarItemSelectedImage : @"2",
                                                 };
    
    NSDictionary *fourTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"我的",
                                                 CYLTabBarItemImage : @"me",
                                                 CYLTabBarItemSelectedImage : @"me1",
                                                 };
    



    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
//                                       fourTabBarItemsAttributes1,
                                       thirdTabBarItemsAttributes,
                                       fourTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

#pragma mark - TabBarAppearance
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // 自定义 TabBar 高度
    if (kDevice_Is_iPhoneX) {
        tabBarController.tabBarHeight = 83.f;
    }else{
        tabBarController.tabBarHeight = 49.f;
    }
    
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = RGB(115, 115, 115);
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = RGB(42, 152, 252);
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    //     [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    //     [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    // 设置背景色和分割线
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:RGB(255, 255, 255)];
    
    //改变tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, kScreen_Width, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   RGB(235, 235, 235).CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[UITabBar appearance] setShadowImage:img];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor redColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
