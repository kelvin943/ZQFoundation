//
//  ZQSegmentView.h
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/12.
//


/*
   // suggest init frame
    - (ZQSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[ZQSegmentView alloc] initWithFrame:CGRectMake(0, 0,SCREENWIDTH , 44)];
        _segmentView.menuTitleArray = @[@"待办任务", @"已办任务", @"我提交的"];
        _segmentView.selectIndex = 0;
        _segmentView.hSpacing = 20;
        _segmentView.layoutType = LayoutTypeFromLeft;
        _segmentView.delegate = self;
        }
        return _segmentView;
    }

*/


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZQSegmengViewLayoutType) {
    ZQSegmengViewLayoutTypeFromLeft,
    ZQSegmengViewLayoutTypeAverage,
};


@class ZQSegmentView;
@protocol ZQSegmentViewDelegate <NSObject>
@optional
- (void)segmentView:(ZQSegmentView *_Nullable)segmentView didSelectIndex:(NSInteger)index;

@end



NS_ASSUME_NONNULL_BEGIN

@interface ZQSegmentView : UIView

@property (nonatomic, weak) id<ZQSegmentViewDelegate> delegate;
@property (nonatomic,  copy) NSArray *menuTitleArray;
@property (nonatomic,  assign) NSInteger selectIndex;
//布局方式
@property (nonatomic,assign) IBInspectable ZQSegmengViewLayoutType layoutType;
//左内边距
@property (nonatomic,assign) IBInspectable CGFloat  leftPadding;
//水平间距
@property (nonatomic,assign) IBInspectable CGFloat  hSpacing;
//按钮宽高
@property (nonatomic,assign) IBInspectable CGFloat  btnWidth;
@property (nonatomic,assign) IBInspectable CGFloat  btnHeight;
@property (nonatomic,assign) IBInspectable BOOL  isShowLineView;


//按钮字体大小颜色、背景颜色
@property (nonatomic,strong)  UIFont * buttonUnSelectFont;
@property (nonatomic,strong)  UIFont * buttonSelectFont;
@property (nonatomic,strong) IBInspectable UIColor * buttonUnSelectColor;
@property (nonatomic,strong) IBInspectable UIColor * buttonSelectColor;

@end

NS_ASSUME_NONNULL_END
