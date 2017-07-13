//
//  NSString+Save.m
//  MethodSwizzling
//
//  Created by rongyun on 2017/7/12.
//  Copyright © 2017年 YXGang. All rights reserved.
//

#import "NSString+Save.h"
#import <objc/runtime.h>
@implementation NSString (Save)
//成员方法用class_getInstanceMethod获取 类方法用class_getClassMethod获取
+ (void)load{
    Method originalMethod = class_getClassMethod([self class], @selector(lowercasestring));
    
    Method swappedMethod = class_getClassMethod([self class], @selector(uppercasestring));

    method_exchangeImplementations(originalMethod, swappedMethod);
}

+ (NSString *)lowercasestring{
    return @"lowercasestring";
}

+ (NSString *)uppercasestring{
    return @"uppercasestring";
}

@end
