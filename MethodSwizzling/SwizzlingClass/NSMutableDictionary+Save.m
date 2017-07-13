//
//  NSMutableDictionary+Save.m
//  MethodSwizzling
//
//  Created by rongyun on 2017/7/12.
//  Copyright © 2017年 YXGang. All rights reserved.
//

#import "NSMutableDictionary+Save.h"
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
