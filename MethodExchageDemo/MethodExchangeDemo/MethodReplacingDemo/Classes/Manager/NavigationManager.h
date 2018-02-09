//
//  NavigationManager.h
//  MethodReplacingDemo
//
//  Created by Vincent on 2018/2/4.
//  Copyright © 2018年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NavigationManager : NSObject

+(instancetype)sharedManager;
-(UIViewController*)rootViewController;

@end
