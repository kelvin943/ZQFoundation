//
//  ZQHoverScrollView.m
//  ZQFoundation
//
//  Created by 张泉(Macro) on 2019/10/30.
//

#import "ZQHoverScrollView.h"

@interface ZQHoverScrollView ()

@property (nonatomic,assign) CGFloat headHeight;
@property (nonatomic,assign) CGFloat hoverHeight;

@end

@implementation ZQHoverScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.headHeight  = 200.0f;
        self.hoverHeight = 50.f;
        [self setupTableView];
    }
    
    return self;
}

- (void) setupTableView{
    [self addSubview:self.headView];
    [self addSubview:self.hoverView];
}


#pragma mark - 允许接受多个手势 (这个方法很重要，不要遗漏)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (void)reloadData {
     [self.headView removeFromSuperview];
     self.headView = [_dataSource headViewForHoverView:self];
     [self addSubview:self.headView];
       
     [self.hoverView removeFromSuperview];
     self.hoverView  = [_dataSource hoverViewForHoverView:self];
     [self addSubview:self.hoverView];
       
     [self setNeedsLayout];
     [self layoutIfNeeded];
}

- (void)setDataSource:(id<ZQHoverScrollViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (CGRectIsEmpty(self.frame)) {
        return;
    }
    CGFloat width = self.frame.size.width;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(heightForHeadView)]) {
        self.headHeight = [self.dataSource heightForHeadView];
    }
    self.headView.frame = CGRectMake(0, 0, width, self.headHeight);
    
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(heightForHoverView)]) {
           self.hoverHeight = [self.dataSource heightForHoverView];
    }
    self.hoverView.frame = CGRectMake(0, self.headHeight, width, self.hoverHeight);
}


#pragma mark - lazy load
- (UIView *)headView {
    if(!_headView){
        _headView = [[UIView alloc] init];
    }
    return _headView;
}

- (UIView *)hoverView {
    if(!_hoverView){
        _hoverView = [[UIView alloc] init];
    }
    return _hoverView;
}

@end
