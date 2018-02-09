//
//  SettingViewController.m
//  MethodReplacingDemo
//
//  Created by Vincent on 2018/2/4.
//  Copyright © 2018年 Vincent. All rights reserved.
//

#import "SettingViewController.h"
#import "FontScaleManager.h"
@interface SettingViewController ()
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation SettingViewController

#pragma mark touch event

- (IBAction)sizeViewDidTouch:(UITapGestureRecognizer*)tap{
    
    [[FontScaleManager sharedManager] updateFontScaleWithIndex:tap.view.tag];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Setting";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        [self enlargerBackTitle:self.navigationController.navigationBar];
    });
    // Do any additional setup after loading the view from its nib.
}

- (void)enlargerBackTitle:(UIView*)view{
    
    NSString*className = NSStringFromClass(view.class);
    if ([className containsString:@"UIModernBarButton"]) {
        
        NSLog(@"UIButtonLabel:%@",NSStringFromCGRect(view.frame));
        CGRect frame = view.frame;
        frame.size.width = 100;
        view.frame = frame;
        
    }else{
        
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [self enlargerBackTitle:obj];
        }];
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
