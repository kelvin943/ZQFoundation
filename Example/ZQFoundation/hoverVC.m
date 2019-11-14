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
@property (nonatomic,strong) tableVC *vc1;
@property (nonatomic,strong) tableVC *vc2;
@property (nonatomic,strong) tableVC *vc3;
@end

@implementation hoverVC

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, ZQNavBarHeight, ZQScreenWidth, ZQScreenHeight -ZQNavBarHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  reloadPage];
    
   __weak typeof(self) weakSelf = self;
    self.vc1.scrollAction = ^(UIScrollView *scrollView) {
        NSLog(@"y:%f",scrollView.contentOffset.y);
        if (!weakSelf.vc1.isCanScroll) {
            scrollView.contentOffset = CGPointZero;
        }
        if (scrollView.contentOffset.y < 0 ) {
            weakSelf.vc1.isCanScroll = NO;
            scrollView.contentOffset = CGPointZero;
            weakSelf.isCanScroll = YES;
        }
    };
    
    
    // Do any additional setup after loading the view.
}

- (BOOL)zq_needCustomNavBar {
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -  UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //tableview head 的高度
    CGFloat scrollY = [self.tableView rectForSection:0].origin.y;
    NSLog(@"mainTable contentOffsetY:%f contentInsetY:%f ",scrollView.contentOffset.y,scrollView.contentInset.top);
    if (scrollView.contentOffset.y >= scrollY) {
        if (self.isCanScroll) {
            self.isCanScroll = NO;
            self.tableView.contentOffset = CGPointMake(0, scrollY);
            self.vc1.isCanScroll = YES;
            self.vc1.tableView.contentOffset = CGPointZero;
            self.vc2.isCanScroll = YES;
            self.vc2.tableView.contentOffset = CGPointZero;
            self.vc3.isCanScroll = YES;
            self.vc3.tableView.contentOffset = CGPointZero;
        }
        self.tableView.contentOffset = CGPointMake(0, scrollY );
    }else {
        if (!self.isCanScroll) {
            self.tableView.contentOffset = CGPointMake(0, scrollY);
        }
    }
//    self.tableView.showsVerticalScrollIndicator = self.isCanScroll?YES:NO;
}



-(tableVC*)vc1 {
    if (!_vc1) {
        _vc1 = [[ tableVC alloc] init];
    }
    return _vc1;
}
-(tableVC*)vc2 {
    if (!_vc2) {
        _vc2 = [[ tableVC alloc] init];
    }
    return _vc2;
}

-(tableVC*)vc3 {
    if (!_vc3) {
        _vc3 = [[ tableVC alloc] init];
    }
    return _vc3;
}

-(NSArray<UIViewController*>*)pageDataSource {
    return @[self.vc1,self.vc2,self.vc3];
}


@end
