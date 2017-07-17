//
//  ViewController.m
//  MethodSwizzling
//
//  Created by rongyun on 2017/7/12.
//  Copyright © 2017年 YXGang. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Save.h"
#import "UIViewController+EventGather.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"页面统计:%@", self);
//    
//    NSString *lower = [NSString lowercasestring];
//    NSLog(@"lower:%@",lower);
//    
//    NSString *upper = [NSString uppercasestring];
//    NSLog(@"upper:%@",upper);
    
    
    // 测试代码
    NSArray *array = @[@0, @1, @2, @3];
    [array objectAtIndex:3];
    [array objectAtIndex:10];
    
    //NSString 为nil
    
    NSString *str = nil;
    NSMutableArray *marrr= [NSMutableArray new];
    [marrr addObject:str];

//    NSString *aa= nil;
//    NSMutableDictionary *mdic = [NSMutableDictionary new];
//    [mdic setObject:aa forKey:@"key"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
