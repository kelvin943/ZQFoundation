//
//  UIImage+ZQAdd.h
//  ZQFoundation
//
//  Created by macro on 2019/9/10.
//

#import <UIKit/UIKit.h>


/*
 e.g:
  get image from defaul iconfont: ImageWithDefaultIconfont(_iconStr_,_size_,_color_)
  get image from costom iconfont: ImageWithDefaultIconfont(_fontName_,_iconStr_,_size_,_color_)
 */

#define ImageWithIconfont(_fontName_,_iconStr_,_size_,_color_)  \
[UIImage imageFromIconfontWihtFontName:_fontName_ iconStr:_iconStr_ size:_size_ color:_color_]
#define ImageWithDefaultIconfont(_iconStr_,_size_,_color_) \
[UIImage imageFromIconfontWihtFontName:@"iconfont" iconStr:_iconStr_ size:_size_ color:_color_]


NS_ASSUME_NONNULL_BEGIN

@interface UIImage (IconFont)

//使用默认的 iconfont 获取等宽高的图片
+ (UIImage *)imageFromIconfontWithIconStr:(NSString *)iconStr
                                     size:(NSUInteger)size
                                    color:(UIColor *)color;
//使用指定 iconfont 获取等宽高的图片
+ (UIImage *)imageFromIconfontWihtFontName:(NSString *)fontName
                                   iconStr:(NSString*)iconStr
                                      size:(NSUInteger)size
                                     color:(UIColor *)color;

//使用默认的iconfont 获取指定 frame 大小的图片
+ (UIImage *)imageFrame:(CGRect)frame
                iconStr:(NSString*)iconStr
               fontSize:(CGFloat)size
                  color:(UIColor *)color;

//使用指定的iconfont 获取指定 frame 大小的图片
+ (UIImage *)imageFrame:(CGRect)frame
                iconStr:(NSString*)iconStr
               fontName:(NSString*)fontName
               fontSize:(CGFloat)size
                  color:(UIColor *)color;
@end


@interface UIImage (Scale)

+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor;

@end




NS_ASSUME_NONNULL_END
