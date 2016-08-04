//
//  CSViewController.m
//  CodeShare
//
//  Created by 盛雪丽 on 16/8/3.
//  Copyright © 2016年 shengxueli. All rights reserved.
//
#import "CSViewController.h"
#import "MainViewController.h"

#import "CSUserModel.h"
#import "CSLoginViewController.h"

@interface CSViewController ()

@end

@implementation CSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 将所有的控制器按照 mvc 的思想配置好，并且封装起来
    [self setUpViewControllers];
    
}

- (void)viewDidAppear:(BOOL)animated {
    // 在这里养成一个习惯，要在生命周期方法中调用父类方法。
    [super viewDidAppear:animated];
    
    // 当用户没有登录的时候，需要弹出登录界面
    if (![CSUserModel isLogin]) {
        [self showLoginViewController];
    }
}

- (void)showLoginViewController {
    CSLoginViewController *loginVC = [[CSLoginViewController alloc] init];
    // 一般我们在使用模态视图时，都会用导航控制器将视图包装一下
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    // 用模态视图弹出登录控制器
    [self presentViewController:naviVC animated:YES completion:nil];
    
}

- (void)setUpViewControllers {
    // 如何使用 mvc 的思想
    NSArray *controllerInfos = @[
                                 // 数组里面每一个条目，都是一个字典，里面配置了所有控制器显示的效果和类型
                                 @{
                                     @"class": [MainViewController class],
                                     @"title": @"首页",
                                     @"icon": @"tabbar1",
                                     
                                     },
                                 @{
                                     @"class": [UIViewController class],
                                     @"title": @"首页",
                                     @"icon": @"tabbar2",
                                     
                                     },
                                 @{
                                     @"class": [UIViewController class],
                                     @"title": @"首页",
                                     @"icon": @"tabbar3",
                                     
                                     },
                                 @{
                                     @"class": [UIViewController class],
                                     @"title": @"首页",
                                     @"icon": @"tabbar3",
                                     
                                     },
                                 ];
    
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:controllerInfos.count];
    // 数组的枚举遍历方法
    [controllerInfos enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        // 这里，直接拿遍历 block 传过来的字典，取出其中的控制器类型，然后创建一个控制器。
        UIViewController *viewController = [[[obj objectForKey:@"class"] alloc] init];
        viewController.title = [obj objectForKey:@"title"];
        // 再创建一个导航控制器，装入刚才创建的控制器。
        UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:viewController];
        // 需要将导航控制器装入到数组中。
        [viewControllers addObject:naviVC];
        
    }];
    // 配置控制器数组
    self.viewControllers = viewControllers;
    
    
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
