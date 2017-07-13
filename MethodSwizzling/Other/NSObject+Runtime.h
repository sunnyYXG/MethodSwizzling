//
//  NSObject+Runtime.h
//  MethodSwizzling
//
//  Created by rongyun on 2017/7/12.
//  Copyright © 2017年 YXGang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)


/** 实例方法交换 */
+ (void)swapMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;

/** 类方法交换 */
+ (void)swapClassMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;

@end
