//
//  SlideManger.m
//  AliPayHome
//
//  Created by shenzhenshihua on 2018/3/30.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "SlideManger.h"
#import <UIKit/UIKit.h>
#import "CustrmNav.h"
#import "NavBarBottomView.h"
@interface SlideManger ()<NSCopying, NSMutableCopying>
@property(nonatomic,weak)NavBarBottomView * navBottmView;
@property(nonatomic,weak)NavBarBottomView * navBAView;

@property(nonatomic,weak)UIView * tabHeader;
@property(nonatomic,weak)CustrmNav * customNav;

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

- (void)slideMangerCustomNav:(UIView *)customNav navBottm:(UIView *)navBottmView tabHeader:(UIView *)tabHeader navBottomActionView:(UIView *)navBAView; {
    if (navBottmView) {
        _navBottmView = (NavBarBottomView *)navBottmView;
    }
    if (tabHeader) {
        _tabHeader = tabHeader;
    }
    if (customNav) {
        _customNav = (CustrmNav *)customNav;
    }
    if (navBAView) {
        _navBAView = (NavBarBottomView *)navBAView;
    }
}
//滑动的时候
- (void)tableViewSlide:(CGFloat)slide {
    if (_navBottmView && _tabHeader) {
        //得到真实的偏移量
        CGFloat slideY = slide + _navBottmView.height + _tabHeader.height;
//        NSLog(@"******%f",slideY);
        [self handleTabHeader:slideY];
        [self handleCustomNavNavBottom:slideY];
    }
}
//tableView 停止的时候
- (void)tabViewEndSlide:(CGFloat)slide scrollView:(UIScrollView *)scrollView {
    if (_navBottmView && _tabHeader) {
        //得到真实的偏移量
        CGFloat slideY = slide + _navBottmView.height + _tabHeader.height;
        if (slideY > 0) {
            if (slideY >= _navBottmView.height/2 && slideY < _navBottmView.height) {
                //自动滑到上面
                [scrollView setContentOffset:CGPointMake(0, -_tabHeader.height) animated:YES];
            } else if (slideY < _navBottmView.height/2) {
                //自动滑下去
                [scrollView setContentOffset:CGPointMake(0, -(_navBottmView.height + _tabHeader.height)) animated:YES];
            }
        }
    }
}
//处理 TabHeader 跟随 tableView 滑动
- (void)handleTabHeader:(CGFloat)slide {
  static BOOL isDown = NO;
    if (slide <= 0) {
        _navBAView.hidden = NO;
        _navBottmView.hidden = YES;
        _tabHeader.y = -_tabHeader.height + slide;
        _navBAView.y = -(_navBottmView.height + _tabHeader.height) + slide;
        isDown = YES;
    } else {
        _navBAView.hidden = YES;
        _navBottmView.hidden = NO;
        if (isDown) {
            _tabHeader.y = -_tabHeader.height;
            isDown = NO;
        }
    }
}
//处理customnav  的渐变色问题 以及navbottom 的位置 渐变色问题
- (void)handleCustomNavNavBottom:(CGFloat)slide {
    if (slide >= 0) {
        CGFloat halfNavBottomH = _navBottmView.height/2;
        CGFloat alpValue = (_navBottmView.height - slide)?(_navBottmView.height - slide):0;
        [_navBottmView updateAlpha:alpValue/_navBottmView.height];
        [_customNav updateAlpha:slide/_navBottmView.height];
        if (slide<= _navBottmView.height) {
            _navBottmView.y = _customNav.height - slide/2;
        } else {
            _navBottmView.y = _customNav.height - halfNavBottomH;
        }
    } else {
        [_navBottmView updateAlpha:1.0];
        [_customNav updateAlpha:0.0];
        _navBottmView.y = _customNav.height;
    }
}

@end
