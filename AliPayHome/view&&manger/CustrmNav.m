//
//  CustrmNav.m
//  AliPayHome
//
//  Created by shenzhenshihua on 2018/3/30.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "CustrmNav.h"
@interface CustrmNav ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *plusup;
@property (weak, nonatomic) IBOutlet UIImageView *firend;
@property (weak, nonatomic) IBOutlet UIImageView *sao;
@property (weak, nonatomic) IBOutlet UIImageView *pay;
@property (weak, nonatomic) IBOutlet UIImageView *search;
@property (weak, nonatomic) IBOutlet UIImageView *get;
@property (weak, nonatomic) IBOutlet UIImageView *plusdown;

@end
@implementation CustrmNav

+ (id)custrmNav {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    CustrmNav * nav = [nib instantiateWithOwner:nil options:nil].firstObject;
    [nav updateAlpha:0.0];
    nav.frame = CGRectMake(0, 0, Screen_Width, MP_NavBarHeight);
    return nav;
}

- (void)updateAlpha:(float)alpha {
    //上部分
    _sao.alpha = (alpha-0.5) * 2;
    _pay.alpha = (alpha-0.5) * 2;
    _plusup.alpha = (alpha-0.5) * 2;
    _get.alpha = (alpha-0.5) * 2;
    _search.alpha = (alpha-0.5) * 2;
    //下部分
    _searchBar.alpha = 1 - alpha * 2;
    _plusdown.alpha = 1 - alpha * 2;
    _firend.alpha = 1 - alpha * 2;
    //当滑到一定的位置，背景变成有色
    if (alpha >= 1.0) {
        self.backgroundColor = MP_RGBColor(27, 107, 200);
    } else {
        self.backgroundColor = [UIColor clearColor];
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
