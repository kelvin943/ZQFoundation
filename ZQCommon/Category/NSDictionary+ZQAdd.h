//
//  NSDictionary+ZQAdd.h
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ZQSafe)

- (NSString*)stringObjectForKey:(id)aKey;
- (int)intValueForKey:(id)aKey;
- (float)floatValueForKey:(id)aKey;
- (double)doubleValueForKey:(id)aKey;
- (long) longValueForKey:(id) aKey;
- (BOOL)boolValueForKey:(id)aKey;
- (long long) longLongValueForKey:(id) aKey;
- (unsigned long long) unsignedLongLongValueForKey:(id) aKey;
- (NSUInteger)unsignedIntegerValueForKey:(id) aKey;

- (nullable NSArray*)arrayObjectForKey:(id)aKey;
- (nullable NSDictionary*)dictionaryObjectForKey:(id)aKey;

- (nullable id)myObjectForKey:(id)aKey;

@end


@interface NSDictionary (ZQTraversing)

- (void)each:(void (^)(id k, id v))block;
- (void)eachKey:(void (^)(id k))block;
- (void)eachValue:(void (^)(id v))block;

@end

NS_ASSUME_NONNULL_END
