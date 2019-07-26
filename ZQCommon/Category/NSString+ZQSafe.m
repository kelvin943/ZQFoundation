//
//  NSString+ZQSafe.m
//  ZQDemoApp
//
//  Created by Macro on 2018/8/24.
//  Copyright © 2018年 Macro. All rights reserved.
//

#import "NSString+ZQSafe.h"
#import "NSObject+ZQAdd.h"

#define SafeStringMethod(methodName)                   \
- (NSString *)methodName:(NSUInteger)index {           \
    if (index > self.length) return nil;               \
    return [self methodName:index];                    \
}

#define SafeStringMethod1(methodName)                       \
- (NSString *)methodName:(NSRange)range {                   \
    if (range.location > self.length ||                     \
        range.length > self.length   ||                     \
        (range.location + range.length) > self.length){     \
        return nil;                                         \
    }                                                       \
    return [self methodName:range];                         \
}

#define ZQSwizzle(__oSelName__,__nSelName__,__classStr__)  \
ZQExchangeInstanceMethod(@selector(__oSelName__), @selector(__nSelName__), objc_getClass(__classStr__))
   


/*************************************************************************************************
 * 解决将字符串当做字典或者数据的语法糖使用的时候会 crash 的问题
 * 也可以使用 exchanged_instance_method 交接换 objectForKeyedSubscript 的方法实现
 * 交换方法的需要放在 + load  方法中 会影响app 启动性能 使用 resolveInstanceMethod 可以在需要的时候在添加方法实现
 *************************************************************************************************/
NSString* safe_objectForKeyedSubscript(id self, SEL _cmd){
    return  nil;
}
NSString* safe_objectAtIndexedSubscript(id self, SEL _cmd){
    return  nil;
}


#pragma  mark -  Safe NSString 
@implementation NSString (ZQSafe)

//处理字符串截取的是可能越界导致的 crash
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            //  字符串截取越界crash
            ZQSwizzle(substringToIndex:, zqsafe_constantstr_substringToIndex:, "__NSCFConstantString");
            ZQSwizzle(substringFromIndex:, zqsafe_constantstr_substringFromIndex:, "__NSCFConstantString");
            ZQSwizzle(substringWithRange:, zqsafe_constantstr_substringWithRange:, "__NSCFConstantString");
            
            ZQSwizzle(substringToIndex:, zqsafe_TaggedPoint_substringToIndex:, "NSTaggedPointerString");
            ZQSwizzle(substringFromIndex:, zqsafe_TaggedPoint_substringFromIndex:, "NSTaggedPointerString");
            //            ZQSwizzle(substringWithRange:, zqsafe_TaggedPoint_substringWithRange:, "NSTaggedPointerString");
            //当 NSTaggedPointerString 中已经有substringWithRange: 方法的时候可以用以下下快速交换实例方法
            [NSClassFromString(@"NSTaggedPointerString") swapMethod:@selector(substringWithRange:)
                                                      currentMethod:@selector(zqsafe_TaggedPoint_substringWithRange:)];
        }
    });
}

#pragma mark - __NSCFConstantString 截取越界
SafeStringMethod(zqsafe_constantstr_substringToIndex)
SafeStringMethod(zqsafe_constantstr_substringFromIndex)
SafeStringMethod1(zqsafe_constantstr_substringWithRange)

#pragma mark - NSTaggedPointerString 截取越界
SafeStringMethod(zqsafe_TaggedPoint_substringToIndex)
SafeStringMethod(zqsafe_TaggedPoint_substringFromIndex)
SafeStringMethod1(zqsafe_TaggedPoint_substringWithRange)


#pragma mark - 防止 NSString 没有实现的方法调用 crash
/** 没有找到SEL时会执行下面的方法 给类添加对应的方法实现 */
+ (BOOL) resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(objectForKeyedSubscript:)) {
        class_addMethod(self, sel, (IMP)safe_objectForKeyedSubscript, "v@:");
        return  YES;
    }
    if (sel == @selector(objectAtIndexedSubscript:)) {
        class_addMethod(self, sel, (IMP)safe_objectAtIndexedSubscript, "v@:");
        return  YES;
    }
    return [super resolveInstanceMethod:sel];
}
//+ (BOOL) resolveClassMethod:(SEL)sel{
//
//
//}

//将消息转发给其他类处理
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//
//}
//- (void) forwardInvocation:(NSInvocation *)anInvocation{
//
//}

@end


#pragma mark - NSMutableString 截取越界
@implementation NSMutableString (ZQSafe)

+ (void)load {
    ZQSwizzle(substringToIndex:, zqsafe_substringToIndex:, "__NSCFString");
    ZQSwizzle(substringFromIndex:, zqsafe_substringFromIndex:, "__NSCFString");
    ZQSwizzle(substringWithRange:, zqsafe_substringWithRange:, "__NSCFString");
    //当 __NSCFString 中已经有substringWithRange: 方法的时候可以用以下下快速交换实例方法
//    [NSClassFromString(@"__NSCFString") swapMethod:@selector(substringWithRange:)
//                                              currentMethod:@selector(zqsafe_substringWithRange:)];
//    ZQLog(@"__NSCFString method list %@",[NSClassFromString(@"__NSCFString") fetchInstanceMethodList]);
}

SafeStringMethod(zqsafe_substringToIndex)
SafeStringMethod(zqsafe_substringFromIndex)
SafeStringMethod1(zqsafe_substringWithRange)

@end
