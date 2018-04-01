//
//  TabHeaderView.m
//  AliPayHome
//
//  Created by shenzhenshihua on 2018/3/30.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "TabHeaderView.h"
@interface TabHeaderView ()

@end
@implementation TabHeaderView
+ (id)tabHeaderView {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    TabHeaderView * header = [nib instantiateWithOwner:nil options:nil].firstObject;
    return header;
}
-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击了tableView 头上的方格子");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
