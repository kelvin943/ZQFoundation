//
//  UIImage+ZQAdd.m
//  ZQFoundation
//
//  Created by macro on 2019/9/10.
//

#import "UIImage+ZQAdd.h"

@implementation UIImage (IconFont)


//使用默认的iconfont
//+ (UIImage *)imageFromIconfont:(NSString *)iconStr size:(NSUInteger)size color:(UIColor *)color {
//   return  [self imageFromIconfont:@"iconfont" fontName: size:size color:color];
//}

+ (UIImage *)imageFromIconfontWithIconStr:(NSString *)iconStr
                                     size:(NSUInteger)size
                                    color:(UIColor *)color {
    
    return self ima
    return [[UIImage alloc]init];
}

+ (UIImage *)imageFromIconfontWihtFontName:(NSString *)fontName
                                   iconStr:(NSString*)iconStr
                                      size:(NSUInteger)size
                                     color:(UIColor *)color {
    CGSize imageSize = CGSizeMake(size, size);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    label.font = [UIFont fontWithName:fontName size:size];
    label.text = iconStr;
    if(color){
        label.textColor = color;
    }
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    return retImage;
}

@end
