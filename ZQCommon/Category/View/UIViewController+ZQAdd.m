//
//  UIViewController+ZQAdd.m
//  ZQFoundation
//
//  Created by 张泉(macro) on 2019/9/25.
//

#import "UIViewController+ZQAdd.h"


static const CGFloat ImageTitleSpace = 30.0f;  // 图片和标题的距离
static const CGFloat ImageOffset     = 120;    // 图片默认居中向上便宜相对屏幕的高度便宜120

#define VCViewHeight     [[UIScreen mainScreen] bounds].size.height

#pragma mark - ZQExceptionView

@interface ZQExceptionView()
@property (nonatomic, strong) UIImageView *exceptionImage;
@property (nonatomic, strong) UILabel     *exceptionTitle;
@end

@implementation ZQExceptionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.exceptionTitle];
        [self addSubview:self.exceptionImage];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

#pragma mark - public method

- (void)setImage:(NSString *)imageNamed {
    if (!imageNamed || [imageNamed isEqualToString:@""]) {
        NSLog(@"Exception view error：image is nil");
        return;
    }
    UIImage* image = [UIImage imageNamed:imageNamed];
    CGSize size = image.size;
    [self.exceptionImage setImage:image];
    self.exceptionImage.frame = CGRectMake((self.frame.size.width - size.width)/2, ((self.frame.size.height -size.height)/2 - ImageOffset*self.frame.size.height/VCViewHeight), size.width, size.height);
}
- (void)setText:(NSString *)title {
    if (!title || [title isEqualToString:@""]) {
        NSLog(@"Exception view error：title is nil");
        return;
    }
    CGSize size = [title boundingRectWithSize:CGSizeMake(280.0f, 400.0f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_exceptionTitle.font} context:nil].size;
    _exceptionTitle.frame = CGRectMake((self.frame.size.width - size.width)/2, CGRectGetMaxY(_exceptionImage.frame) + ImageTitleSpace, size.width, size.height);
    _exceptionTitle.text = title;

}

#pragma mark - GET

- (UIImageView *)exceptionImage {
    if (!_exceptionImage) {
        _exceptionImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _exceptionImage;
}

- (UILabel *)exceptionTitle {
    if (!_exceptionTitle) {
        _exceptionTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [_exceptionTitle setTextColor:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f]];
        [_exceptionTitle setTextAlignment:NSTextAlignmentCenter];
        [_exceptionTitle setFont:[UIFont systemFontOfSize:16]];
        [_exceptionTitle setNumberOfLines:0];
    }
    
    return _exceptionTitle;
}

@end


@implementation UIViewController (Exception)

#pragma mark - Public method

- (void)showExceptionTitle:(NSString *)title imageName:(NSString *)imageName {
    [self showExceptionTitle:title imageName:imageName frame:self.view.bounds];
}
- (void)showExceptionTitle:(NSString *)title imageName:(NSString *)imageName atView:(UIView *)view {
    [self showExceptionTitle:title imageName:imageName frame:view.frame];
}
- (void)showExceptionTitle:(NSString *)title imageName:(NSString *)imageName top:(CGFloat)top {
    CGRect frame =CGRectMake(0, top, self.view.bounds.size.width, (self.view.bounds.size.height - top));
    [self showExceptionTitle:title imageName:imageName frame:frame];
}
- (void)showExceptionTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame {
    [self hideExceptionView];
    ZQExceptionView *exceptionView = [[ZQExceptionView alloc] initWithFrame:frame];
    [exceptionView setImage:imageName];
    [exceptionView setText:title];
    [self.view addSubview:exceptionView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onExceptionViewTap:)];
    [exceptionView addGestureRecognizer:tapGesture];
}


- (void)showExceptionView:(UIViewExceptionType)exceptionType {
    [self showExceptionView:exceptionType atView:self.view];
}
- (void)showExceptionView:(UIViewExceptionType)exceptionType atView:(UIView *)view{
    
    CGRect frame = view.frame;
    if (view == self.view) {
        frame = self.view.bounds;
    }
    [self showExceptionView:exceptionType frame:frame];
}
- (void)showExceptionView:(UIViewExceptionType)exceptionType top:(CGFloat)top {
    CGRect frame = CGRectMake(0, top, self.view.bounds.size.width, (self.view.bounds.size.height - top));
    [self showExceptionView:exceptionType frame:frame];
}

- (void)showExceptionView:(UIViewExceptionType)exceptionType frame:(CGRect)frame {
    
    [self hideExceptionView];
    ZQExceptionView *exceptionView = [[ZQExceptionView alloc] initWithFrame:frame];
    [self.view addSubview:exceptionView];
    
    NSString *title = nil;
    NSString *imageNamed = nil;
    switch (exceptionType) {
        case UIViewExceptionTypeServiceError:
            imageNamed = [self serviceErrorImageNameForExceptionView];
            title      = [self serviceErrorTitleForExceptionView];
            break;
        default://默认是服务器错误
            imageNamed = [self networkErrorImageNameForExceptionView];
            title      = [self networkErrorTitleForExceptionView];
            break;
    }
    
    [exceptionView setImage:imageNamed];
    [exceptionView setText:title];
    // add tapGesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onExceptionViewTap:)];
    [exceptionView addGestureRecognizer:tapGesture];
}


- (void)hideExceptionView {
    NSEnumerator *enumerator = [self.view.subviews reverseObjectEnumerator];
    UIView *obj = nil;
    while (obj = [enumerator nextObject]) {
        if ([obj isKindOfClass:[ZQExceptionView class]]) {
            [obj removeFromSuperview];
            return;
        }
    }
}



//设置默认的服务器错误图片
- (NSString *)serviceErrorImageNameForExceptionView {
    return @"NetworkError";
}
//设置默认的服务器错误文案
- (NSString *)serviceErrorTitleForExceptionView {
    return @"服务出错，轻触屏幕重新加载";
}
//设置默认的网络错误图片
- (NSString *)networkErrorImageNameForExceptionView {
    return @"NetworkError";
}
//设置默认的网络错误文案
- (NSString *)networkErrorTitleForExceptionView {
    return @"网络链接失败，轻触屏幕重新加载";
}
- (void)exceptionViewClickAction {
    // 重写此方法获取点击事件
}

#pragma mark - privace
- (void)onExceptionViewTap:(id)sender {
    [self exceptionViewClickAction];
}

@end
