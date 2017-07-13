//
//  NSObject+Runtime.m
//  MethodSwizzling
//
//  Created by rongyun on 2017/7/12.
//  Copyright © 2017年 YXGang. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

+(void)swapMethod:(SEL)originMethod currentMethod:(SEL)currentMethod{
    Method firstMethod = class_getInstanceMethod(self, originMethod);
    Method secondMethod = class_getInstanceMethod(self, currentMethod);
    method_exchangeImplementations(firstMethod, secondMethod);

}

+(void)swapClassMethod:(SEL)originMethod currentMethod:(SEL)currentMethod{
    Method firstMethod = class_getClassMethod(self, originMethod);
    Method secondMethod = class_getClassMethod(self, currentMethod);
    method_exchangeImplementations(firstMethod, secondMethod);

}


@end
