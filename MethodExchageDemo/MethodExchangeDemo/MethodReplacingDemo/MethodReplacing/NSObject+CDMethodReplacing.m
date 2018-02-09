//
//  NSObject+CDMethodReplacing.m
//  MethodReplacingDemo
//
//  Created by Vincent on 2018/2/8.
//  Copyright © 2018年 Vincent. All rights reserved.
//

#import "NSObject+CDMethodReplacing.h"
#import <objc/runtime.h>

@implementation NSObject (CDMethodReplacing)

+(void)CD_replaceMethod:(SEL)origianlMethod withMethod:(SEL)replacement inClass:(__unsafe_unretained Class)cls{
    
    SEL originalSelector = origianlMethod;
    SEL swizzledSelector = replacement;
    
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL isAddmethod =
    class_addMethod(cls,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    
//    方法已经被添加
    if (isAddmethod) {
        class_replaceMethod(cls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
