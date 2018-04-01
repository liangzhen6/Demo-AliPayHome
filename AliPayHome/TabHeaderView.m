//
//  TabHeaderView.m
//  AliPayHome
//
//  Created by shenzhenshihua on 2018/3/30.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "TabHeaderView.h"
@interface TabHeaderView ()
@property(nonatomic,weak)UITableView * tableView;
@end
@implementation TabHeaderView
+ (id)tabHeaderView {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    TabHeaderView * header = [nib instantiateWithOwner:nil options:nil].firstObject;
    return header;
}

- (void)handleanGesture:(UITableView *)tableView {
    _tableView = tableView;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handPanAction:)];
//    self.userInteractionEnabled = NO;
//    [self addGestureRecognizer:pan];
    
//    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
//    down.direction=UISwipeGestureRecognizerDirectionDown;
//    [self addGestureRecognizer:down];
//    pan.delegate = self;
//    for (UIGestureRecognizer * ges in tableView.gestureRecognizers) {
//        if ([ges isKindOfClass:[UIPanGestureRecognizer class]]) {
//            pan = [(UIPanGestureRecognizer *)ges mutableCopy];
//            break;
//        }
//    }
    
//    [self addGestureRecognizer:pan];
    
}
//- (void)handleSwipes:(UISwipeGestureRecognizer *)gen {
//    CGPoint point = [gen translationInView:pan.view];
//
//    NSLog(@"向下");
//}
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.nextResponder touchesMoved:touches withEvent:event];
//}
- (void)handPanAction:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:pan.view];
    
    NSLog(@"---%f",point.y);
    static CGFloat startY = -1000000;
    CGFloat changeY = -1000000;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            {
//                startY = point.y;
                startY = _tableView.contentOffset.y;
            }
            break;
        case UIGestureRecognizerStateChanged:
            {
                changeY = point.y;
                [_tableView setContentOffset:CGPointMake(0, startY - changeY)];
                NSLog(@"--3666-aaa%f---%f",startY,changeY);
                
            }
            break;
        case UIGestureRecognizerStateEnded:
            {
                [_tableView setContentOffset:CGPointMake(0, startY)];
            }
            break;
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
