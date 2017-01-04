//
//  CL_ShareButton.m
//  ShareV
//
//  Created by BOBO on 17/1/3.
//  Copyright © 2017年 BOBO. All rights reserved.
//

#import "ShareButton.h"
#import "UIView+Extension.h"
@implementation ShareButton



- (UIEdgeInsets)imageEdgeInsets{
    
    return UIEdgeInsetsMake(0,
                            15*wid_scale,
                            30*wid_scale,
                            15*wid_scale);
}

- (instancetype)initWithFrame:(CGRect)frame
                    ImageName:(NSString *)imageName
                        title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpShareButtonImageName:imageName
                                  title:title];
    }
    return self;
}

- (void)setUpShareButtonImageName:(NSString *)imageName
                            title:(NSString *)title
{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5,0,self.width-5,self.width-5)];

    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:imageName];
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+5, self.width, 10)];
    label.textColor = [UIColor blackColor];
    label.text = title;
    label.font = [UIFont systemFontOfSize:10.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
}

@end
