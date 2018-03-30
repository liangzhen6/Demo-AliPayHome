//
//  NavBarBottomView.m
//  AliPayHome
//
//  Created by shenzhenshihua on 2018/3/30.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "NavBarBottomView.h"
@interface NavBarBottomView ()
@property (weak, nonatomic) IBOutlet UIView *saoView;
@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIView *getView;

@end
@implementation NavBarBottomView
+ (id)navBarBottomView {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    NavBarBottomView * barBottom = [nib instantiateWithOwner:nil options:nil].firstObject;
    return barBottom;
}

- (void)updateAlpha:(float)alpha {
    //更新透明度
    _saoView.alpha = alpha;
    _payView.alpha = alpha;
    _getView.alpha = alpha;
    _cardView.alpha = alpha;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
