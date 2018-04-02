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

/**
获取单利

 @return 返回单利对象
 */
+ (id)shareSlideManger;
/**
 将所需要处理的view 交给 manger

 @param customNav 自定义的navbar
 @param navBottmView navbar下面的view  处理点击事件
 @param tabHeader tableView 头上的方格子view
 @param navShadowView navbar下面的view 的一个影子view 只负责 滑动时的位置变化，透明改变
 */
- (void)slideMangerCustomNav:(UIView *)customNav navBottm:(UIView *)navBottmView tabHeader:(UIView *)tabHeader navBottomShadowView:(UIView *)navShadowView;
/**
 tableView滑动时调用该方法

 @param slide 滑动的距离
 */
- (void)tableViewSlide:(CGFloat)slide;
/**
 tableView 停止的时候调用

 @param slide 停止的时候tableView 的cintentoff的y值
 @param scrollView 滑动的scrollView 这里是tableView
 */
- (void)tabViewEndSlide:(CGFloat)slide scrollView:(UIScrollView *)scrollView;

@end
