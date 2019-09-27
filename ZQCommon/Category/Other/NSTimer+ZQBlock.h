//
//  NSTimer+ZQBlock.h
//  ZQDemoApp
//
//  Created by macro on 2018/8/17.
//  Copyright © 2018年 张泉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (ZQBlock)

+ (NSTimer *)zq_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void (^)(NSTimer * timer))block
                                       repeats:(BOOL)repeats;


@end

NS_ASSUME_NONNULL_END
