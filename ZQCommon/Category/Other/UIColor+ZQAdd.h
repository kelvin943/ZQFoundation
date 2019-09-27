//
//  UIColor+ZQHex.h
//  ZQFoundation
//
//  Created by macro on 2019/9/10.
//

#import <UIKit/UIKit.h>


/*
 hex
 e.g: with  alpha fully opaque: UIColorHex(0xFFFFFF)
      or with alpha no fully  : UIColorHex(0xFFFFFFFF)
 */
#define ZQColorHex(_hex_)   [UIColor colorWithHex:_hex_]
/*
 hex + alpha
 e.g: with alpha no fully :UIColorWithHexAlpha(0xFFFFFF,0.1)
*/
#define ZQColorWithHexAlpha(_hex_,a) [UIColor colorWithHex:_hex_ alpha:a]
/*
 randomColr
 */
#define ZQRandomColor [UIColor randomColor]


@interface UIColor (ZQHex)

+ (UIColor *)randomColor;
+ (UIColor *)colorWithHex:(NSUInteger)hex;
+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;

@end

