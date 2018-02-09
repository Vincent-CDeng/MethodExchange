//
//  UILabel+DynamicFont.m
//  MethodReplacingDemo
//
//  Created by Vincent on 2018/2/8.
//  Copyright © 2018年 Vincent. All rights reserved.
//

#import "UILabel+DynamicFont.h"
#import "NSObject+CDMethodReplacing.h"
#import <objc/runtime.h>
#import "FontScaleManager.h"

@implementation UILabel (DynamicFont)


- (CGFloat)originalSize{
    
  return  [objc_getAssociatedObject(self, @selector(originalSize)) floatValue];
    
}
- (void)setOriginalSize:(CGFloat)originalSize{
    
    objc_setAssociatedObject(self, @selector(originalSize), @(originalSize), OBJC_ASSOCIATION_RETAIN);
}

+ (void)load{
    
  
        [self CD_replaceMethod:@selector(initWithCoder:) withMethod:@selector(replaced_initWithCoder:) inClass:self.class];
        [self CD_replaceMethod:@selector(initWithFrame:) withMethod:@selector(replaced_initWithFrame:) inClass:self.class];
        [self CD_replaceMethod:@selector(setText:) withMethod:@selector(replaced_setText:) inClass:self.class];
    
        
 
}

-(void)replaced_setText:(NSString*)text{
    
    
    
    NSLog(@"text:%@",text);
    // 自定义某些情况下不需要有变化
    if ([[FontScaleManager sharedManager] shouldChangeSizeWith:self]) {
        [self updateFont:self.font];
    }
    [self replaced_setText:text];
}



- (void)updateFont:(UIFont*)font{
    
    CGFloat scale =  [[FontScaleManager  sharedManager ]currentScale];
    if (scale != 0) {
        if (self.originalSize == 0) {
            font = [UIFont fontWithName:font.fontName size:font.pointSize*scale];
            
        }else{
            
            font = [UIFont fontWithName:font.fontName size:self.originalSize*scale];
        }
    }
    
    [self setFont:font];
    
        
    
}
- (id)replaced_initWithFrame:(CGRect)frame{
    UILabel* result = (UILabel*)[self replaced_initWithFrame:frame];
    
    if (![[FontScaleManager sharedManager] shouldChangeSizeWith:result]) {
        
        return result;
    }
    
    self.originalSize = result.font.pointSize;
    [self updateFont:self.font];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontDidChagne:) name:kFontChangeNotification object:nil];

    
    return result;
    
}

- (id)replaced_initWithCoder:(NSCoder *)aDecoder{

    UILabel* result = (UILabel*)[self replaced_initWithCoder:aDecoder];
    if (![[FontScaleManager sharedManager] shouldChangeSizeWith:result]) {
        
        return result;
    }
    self.originalSize = result.font.pointSize;
    [self updateFont:self.font];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontDidChagne:) name:kFontChangeNotification object:nil];

    return result;
}
#pragma mark change size
-(void)fontDidChagne:(NSNotification*)noti{
    
    [self updateFont:self.font];

}


@end
