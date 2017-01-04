//
//  ShareView.m
//  ShareV
//
//  Created by BOBO on 17/1/4.
//  Copyright © 2017年 BOBO. All rights reserved.
//

#import "ShareView.h"
#import "UIView+Extension.h"
#import "ShareButton.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#define iphone_w [UIScreen mainScreen].bounds.size.width
#define item_w iphone_w * 0.15
#define space (iphone_w-40-item_w*5)/4.0

@interface ShareView ()
@property(strong,nonatomic)UIScrollView * scrollv;
//分享参数
@property(strong,nonatomic)NSMutableDictionary * parm;
@end
@implementation ShareView


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00]colorWithAlphaComponent:0.35];
        self.frame = [UIScreen mainScreen].bounds;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareTapaction)];
        [self addGestureRecognizer:tap];
        [self addScrollvData];
        [self addSubview:_scrollv];
    }
    return self;
}
-(void)addScrollvData
{
    NSArray * imgArr = @[@"xn_share_wx",@"xn_share_wx1",@"xn_share_sina",@"xn_share_qq",@"xn_share_qqzone"];
    NSArray * titlesArr = @[@"微信",@"微信朋友圈",@"新浪微博",@"QQ",@"QQ空间"];
    for ( int i = 0; i<imgArr.count; i++) {
        
        ShareButton * btn = [[ShareButton alloc]initWithFrame:CGRectMake(20+(item_w+space) * i, 15, item_w, item_w+15) ImageName:imgArr[i] title:titlesArr[i]];
        btn.tag = 500 +i;
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollv addSubview:btn];
    }
    
}
-(void)shareshowSetupParmImg:(id)img
                            andText:(NSString *)text
                           andTitle:(NSString *)title
                          andUrlstr:(NSString*)urlstr
{
    //视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    //动作
   _parm = [NSMutableDictionary dictionary];
   [_parm SSDKSetupShareParamsByText:text images:img url:[NSURL URLWithString:urlstr] title:title type:SSDKContentTypeAuto];
    
   
    
}



-(void)shareTapaction
{
    [self dismiss:YES];
}
-(void)dismiss:(BOOL)animate
{
    if (!animate) {
        [self removeFromSuperview];
        return;
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)shareBtnClick:(UIButton *)sender
{
    //@[@"微信",@"微信朋友圈",@"新浪微博",@"QQ",@"QQ空间"]
    switch (sender.tag) {
        case 500:
            if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat ]) {
                
                [self shareSDKAction:SSDKPlatformSubTypeWechatSession andTitle:@"微信"];
            }else{
               NSLog(@"微信未安装");
            }
            
            break;
        case 501:
            if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat ]) {
                
                [self shareSDKAction:SSDKPlatformSubTypeWechatSession andTitle:@"微信朋友圈"];
            }else{
                NSLog(@"微信未安装");
            }
            [self shareSDKAction:SSDKPlatformSubTypeWechatTimeline andTitle:@"微信朋友圈"];
            break;
        case 502:
            if ([ShareSDK isClientInstalled:SSDKPlatformTypeSinaWeibo ]) {
                
                [self shareSDKAction:SSDKPlatformTypeSinaWeibo andTitle:@"微博"];
            }else{
                NSLog(@"新浪微博未安装");
            }
            break;
        case 503:
            if ([ShareSDK isClientInstalled:SSDKPlatformTypeQQ ]) {
                
                [self shareSDKAction:SSDKPlatformSubTypeQQFriend andTitle:@"QQ"];
            }else{
                NSLog(@"QQ未安装");
            }
            break;
        case 504:
            if ([ShareSDK isClientInstalled:SSDKPlatformSubTypeQQFriend]||[ShareSDK isClientInstalled:SSDKPlatformTypeQQ]) {
                [self shareSDKAction:SSDKPlatformSubTypeQZone andTitle:@"QQ空间"];
            }else{
               NSLog(@"QQ未安装");
            }
            
        default:
            break;
    }
    
    [self dismiss:YES];
}
-(void)shareSDKAction:(SSDKPlatformType)type andTitle:(NSString*)title
{
    [ShareSDK share:type parameters:_parm onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                NSString * callback = [NSString stringWithFormat:@"%@分享成功",title];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:callback
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
    }];
}
-(UIScrollView *)scrollv
{
    if (!_scrollv) {
        _scrollv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.height-150, iphone_w, 150)];
        _scrollv.backgroundColor = [UIColor colorWithRed:0.74 green:0.75 blue:0.75 alpha:1.00];
        _scrollv.showsVerticalScrollIndicator = NO;
        _scrollv.showsHorizontalScrollIndicator= NO;
    }
    return _scrollv;
}
@end
