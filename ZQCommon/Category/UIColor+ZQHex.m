//
//  UIColor+ZQHex.m
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/9/10.
//

#import "UIColor+ZQHex.h"

@implementation UIColor (ZQHex)

+ (UIColor *)colorWithHex:(NSUInteger)hex {
    CGFloat red, green, blue, alpha;
    
    red     = ((CGFloat)((hex >> 16) & 0xFF)) / ((CGFloat)0xFF);
    green   = ((CGFloat)((hex >> 8)  & 0xFF)) / ((CGFloat)0xFF);
    blue    = ((CGFloat)((hex >> 0)  & 0xFF)) / ((CGFloat)0xFF);
    
    // If you do not specify an alpha "prefix" value, the default will be fully opaque.
    alpha   = hex > 0xFFFFFF ? ((CGFloat)((hex >> 24) & 0xFF)) / ((CGFloat)0xFF) : 1;
    
    return [UIColor colorWithRed: red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha {
    CGFloat red, green, blue;
    red     = ((CGFloat)((hex >> 16) & 0xFF)) / ((CGFloat)0xFF);
    green   = ((CGFloat)((hex >> 8)  & 0xFF)) / ((CGFloat)0xFF);
    blue    = ((CGFloat)((hex >> 0)  & 0xFF)) / ((CGFloat)0xFF);
    return [UIColor colorWithRed: red green:green blue:blue alpha:alpha];
}

@end
