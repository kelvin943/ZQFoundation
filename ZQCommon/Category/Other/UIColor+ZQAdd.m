//
//  UIColor+ZQHex.m
//  ZQFoundation
//
//  Created by 张泉(macro) on 2019/9/10.
//

#import "UIColor+ZQAdd.h"
#import "ZQMacros.h"

ZQCATEGORY_DUMMY_CLASS(UIColor_ZQAdd)
@implementation UIColor (ZQHex)

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
}


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
