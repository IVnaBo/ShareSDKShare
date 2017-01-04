//
//  CL_ShareButton.h
//  ShareV
//
//  Created by BOBO on 17/1/3.
//  Copyright © 2017年 BOBO. All rights reserved.
//

#import <UIKit/UIKit.h>
#define wid_scale [UIScreen mainScreen].bounds.size.width/375.0f
@interface ShareButton : UIButton


- (instancetype)initWithFrame:(CGRect)frame
                    ImageName:(NSString *)imageName
                        title:(NSString *)title;
@end
