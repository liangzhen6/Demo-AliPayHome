//
//  SlideManger.m
//  AliPayHome
//
//  Created by shenzhenshihua on 2018/3/30.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "SlideManger.h"
#import <UIKit/UIKit.h>
@interface SlideManger ()<NSCopying, NSMutableCopying>
@property(nonatomic,weak)UIView * navBottmView;
@property(nonatomic,weak)UIView * tabHeader;
@property(nonatomic,weak)UIView * customNav;

@end
static SlideManger * _slideManger = nil;
@implementation SlideManger
+ (id)shareSlideManger {
    return [[self alloc] init];
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_slideManger == nil) {
            _slideManger = [super allocWithZone:zone];
        }
    });
    return _slideManger;
}

- (id)copyWithZone:(NSZone *)zone {
    return _slideManger;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _slideManger;
}

- (void)slideMangerCustomNav:(UIView *)customNav navBottm:(UIView *)navBottmView tabHeader:(UIView *)tabHeader {
    if (navBottmView) {
        _navBottmView = navBottmView;
    }
    if (tabHeader) {
        _tabHeader = tabHeader;
    }
    if (customNav) {
        _customNav = customNav;
    }
}

- (void)tableViewSlide:(CGFloat)slide {
    if (_navBottmView && _tabHeader) {
        //得到真实的偏移量
        CGFloat slideY = slide + _navBottmView.height + _tabHeader.height;
        NSLog(@"******%f",slideY);
        [self handleTabHeader:slideY];
    }
}
//处理 TabHeader 跟随 tableView 滑动
- (void)handleTabHeader:(CGFloat)slide {
    if (slide >= 0) {
        _tabHeader.y = _customNav.height + _navBottmView.height - slide;
    } else {
        _tabHeader.y = _customNav.height + _navBottmView.height;
    }
    
}

@end
