//
//  ZQSegmentView.m
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/12.
//

#import "ZQSegmentView.h"
#import "UIColor+ZQAdd.h"
#import "UIView+ZQExten.h"

#define btnTag 1000
#define ButtonSelectFont     [UIFont fontWithName:@"PingFangSC-Semibold" size:14]
#define ButtonUnSelectFont   [UIFont fontWithName:@"PingFangSC-Regular" size:14]

#define ButtonSelectColor    [UIColor colorWithHex:0x1858FF]
#define ButtonUnSelectColor  [UIColor colorWithHex:0x333333]


@interface ZQSegmentView ()
@property (nonatomic,strong) NSMutableArray<UIButton*> *btnArray;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation ZQSegmentView
@synthesize menuTitleArray = _menuTitleArray;

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
    }
    //手动布局
    [self layoutSubviews];
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpSubviews];
    }
    //手动布局
    [self layoutSubviews];
    return self;
}

- (void)setUpSubviews {
    self.backgroundColor = [UIColor whiteColor];
    //设置默认值
    self.layoutType  = ZQSegmengViewLayoutTypeFromLeft;
    self.buttonUnSelectFont  = ButtonUnSelectFont;
    self.buttonSelectFont    = ButtonSelectFont;
    self.buttonUnSelectColor = ButtonUnSelectColor;
    self.buttonSelectColor   = ButtonSelectColor;
    self.leftPadding = 16;
    self.hSpacing    = 32;
    self.btnHeight   = 30;
    self.btnWidth    = 80;
    
    for (int i = 0; i < self.menuTitleArray.count; i++) {
        UIButton *titBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮的样式
        titBtn.backgroundColor = [UIColor whiteColor];
        titBtn.titleLabel.font = self.buttonUnSelectFont;
        [titBtn setTitleColor:self.buttonUnSelectColor forState:UIControlStateNormal];
        titBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [titBtn setTitle:self.menuTitleArray[i] forState:UIControlStateNormal];
        titBtn.tag = btnTag + i;
        [titBtn addTarget:self action:@selector(titBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titBtn];
        [self.btnArray addObject:titBtn];
    }
    
    [self addSubview:self.lineView];
}


- (void)layoutSubviews {
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat btnXStart = _leftPadding;
    if (self.layoutType == ZQSegmengViewLayoutTypeAverage) {
        //根据 view 宽度和间隙均分计算出 button 的宽度
        _btnWidth = (viewWidth - _hSpacing*(self.menuTitleArray.count - 1) - (_leftPadding *2))/self.menuTitleArray.count;
        for (int i = 0; i < _btnArray.count; i++) {
            UIButton *titBtn =_btnArray [i];
            titBtn.frame = CGRectMake(btnXStart, 5, _btnWidth, _btnHeight);
            btnXStart += (_btnWidth + _hSpacing);
        }
    }else {
        //根据 button 的 title 串的长度计算出 button 的宽度
        for (int i = 0; i < _btnArray.count; i++) {
            UIButton *titBtn =_btnArray [i];
            CGSize size = [titBtn.titleLabel.text boundingRectWithSize:CGSizeMake(viewWidth, self.btnHeight)
                                                             options:NSStringDrawingUsesLineFragmentOrigin
                                                          attributes:@{NSFontAttributeName: titBtn.titleLabel.font}
                                                             context:nil].size;
            self->_btnWidth = size.width + 2;
            titBtn.frame = CGRectMake(btnXStart, 5, _btnWidth, _btnHeight);
            btnXStart += (_btnWidth + _hSpacing);
        }
    }
    
    if (self.btnArray.count > 0) {
        UIButton * firstBtn =self.btnArray[0];
        self.lineView.frame = CGRectMake(firstBtn.left, 0, firstBtn.width, 2);
        self.lineView.bottom = self.height;
        self.lineView.backgroundColor = ButtonSelectColor;
    }
}


-(void)titBtnClick:(UIButton*)sender {
    NSInteger selectIndex =  sender.tag - btnTag;
    self.selectIndex = selectIndex;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectIndex:)]) {
        [self.delegate segmentView:self didSelectIndex:selectIndex];
    }
}


//跟新标签数据源需要重绘视图 所以需要重写数据源方法
-(void)setMenuTitleArray:(NSArray *)menuTitleArray{
    _menuTitleArray = menuTitleArray;
    [self.btnArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btnArray removeAllObjects];
    //重新创建Button
    for (int i = 0; i < self.menuTitleArray.count; i++) {
        UIButton *titBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮的样式
        titBtn.backgroundColor = [UIColor whiteColor];
        titBtn.titleLabel.font = self.buttonUnSelectFont;
        [titBtn setTitleColor:self.buttonUnSelectColor forState:UIControlStateNormal];
        titBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [titBtn setTitle:self.menuTitleArray[i] forState:UIControlStateNormal];
        titBtn.tag = btnTag + i;
        [titBtn addTarget:self action:@selector(titBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titBtn];
        [self.btnArray addObject:titBtn];
    }
    //重新设置button之后需要重新布局
    [self layoutSubviews];
}

//设置选中的按钮样式
-(void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton * item = self.btnArray[i];
        if (i == self.selectIndex) {
            [item setTitleColor:self.buttonSelectColor forState:UIControlStateNormal];
            item.titleLabel.font = self.buttonSelectFont;
            [UIView animateWithDuration:0.2 animations:^{
                self.lineView.left = item.left;
            }];
        }else {
            [item setTitleColor:self.buttonUnSelectColor forState:UIControlStateNormal];
            item.titleLabel.font = self.buttonUnSelectFont;
        }
    }
}

//左内边距
-(void)setLeftPadding:(CGFloat)leftPadding {
    _leftPadding = leftPadding;
    [self layoutSubviews];
}
//水平间距
-(void)setHSpacing:(CGFloat)hSpacing {
    _hSpacing = hSpacing;
    [self layoutSubviews];
}
-(void)setBtnWidth:(CGFloat)btnWidth {
    _btnWidth = btnWidth;
    [self layoutSubviews];
}
-(void)setBtnHeight:(CGFloat)btnHeight {
    _btnHeight = btnHeight;
    [self layoutSubviews];
}


#pragma  mark - lazy load


- (NSArray *)menuTitleArray{
    if (!_menuTitleArray) {
        _menuTitleArray = @[@"按钮1", @"按钮2", @"按钮3"].copy;
    }
    return _menuTitleArray;
}


- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = @[].mutableCopy;
    }
    return _btnArray;
}

- (UIView*)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
    }
    return _lineView;
}

@end
