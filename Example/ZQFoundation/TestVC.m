//
//  TestVC.m
//  ZQFoundation_Example
//
//  Created by 张泉(Macro) on 2019/10/17.
//  Copyright © 2019 macro. All rights reserved.
//

#import "TestVC.h"
#import "ZQPageViewController.h"

@interface TestVC ()
@property (nonatomic,strong) ZQPageViewController *pageVC;

@end

@implementation TestVC

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.pageVC.view.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableArray * vcArr = @[].mutableCopy;
//    for (int i = 0; i < 3; i++) {
//        UIViewController * tempVC = [[UIViewController alloc] init];
//        tempVC.view.backgroundColor = ZQRandomColor;
//        [vcArr addObject:tempVC];
//    }
    
    self.pageVC = [[ZQPageViewController alloc ] init];
    [self.view addSubview:self.pageVC.view];
    
    {
        UIViewController * tempVC = [[UIViewController alloc] init];
        tempVC.view.backgroundColor = ZQRandomColor;
        [self.pageVC addChildViewController:tempVC];
    }
    
    {
        UIViewController * tempVC = [[UIViewController alloc] init];
        tempVC.view.backgroundColor = ZQRandomColor;
        [self.pageVC addChildViewController:tempVC];
    }
    
    {
           UIViewController * tempVC = [[UIViewController alloc] init];
           tempVC.view.backgroundColor = ZQRandomColor;
           [self.pageVC addChildViewController:tempVC];
    }
    [self.pageVC reloadPages];
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
