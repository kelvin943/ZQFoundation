//
//  NSString+ZQSafe.h
//  ZQDemoApp
//
//  Created by macro on 2018/8/24.
//  Copyright © 2018年 张泉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZQSafe)

@end

@interface NSMutableString (ZQSafe)

@end



@interface NSDateFormatter (Static)
@end
@interface NSString (NSDate)
/* 从日期生成字符串 */
+ (NSString *)stringFromDate:(NSDate *)date;
@end
