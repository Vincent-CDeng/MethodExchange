//
//  NSObject+CDMethodReplacing.h
//  MethodReplacingDemo
//
//  Created by Vincent on 2018/2/8.
//  Copyright © 2018年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CDMethodReplacing)
+ (void)CD_replaceMethod:(SEL)origianlMethod withMethod:(SEL)replacement inClass:(Class)cls;
@end
