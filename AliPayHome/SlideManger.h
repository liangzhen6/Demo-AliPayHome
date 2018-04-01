//
//  SlideManger.h
//  AliPayHome
//
//  Created by shenzhenshihua on 2018/3/30.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIView;
@interface SlideManger : NSObject
+ (id)shareSlideManger;

- (void)slideMangerCustomNav:(UIView *)customNav navBottm:(UIView *)navBottmView tabHeader:(UIView *)tabHeader navBottomActionView:(UIView *)navBAView;

- (void)tableViewSlide:(CGFloat)slide;

- (void)tabViewEndSlide:(CGFloat)slide scrollView:(UIScrollView *)scrollView;

@end
