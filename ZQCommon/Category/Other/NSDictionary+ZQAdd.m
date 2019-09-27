//
//  NSDictionary+ZQAdd.m
//  ZQFoundation
//
//  Created by macro on 2019/9/11.
//

#import "NSDictionary+ZQAdd.h"


#import "ZQMacros.h"
ZQCATEGORY_DUMMY_CLASS(NSDictionary_ZQAdd)

@implementation NSDictionary (ZQSafe)

- (NSString*)stringObjectForKey:(id)aKey {
    id object = [self myObjectForKey:aKey];
    return [object description];
}
- (int)intValueForKey:(id)aKey {
    id object = [self myObjectForKey:aKey];
    if ([object respondsToSelector:@selector(intValue)]) {
        return [object intValue];
    }
    return 0;
    
}
- (float)floatValueForKey:(id)aKey {
    id object = [self myObjectForKey:aKey];
    if ([object respondsToSelector:@selector(floatValue)]) {
        return [object floatValue];
    }
    return 0;
}

- (double)doubleValueForKey:(id)aKey {
    id object = [self myObjectForKey:aKey];
    if ([object respondsToSelector:@selector(doubleValue)]) {
        return [object doubleValue];
    }
    return 0;
}

-(long) longValueForKey:(id) aKey {
    id object = [self myObjectForKey:aKey];
    if ([object respondsToSelector:@selector(longValue)]) {
        return [object longValue];
    } else if ([object respondsToSelector:@selector(integerValue)]) {
        return [object integerValue];
    }
    return 0;
}

-(NSUInteger)unsignedIntegerValueForKey:(id) aKey {
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(unsignedIntegerValue)]) {
        return [object unsignedIntegerValue];
    }
    return 0;
}

-(long long) longLongValueForKey:(id) aKey {
    id object = [self myObjectForKey:aKey];
    if ([object respondsToSelector:@selector(longLongValue)]) {
        return [object longLongValue];
    }
    return 0;
}

-(unsigned long long) unsignedLongLongValueForKey:(id) aKey {
    id object = [self myObjectForKey:aKey];
    if (object == [NSNull null]) {
        return  0;
    }
    if ([object respondsToSelector:@selector(unsignedLongLongValue)]) {
        return [object unsignedLongLongValue];
    }
    return 0;
}

- (BOOL)boolValueForKey:(id)aKey {
    id object = [self myObjectForKey:aKey];
    if (object == [NSNull null]) {
        return  0;
    }
    if ([object respondsToSelector:@selector(boolValue)]) {
        return [object boolValue];
    }
    return 0;
}

- (NSArray*)arrayObjectForKey:(id)aKey {
    id object = [self myObjectForKey:aKey];
    if (![object isKindOfClass:[NSArray class]]) {
        return  nil;
    }
    return object;
}

- (NSDictionary*)dictionaryObjectForKey:(id)aKey {
    id object = [self myObjectForKey:aKey];
    if ([object isKindOfClass:[NSString class]]) {
        NSString* jsonstr = (NSString*)object;
        NSData *jsonData = [jsonstr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&err];
        if (err) {
            return nil;
        }
    }
    if (![object isKindOfClass:[NSDictionary class]]) {
        return  nil;
    }
    return object;
}


- (id)myObjectForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if (object == [NSNull null]) {
        return nil;
    }
    return object;
}

@end

@implementation NSDictionary (ZQTraversing)

- (void)each:(void (^)(id k, id v))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(key, obj);
    }];
}

- (void)eachKey:(void (^)(id k))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(key);
    }];
}

- (void)eachValue:(void (^)(id v))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(obj);
    }];
}

@end
