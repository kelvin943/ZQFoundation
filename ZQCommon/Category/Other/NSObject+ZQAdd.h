//
//  NSObject+ZQAdd.h
//  ZQDemoApp
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2018/8/24.
//  Copyright © 2018年 张泉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef IMP* IMPPointer;

#define ZQExchangeInstanceMethod(__oriSel__,__newSel__,__class__ )      \
    [NSObject exchangeInstanceMethod:__oriSel__                         \
                          withMethod:__newSel__                         \
                            andClass:__class__];                        \

#define ZQExchangeClassMethod(__oriSel__,__newSel__,__class__ )        \
      [NSObject exchangeClassMethod:__oriSel__                         \
                         withMethod:__newSel__                         \
                           andClass:__class__];                        \

@interface NSObject (ZQAdd)

#pragma mark - 获取类结构相关方法
/** 获取成员变量，包括属性生成的成员变量 */
+ (NSArray *)fetchIvarList;

/** 获取类的属性列表，包括私有和公有属性，也包括分类中的属性 */
+ (NSArray *)fetchPropertyList;

/** 获取对象方法列表：包括getter, setter, 分类中的方法等 */
+ (NSArray *)fetchInstanceMethodList;

/** 获取类方法列表 包括分类里面的 */
+ (NSArray *)fetchClassMethodList;

/** 获取协议列表，包括.h .m 和分类里的 */
+ (NSArray *)fetchProtocolList;


#pragma mark - 快速方法交换实现
/*交换的必须是类中存在的方法，若类中不存改方法则会交换,可能出现各种问题，方法指针会错乱*/
+ (void)addMethod:(SEL)methodSel newMethodSel:(SEL)newMethodSel;
+ (BOOL)swapMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;
+ (BOOL)swapClassMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;

#pragma mark - 标准的方法交换实现
/*可以交换类中没有的方法，若类中不存在该方法则会给类添加添加一个方法并指向新的实现*/
+ (BOOL)swizzle:(SEL)original with:(IMP)replacement store:(IMPPointer)store;
+ (void)exchangeInstanceMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector andClass:(Class) target;
+ (void)exchangeClassMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector andClass:(Class) target;
@end


@interface NSObject (Method)
- (BOOL)isNilOrNull;
- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;
@end
