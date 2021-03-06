//
//  NSTimer+ZQBlock.m
//  ZQDemoApp
//
//  Created by macro on 2018/8/17.
//  Copyright © 2018年 张泉. All rights reserved.
//

#import "NSTimer+ZQBlock.h"
#import "ZQMacros.h"
ZQCATEGORY_DUMMY_CLASS(NSTimer_ZQAdd)


@implementation NSTimer (ZQBlock)

+ (void)_zq_blockInvoke:(NSTimer *)timer {
    if (timer.userInfo) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}
+ (NSTimer *)zq_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void (^)(NSTimer * _Nonnull timer))block
                                       repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(_zq_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}
@end
