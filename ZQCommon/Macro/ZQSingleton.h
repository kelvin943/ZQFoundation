//
//  ZQSingleton.h
//  ZQCustomView
//
//  Created by Macro on 16/8/29.
//  Copyright © 2016年 Macro. All rights reserved.
//

//单例宏


#ifndef ZQSingleton_h
#define ZQSingleton_h

// .h文件
#define ZQSingletonH(name) \
+ (instancetype)shared##name;
// .m文件
#define ZQSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}


#endif /* ZQSingleton_h */
