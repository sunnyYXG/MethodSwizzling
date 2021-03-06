//
//  NSArray+Save.m
//  MethodSwizzling
//
//  Created by rongyun on 2017/7/12.
//  Copyright © 2017年 YXGang. All rights reserved.
//

#import "NSArray+Save.h"
#import <objc/runtime.h>

//#import "NSObject+Runtime.h"
/**
 在iOS中NSNumber、NSArray、NSDictionary等这些类都是类簇，一个NSArray的实现可能由多个类组成。
 所以如果想对NSArray进行Swizzling，必须获取到其“真身”进行Swizzling，直接对NSArray进行操作是无效的。
 
 下面列举了NSArray和NSDictionary本类的类名，可以通过Runtime函数取出本类。
 NSArray                __NSArrayI
 NSMutableArray         __NSArrayM
 NSDictionary           __NSDictionaryI
 NSMutableDictionary	__NSDictionaryM
 */

@implementation NSArray (Save)

// Swizzling核心代码
// 需要注意的是，好多同学反馈下面代码不起作用，造成这个问题的原因大多都是其调用了super load方法。在下面的load方法中，不应该调用父类的load方法。 GCD方法就是在调用super load方法的基础下来控制Swizzling只调换一次
+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
//        Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(yxg_objectAtIndex:));
//        method_exchangeImplementations(fromMethod, toMethod);
//        
//    });
    
    [NSClassFromString(@"__NSArrayI") swapMethod:@selector(objectAtIndex:)
                                   currentMethod:@selector(yxg_objectAtIndex:)];

}

// 为了避免和系统的方法冲突，我一般都会在swizzling方法前面加前缀
- (id)yxg_objectAtIndex:(NSUInteger)index {
    // 判断下标是否越界，如果越界就进入异常拦截
    if (self.count-1 < index) {
        @try {
            return [self yxg_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息。如果是线上，可以在这里将崩溃信息发送到服务器
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } // 如果没有问题，则正常进行方法调用
    else {
        return [self yxg_objectAtIndex:index];
    }
}
@end

@implementation NSMutableArray (Save)

+ (void)load{
    [NSClassFromString(@"__NSArrayM") swapMethod:@selector(addObject:)
                                   currentMethod:@selector(yxg_addObject:)];

}

- (void)yxg_addObject:(id)anObject{
    if (!anObject)
    {
        NSLog(@"---------- %s No Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
        return;
    }
    [self yxg_addObject:anObject];
}
@end
