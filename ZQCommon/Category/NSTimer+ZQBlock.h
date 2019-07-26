//
//  NSTimer+ZQBlock.h
//  ZQDemoApp
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2018/8/17.
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
