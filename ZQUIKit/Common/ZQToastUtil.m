//
//  ZQToastUtil.m
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/9/26.
//

#import "ZQToastUtil.h"

static BOOL hudShown = NO;
static UIView *hudView = nil;


@implementation ZQToastUtil

#pragma mark - Public Methods

+ (void)showNotice:(NSString *)aText inView:(UIView *)aView position:(ToastUtilPosition)aPosition space:(CGFloat)aSpace {
    // 默认显示秒数
    NSTimeInterval duration         = 1.382;
    
    if (aText.length > 13) duration  = 2.236;
    else if (aText.length > 8) duration = 1.618;
    
    [self showNotice:aText inView:aView atViewPosition:aPosition space:aSpace duration:duration completion:nil];
}

+ (void)showNotice:(NSString *)text {
    if ([text length] == 0) {
        return;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showNotice:text inView:window];
}

+ (void)showNotice:(NSString *)text inView:(UIView *)view {
    
    // 默认显示秒数
    NSTimeInterval duration         = 1.382;
    
    if (text.length > 13) duration  = 2.236;
    else if (text.length > 8) duration = 1.618;
    
    [self showNotice:text inView:view duration:duration completion:nil];
}

+ (void)showNotice:(NSString *)text inView:(UIView *)view duration:(NSTimeInterval)duration {
    [self showNotice:text inView:view duration:duration completion:nil];
}

+ (void)showNotice:(NSString *)text inView:(UIView *)view duration:(NSTimeInterval)duration completion:(void(^)(void))completion {
    [self showNotice:text inView:view atViewPosition:ToastUtilPositionCenter space:0 duration:duration completion:completion];
}

+ (void)showNotice:(NSString *)aText inView:(UIView *)aView atViewPosition:(ToastUtilPosition)aPosition space:(CGFloat)aSpace duration:(NSTimeInterval)aDuration completion:(void(^)(void))aCompletion {
    // clear old toastview
    if (hudView.superview) {
        [hudView removeFromSuperview];
        hudView = nil;
    };
    
    // content label
    UILabel *contentLabel           = [[UILabel alloc] init];
    contentLabel.numberOfLines      = 0;
    contentLabel.textAlignment      = NSTextAlignmentCenter;
    contentLabel.backgroundColor    = [UIColor clearColor];
    contentLabel.textColor          = [UIColor whiteColor];
    contentLabel.text               = aText;
    contentLabel.font               = [UIFont systemFontOfSize:15.0];
    
    // content label frame
    CGSize maxsize                  = CGSizeMake([[UIScreen mainScreen] applicationFrame].size.width - 48, 600);
    CGFloat minWidth                = 88.0;
    NSDictionary *attdic            = @{NSFontAttributeName: contentLabel.font};
    CGSize textSize = [aText boundingRectWithSize:maxsize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attdic context:nil].size;

    if (textSize.width < minWidth) {
        textSize.width = minWidth;
    }
    
    contentLabel.frame              = CGRectMake(0, 0, textSize.width, textSize.height);
    
    // hudView
    UIView *temphudView                 = [[UIView alloc] init];
    temphudView.backgroundColor         = [UIColor blackColor];
    temphudView.layer.cornerRadius      = 5;
    temphudView.layer.opacity           = 0;
    
    // hudView frame
    CGFloat horizontalMargin        = 16;
    CGFloat verticalMargin          = 10;
    CGSize hudViewSize              = CGSizeMake(contentLabel.bounds.size.width + horizontalMargin * 2,
                                                 contentLabel.bounds.size.height + verticalMargin * 2);
    CGPoint hudViewCenter           = CGPointMake(CGRectGetMidX(aView.bounds), CGRectGetMidY(aView.bounds));

    temphudView.frame       = CGRectMake(0, 0, hudViewSize.width, hudViewSize.height);
    if (aPosition == ToastUtilPositionCenter) {
        temphudView.center      = CGPointMake(hudViewCenter.x, hudViewCenter.y + aSpace);
    } else if (aPosition == ToastUtilPositionTop) {
        temphudView.center      = CGPointMake(hudViewCenter.x, aSpace);
    } else {
        temphudView.center      = CGPointMake(hudViewCenter.x, CGRectGetHeight(aView.frame) - hudViewSize.height - aSpace);
    }
    
    contentLabel.center = CGPointMake(temphudView.bounds.size.width / 2, temphudView.bounds.size.height / 2);
    
    // addSubview
    [temphudView addSubview:contentLabel];
    [aView addSubview:temphudView];
    [aView bringSubviewToFront:temphudView];
    
    { // 动画增加
        CGFloat durationUnit = (0.8 + aDuration)/10;
        // 缩小
        CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.keyTimes = @[@0, @(0.3 * durationUnit), @(0.5 * durationUnit), @((aDuration+0.5) * durationUnit), @((aDuration+0.8) * durationUnit)];
        scaleAnimation.values   = @[@0.001, @1.1, @1, @1, @0.001];
        
        // 透明度
        CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.keyTimes = @[@0, @(0.3 * durationUnit), @(0.5 * durationUnit), @((aDuration+0.5) * durationUnit), @((aDuration+0.8) * durationUnit)];
        opacityAnimation.values   = @[@0, @0.9, @0.8, @0.8, @0.0];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[scaleAnimation, opacityAnimation];
        group.duration = 0.8 + aDuration;
        [temphudView.layer addAnimation:group forKey:@"group"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.8 + aDuration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [temphudView removeFromSuperview];
        });
    }
    
    hudView = temphudView;
}

+ (void)hideNotice {
    if (!hudView.superview) return;
    
    [UIView animateWithDuration:0.236 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        hudView.transform           = CGAffineTransformMakeScale(0.001, 0.001);
        [hudView.layer setOpacity:0.0];
    }
    completion:^(BOOL finished) {
        [hudView removeFromSuperview];
        hudView                     = nil;
        hudShown                    = NO;
    }];
}

@end
