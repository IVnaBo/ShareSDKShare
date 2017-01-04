//
//  ViewController.m
//  ShareTypeTest
//
//  Created by BOBO on 16/12/29.
//  Copyright © 2016年 BOBO. All rights reserved.
//

#import "ViewController.h"
#import "ShareView.h"

#import "UIView+Extension.h"
@interface ViewController ()

@property(strong,nonatomic)ShareView * shareV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(100, 100, 100, 35);
    [shareBtn setTitle:@"share" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)shareAction:(UIButton *)sender
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ShareView *)shareV
{
    if (!_shareV) {
        _shareV = [[ShareView alloc]init];
    }
    return _shareV;
}

@end
