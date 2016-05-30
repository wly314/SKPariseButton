//
//  ViewController.m
//  SKPariseButtonDemo
//
//  Created by Leou on 16/5/30.
//  Copyright © 2016年 Leou. All rights reserved.
//

#import "ViewController.h"

#import "SKPariseButton.h"
#import "SKPariseView.h"

@interface ViewController ()<UIWebViewDelegate> {
    
    UIWebView *webViews;
    
    BOOL      isCanGoBack;
    BOOL       isBack;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SKPariseButton *pariseBtn = [[SKPariseButton alloc] initWithFrame:CGRectMake(10, 100, 100, 50)];
    pariseBtn.backgroundColor = [UIColor brownColor];
    [self.view addSubview:pariseBtn];
    pariseBtn.skPariseHandler = ^(SKPariseButton *obj) {
        
        obj.isPariseSelected = NO;
    };
    
    SKPariseView *pariseView = [[SKPariseView alloc] initWithFrame:CGRectMake(10, 200, 100, 50)];
    pariseView.textColor = [UIColor grayColor];
    pariseView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:pariseView];
    [pariseView addTargetHandler:^(id obj) {
        
        SKPariseView *pariseView = (SKPariseView *)obj;
        
        pariseView.isPariseSelected = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
