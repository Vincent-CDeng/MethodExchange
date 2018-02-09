//
//  FontScaleManager.h
//  MethodReplacingDemo
//
//  Created by Vincent on 2018/2/8.
//  Copyright © 2018年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FontScaleManager : NSObject
+(FontScaleManager*)sharedManager;

-(CGFloat)currentScale;
-(void)updateFontScaleWithIndex:(NSInteger)tag;
-(void)setCurrentScale:(CGFloat)size;
- (BOOL)shouldChangeSizeWith:(UIView*)objc;
@end
