//
//  ZQMacros.h
//  ZQDemoApp
//
//  Created by Macro on 2017/11/14.
//  Copyright © 2017年 Macro. All rights reserved.
//

#ifndef ZQMacros_h
#define ZQMacros_h

#pragma mark - 打印
    #ifdef DEBUG
        //print
        #define ZQPrint(format, ...) do {  \
            fprintf(stderr, "===============================================\n",\
                [format UTF8String]);\
            fprintf(stderr, "%s【第%d行】%s\n",\
                [[[NSString stringWithUTF8String:__FILE__]lastPathComponent]\
                UTF8String],__LINE__,__FUNCTION__);\
            fprintf(stderr,"%s\n",[[NSString stringWithFormat: format, ## __VA_ARGS__] \
                UTF8String]);\
            fprintf(stderr, "===============================================\n");\
        } while (0)
        //nslog
        #define ZQLog(...) NSLog(@"\n=============================================== \n%s【第%d行】\n   %@\n===============================================\n",__func__,__LINE__,\
            [NSString stringWithFormat:__VA_ARGS__])
    #else
        #define ZQPrint(format, ...)
        #define ZQLog(...)
    #endif

    //打印尺寸
    #define LogRect(rect)   ZQLog(@"%@", NSStringFromCGRect(rect));
    #define LogSize(size)   ZQLog(@"%@", NSStringFromCGSize(size));
    #define LogPoint(point) ZQLog(@"%@", NSStringFromCGPoint(point)); 

    //打印宏展开,展开顺序为先完全展开宏参数，再扫描宏展开后里面的宏
    //如果宏内容中含有#和##这两个符号的时候，参数不会被先展开
    #define __toString(x) __toString_0(x)
    #define __toString_0(x) #x
    #define ZQLogMacro(x) ZQLog(@"%s=\n%s", #x, __toString(x))

    //打印代码执行时间,查看执行次数用条件断点 : 执行次数%H
    #define TICK   NSDate *startTime = [NSDate date]
    #define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])
    #define START_COUNT_TIME(start) clock_t start = clock()
    #define END_COUNT_TIME(start) (clock() - start)

#pragma mark - 沙盒
    //获取app主目录
    #define kPathAppHome   NSHomeDirectory()
    //获取temp
    #define kPathTemp NSTemporaryDirectory()
    //获取沙盒 Document
    #define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
    //获取沙盒 Cache
    #define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#pragma mark - GCD
    //一次性执行
    #define GCDOnceBlock(onceBlock)\
            static dispatch_once_t onceToken;\
            dispatch_once(&onceToken, onceBlock);
    //在主线程执行
    #define dispatch_safe_async_main(block)\
            if ([NSThread isMainThread]){\
             block();\
            }else{\
              dispatch_async(dispatch_get_main_queue(), block);\
            }
    //开启异步线程执行
    #define dispatch_async_global(block)\
            dispatch_async(dispatch_get_global_queue\
            (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),\
            block);
    //block 安全执行
    #define exec_block(block, ...)\
            if (block) { block(__VA_ARGS__); }


#pragma mark -  NSNotification

#define ZQNoticeOnce(_name_,_block_)               \
            __block id observer =                 \
            [[NSNotificationCenter defaultCenter] \
            addObserverForName:_name_             \
            object:nil                            \
            queue:nil                             \
            usingBlock:_block_]

/*
     user the follow code
     NoticeOnce(UIApplicationDidFinishLaunchingNotification, ^(NSNotification *note){
     // Do whatever you want
     [[NSNotificationCenter defaultCenter] removeObserver:observer];
     });
 */



#pragma mark - 方法
    #define ShareAppDelegate       ((AppDelegate *)[UIApplication sharedApplication].delegate)
    #define ShareWindow            [[UIApplication sharedApplication].delegate window]
    #define ShareKeyWindow         [UIApplication sharedApplication].keyWindow
    #define ShareUserDefault       [NSUserDefaults standardUserDefaults]
    //获取图片资源
    #define GetLocalImage(imageName)   [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
    //获取当前语言
    #define ZQCurrentLanguage      ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark - UIApplicationInfo
    #define ZQAppName              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
    #define ZQAppBundleID          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]
    #define ZQAPPVersion           [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
    #define ZQAppBulidVersion      [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

#pragma mark - Screen
    #define ScreenWidth            [UIScreen mainScreen].bounds.size.width
    #define ScreenHeight           [UIScreen mainScreen].bounds.size.height
    #define ScreenSize             [UIScreen mainScreen].bounds.size
    //状态栏frame
    #define StatusbarRect           [[UIApplication sharedApplication] statusBarFrame]
    //状态栏高度（刘海屏:44 含 X/XS/XR/XS_MAX,非刘海屏：20）  
    #define StatusBarH              StatusbarRect.size.height
    //导航栏目高度（含状态栏）
    #define NavBarHeight            (StatusBarH + 44)
    //底部安全区外高度
    #define BottomGestureAreaHeight (StatusBarH > 20 ? 34:0)
    //标签bar 高度
    #define TabBarHeight            (BottomGestureAreaHeight + 49)
    //默认的cell高度
    #define CellDefaultHeight       (44.f)
    //英文键盘高度
    #define EnglishKeyboardHeight   (216.f)
    //中文键盘高度
    #define ChineseKeyboardHeight   (252.f)



//需要横屏或者竖屏，获取屏幕宽度与高度
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
//
//#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
//#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
//#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
//#else
//#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
//#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
//#endif

//#pragma mark - /**************** Clang 宏定义警告消除****************/
//    #define ArgumentToString(macro) #macro
//    #define ClangWarningConcat(warning_name) ArgumentToString(clang diagnostic ignored warning_name)
//    // 参数可直接传入 clang 的 warning 名，warning 列表参考: http:/fuckingclangwarnings.com/
//    #define BeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(ClangWarningConcat(#warningName))
//    #define EndIgnoreClangWarning _Pragma("clang diagnostic pop")
//
//    #define BeginIgnorePerformSelectorLeaksWarning BeginIgnoreClangWarning(-Warc-performSelector-leaks)
//    #define EndIgnorePerformSelectorLeaksWarning EndIgnoreClangWarning
//
//    #define BeginIgnoreAvailabilityWarning BeginIgnoreClangWarning(-Wpartial-availability)
//    #define EndIgnoreAvailabilityWarning EndIgnoreClangWarning
//
//    #define BeginIgnoreDeprecatedWarning BeginIgnoreClangWarning(-Wdeprecated-declarations)
//    #define EndIgnoreDeprecatedWarning EndIgnoreClangWarning

#pragma mark - 判断机型
    //iphone5、iphoneSE 逻辑像是320:568  @2x
    #define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
    //iphone6、iphone6s、iphone7、iphone8 逻辑像素375:667 @2x
    #define IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
    //iphone6p、iphone7p、iphone8p 逻辑像素 414:736 @3x
    #define IPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
    //iphonex、iphonexs  逻辑像素 375:812  @3x
    #define IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
    //iphonexr 逻辑像素 414:896 @2x
    #define IPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
    //iphonexs max 逻辑像素 414:896 @3x
    #define IPhoneXS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

    //判断是否是刘海屏幕
    #define IPHONEX ((StatusBarH > 20) ? YES : NO)

#pragma mark - 判断系统版本
    #define IOS9_OrLater    [[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0
    #define IOS10_OrLater   [[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0
    #define IOS11_OrLater   [[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0
    #define IOS12_OrLater   [[[UIDevice currentDevice] systemVersion] doubleValue] >= 12.0
    #define IOS_8           ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0 \
                            && [[[UIDevice currentDevice] systemVersion] doubleValue]<9.0)
    #define IOS_9           ([[[UIDevice currentDevice] systemVersion] doubleValue]>=9.0 \
                            && [[[UIDevice currentDevice] systemVersion] doubleValue]<10.0)
    #define IOS_10          ([[[UIDevice currentDevice] systemVersion] doubleValue]>=10.0 \
                            && [[[UIDevice currentDevice] systemVersion] doubleValue]<11.0)
    #define IOS_11          ([[[UIDevice currentDevice] systemVersion] doubleValue]>=11.0 \
                            && [[[UIDevice currentDevice] systemVersion] doubleValue]<12.0)
#endif /* ZQMacros_h */
