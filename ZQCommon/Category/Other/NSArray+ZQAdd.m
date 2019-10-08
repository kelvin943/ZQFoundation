//
//  NSArray+ZQAdd.m
//  ZQFoundation
//
//  Created by macro on 2019/9/11.
//

#import "NSArray+ZQAdd.h"

#import "ZQMacros.h"
ZQCATEGORY_DUMMY_CLASS(NSArray_ZQAdd)

/*
************************************************************************************
*NSDictionary与NSArray的分类, 控制台打印json数据中的中文
************************************************************************************
*/

@implementation NSArray (ZQPrint)
#ifdef DEBUG
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    
    return strM;
}
#endif
@end


@implementation NSDictionary (ZQPrint)
#ifdef DEBUG
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
#endif
@end

