//
//  hoverVC.m
//  ZQFoundation_Example
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/21.
//  Copyright © 2019 macro. All rights reserved.
//

#import "hoverVC.h"
#import "tableVC.h"

@interface hoverVC ()

@end

@implementation hoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  reloadPage];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(NSArray<UIViewController*>*)pageDataSource {
    NSMutableArray * arr = @[].mutableCopy;
    {
        tableVC * vc = [[ tableVC alloc] init];
        [arr addObject:vc];
    }
    
    {
       tableVC * vc = [[ tableVC alloc] init];
        [arr addObject:vc];
    }
    
    {
       tableVC * vc = [[ tableVC alloc] init];
        [arr addObject:vc];
    }
    
    return arr.copy;
}


@end
