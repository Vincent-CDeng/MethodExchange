//
//  NavigationManager.m
//  MethodReplacingDemo
//
//  Created by Vincent on 2018/2/4.
//  Copyright © 2018年 Vincent. All rights reserved.
//

#import "NavigationManager.h"
#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "SettingViewController.h"
#import "TestViewController.h"
@implementation NavigationManager
{
    UITabBarController*tabbarController;
    
}

+ (instancetype)sharedManager{
    static NavigationManager *shared = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shared = [[NavigationManager  alloc]init];
        [shared setupUI];
    });
    
    return shared;
}

-(UIViewController*)rootViewController{
    
    return tabbarController;
}

-(void)setupUI{
    
    UITabBarController*tabbar = [[UITabBarController alloc]init];
    
    HomeViewController*homeController = [HomeViewController new];
    homeController.title = @"Home";
    
    TestViewController*testController = [TestViewController new];
    testController.title = @"Test";
    
    
    UINavigationController*homeNAV = [[UINavigationController alloc]initWithRootViewController:homeController];
    
    UINavigationController*testNAV = [[UINavigationController alloc]initWithRootViewController:testController];
    tabbar.viewControllers = @[homeNAV,testNAV];
    
//    tabbar.tabBar.it
    
    tabbarController = tabbar;
    
    
}



@end
