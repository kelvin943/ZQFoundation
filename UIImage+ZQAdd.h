//
//  UIImage+ZQAdd.h
//  ZQFoundation
//
//  Created by macro on 2019/9/10.
//

#import <UIKit/UIKit.h>

#define IconFont(_name_,size) [UIFont fontWithName:_name_ size:size]


NS_ASSUME_NONNULL_BEGIN

@interface UIImage (IconFont)

////使用默认的iconfont
+ (UIImage *)imageFromIconfontWithIconStr:(NSString *)iconStr
                                     size:(NSUInteger)size
                                    color:(UIColor *)color;

+ (UIImage *)imageFromIconfontWihtFontName:(NSString *)fontName
                                   iconStr:(NSString*)iconStr
                                      size:(NSUInteger)size
                                     color:(UIColor *)color;
@end




NS_ASSUME_NONNULL_END
