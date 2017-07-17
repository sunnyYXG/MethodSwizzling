//
//  NSDictionary+Save.m
//  MethodSwizzling
//
//  Created by rongyun on 2017/7/12.
//  Copyright © 2017年 YXGang. All rights reserved.
//

#import "NSDictionary+Save.h"
//#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Save)

+ (void)load{
    [NSClassFromString(@"__NSDictionaryM") swapMethod:@selector(setObject:forKey:) currentMethod:@selector(yxg_setObject:forKey:)];
}

- (void)yxg_setObject:(id)anObject forKey:(id <NSCopying>)aKey{
    if (!anObject) {
        NSLog(@"---------- %s No Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
        return;
    }
    if (!aKey) {
        NSLog(@"---------- %s No Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
        return;
    }
    [self yxg_setObject:anObject forKey:aKey];
}

@end

@implementation NSDictionary (Save)

+ (void)load{
    [NSClassFromString(@"__NSPlaceholderDictionary") swapMethod:@selector(initWithObjects:forKeys:count:) currentMethod:@selector(yxg_initWithObjects:forKeys:count:)];
}

- (instancetype)yxg_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt{
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++)
    {
        id key = keys[i];
        id obj = objects[i];
        if (!key)
        {
            continue;
        }
        if (!obj)
        {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }

    return [self yxg_initWithObjects:objects forKeys:keys count:cnt];
}

@end
