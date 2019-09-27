//
//  UIImage+ZQAdd.m
//  ZQFoundation
//
//  Created by macro on 2019/9/10.
//

#import "UIImage+ZQAdd.h"
#import "ZQMacros.h"

ZQCATEGORY_DUMMY_CLASS(UIImage_ZQAdd)

@implementation UIImage (IconFont)
//使用默认的iconfont
+ (UIImage *)imageFromIconfontWithIconStr:(NSString *)iconStr size:(NSUInteger)size color:(UIColor *)color {
    return [self imageFromIconfontWihtFontName:@"iconfont" iconStr:iconStr size:size color:color];
}

+ (UIImage *)imageFromIconfontWihtFontName:(NSString *)fontName
                                   iconStr:(NSString*)iconStr
                                      size:(NSUInteger)size
                                     color:(UIColor *)color {
    CGSize imageSize = CGSizeMake(size, size);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    label.font = ZQCustomFont(fontName,size);
    label.text = iconStr;
    if(color){
        label.textColor = color;
    }
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    return retImage;
}


+ (UIImage *)imageFrame:(CGRect)frame
                iconStr:(NSString*)iconStr
               fontSize:(CGFloat)size
                  color:(UIColor *)color {
    return [self imageFrame:frame iconStr:iconStr fontName:@"iconfont" fontSize:size color:color];
    
}


+ (UIImage *)imageFrame:(CGRect)frame
                iconStr:(NSString*)iconStr
               fontName:(NSString*)fontName
               fontSize:(CGFloat)size
                  color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
    [iconStr drawInRect:frame withAttributes:@{NSFontAttributeName:ZQCustomFont(fontName,size), NSForegroundColorAttributeName:color}];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

@implementation UIImage (Scale)


+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIImage *image;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    CGContextRelease(context);
    return image;
}

- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor {
    NSParameterAssert(maskColor != nil);
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIImage *image;
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    {
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -(imageRect.size.height));
        CGContextClipToMask(context, imageRect, self.CGImage);
        CGContextSetFillColorWithColor(context, maskColor.CGColor);
        CGContextFillRect(context, imageRect);
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    CGContextRelease(context);
    UIGraphicsEndImageContext();
    
    return image;
}

@end
