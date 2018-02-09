//
//  FontScaleManager.m
//  MethodReplacingDemo
//
//  Created by Vincent on 2018/2/8.
//  Copyright © 2018年 Vincent. All rights reserved.
//

#import "FontScaleManager.h"

@implementation FontScaleManager{
    CGFloat currentScale;
    
    NSArray*excludeConfig;
    
    
}

- (BOOL)shouldChangeSizeWith:(UIView *)objc{
    
    if ([NSStringFromClass(objc.class) containsString:@"UIButtonLabel"] ) {
        
        return NO;
    }else{
        return YES;
    }
    
}


- (void)updateFontScaleWithIndex:(NSInteger)tag{
    switch (tag) {
        case 0:
            [self setCurrentScale:kSmall];
            [[NSNotificationCenter defaultCenter] postNotificationName:kFontChangeNotification object:nil userInfo:nil];
            break;
        case 1:
            [self setCurrentScale:kMedium];
            [[NSNotificationCenter defaultCenter] postNotificationName:kFontChangeNotification object:nil  userInfo:nil];
            
            
            break;
            
        case 2:
            [self setCurrentScale:kLarge];
            [[NSNotificationCenter defaultCenter] postNotificationName:kFontChangeNotification object:nil  userInfo:nil];
            
            
            break;
            
    }
    
}

- (CGFloat)currentScale{
    
    // 减少对磁盘的读写
    if (currentScale == 0) {
        NSUserDefaults*ud = [NSUserDefaults standardUserDefaults];
        CGFloat size  =  [[ud objectForKey:kFontScale] floatValue];
        
        currentScale = size;
    }
    
    return currentScale;
    
}
- (void)setCurrentScale:(CGFloat)size{
    
    currentScale = size;
    
    NSUserDefaults*ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:@(size) forKey:kFontScale];
    
    [ud synchronize];
    
}

+ (instancetype)sharedManager{
    static FontScaleManager *shared = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shared = [[FontScaleManager  alloc]init];
        shared->excludeConfig = @[
                                  @"UIButtonLabel"
                                  ];
    });
    
    return shared;
}


@end
