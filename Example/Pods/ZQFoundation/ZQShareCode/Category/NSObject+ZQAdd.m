//
//  NSObject+ZQAdd.m
//  ZQDemoApp
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2018/8/24.
//  Copyright © 2018年 张泉. All rights reserved.
//

#import "NSObject+ZQAdd.h"
#import <objc/runtime.h>

//交换类的实例方法参数 Class 请传实例对象的类: self / [self class] /
static void _exchanged_instance_method(SEL originalSelector, SEL swizzledSelector, Class class){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //将原来方法的选择子指向新的方法实现（新方法的方法指针imp）
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {//将新方法的选择子指向原来的方法实现（原方法的IMP）
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
//交换类方法参数 Class 请传元类: object_getClass((id)self)
static void _exchanged_class_method(SEL originalSelector, SEL swizzledSelector, Class class){
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    //将原来方法的选择子指向新的方法实现（新方法的方法指针imp）
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {//将新方法的选择子指向原来的方法实现（原方法的IMP）
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


BOOL class_swizzleMethodAndStore(Class class, SEL original, IMP replacement, IMPPointer store) {
    IMP imp = NULL;
    Method method = class_getInstanceMethod(class, original);
    if (method) {
        const char *type = method_getTypeEncoding(method);
        imp = class_replaceMethod(class, original, replacement, type);
        if (!imp) {
            imp = method_getImplementation(method);
        }
    }
    if (imp && store) { *store = imp; }
    return (imp != NULL);
}




@implementation NSObject (ZQAdd)

+ (NSArray *)fetchIvarList {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String:ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)fetchPropertyList {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++)
    {
        const char *propertyName = property_getAttributes(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)fetchInstanceMethodList {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++)
    {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)fetchClassMethodList{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(object_getClass(self), &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++)
    {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)fetchProtocolList {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ )
    {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String:protocolName]];
    }
    
    return [NSArray arrayWithArray:mutableList];
}

/** 将一个方法选择子指向一个新的实现 */
+ (void)addMethod:(SEL)methodSel newMethodSel:(SEL)newMethodSel {
    Method method = class_getInstanceMethod(self, newMethodSel);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(self, methodSel, methodIMP, types);
}

/** 实例方法交换 */
+ (BOOL)swapMethod:(SEL)originMethod currentMethod:(SEL)currentMethod {
    Method firstMethod = class_getInstanceMethod(self, originMethod);
    Method secondMethod = class_getInstanceMethod(self, currentMethod);
    if (!firstMethod || !secondMethod) return NO;
    method_exchangeImplementations(firstMethod, secondMethod);
    return  YES;
}

/** 类方法交换 */
+ (BOOL)swapClassMethod:(SEL)originMethod currentMethod:(SEL)currentMethod {
    
    Method firstMethod = class_getClassMethod(object_getClass(self), originMethod);
    Method secondMethod = class_getClassMethod(object_getClass(self), currentMethod);
    if (!firstMethod || !secondMethod) return NO;
    method_exchangeImplementations(firstMethod, secondMethod);
    return YES;
}



//标准的方法交换的实现
+ (BOOL)swizzle:(SEL)original with:(IMP)replacement store:(IMPPointer)store {
    return class_swizzleMethodAndStore(self, original, replacement, store);
}

//交换实例方法
+ (void)exchangeInstanceMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector andClass:(Class) target{
    _exchanged_instance_method(originalSelector, swizzledSelector, target);
}
//交换类方法
+ (void)exchangeClassMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector andClass:(Class) target{
    _exchanged_class_method(originalSelector, swizzledSelector, target);
}



@end
