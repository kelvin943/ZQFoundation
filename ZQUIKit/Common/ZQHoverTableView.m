//
//  ZQHoverTableView.m
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/16.
//

#import "ZQHoverTableView.h"

@interface ZQHoverTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ZQHoverTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setupTableView];
    }
    
    return self;
}


- (void)setupTableView {
    
}

#pragma mark - 允许接受多个手势 (这个方法很重要，不要遗漏)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
