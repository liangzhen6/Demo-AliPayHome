//
//  HomeViewController.m
//  AliPayHome
//
//  Created by shenzhenshihua on 2018/3/30.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "HomeViewController.h"
#import "CustrmNav.h"
#import "NavBarBottomView.h"
#import "TabHeaderView.h"
#import "SlideManger.h"
#import <MJRefresh/MJRefresh.h>

@interface HomeViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataSource;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    [self initView];
    // Do any additional setup after loading the view.
}
#pragma mark ===隐藏 NavigationBar====
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)initView {
    CustrmNav * nav = [CustrmNav custrmNav];
    
    NavBarBottomView * navBottom = [NavBarBottomView navBarBottomView];
    navBottom.frame = CGRectMake(0, CGRectGetMaxY(nav.frame), Screen_Width, 80);
    [self.view addSubview:navBottom];
    
    NavBarBottomView * navBottomAction = [NavBarBottomView navBarBottomView];
    navBottomAction.frame = CGRectMake(0, -320, Screen_Width, 80);
    
    TabHeaderView * tabHeader = [TabHeaderView tabHeaderView];
    tabHeader.frame = CGRectMake(0, -240, Screen_Width, 240);
    CGFloat backH = nav.height + navBottom.height;
    CGFloat contentY = tabHeader.height + navBottom.height;
    
    //增加背景色View
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, backH)];
    backView.backgroundColor = MP_RGBColor(27, 107, 200);
    [self.view insertSubview:backView atIndex:0];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nav.frame), Screen_Width, Screen_Height-nav.height-MP_TabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //设置偏移量
    [_tableView setContentInset:UIEdgeInsetsMake(contentY , 0, 0, 0)];
    //假装tableView 从TabHeaderView 的下部开始的
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(contentY, 0, 0, 0);
    //背景透明
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView addSubview:navBottomAction];
    [_tableView addSubview:tabHeader];
    //放在顶层的 nav 应在在最外层的view
    [self.view addSubview:nav];
    
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refershAction];
    }];
    _tableView.mj_header = mj_header;
    
    [[SlideManger shareSlideManger] slideMangerCustomNav:nav navBottm:navBottom tabHeader:tabHeader navBottomActionView:navBottomAction];
}
- (void)refershAction {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark ------UITableViewDelegate,UITableViewDataSource-------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
//    NSLog(@"===%f",contentOffsetY);
    [[SlideManger shareSlideManger] tableViewSlide:contentOffsetY];
}
//停止滚动后调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    [[SlideManger shareSlideManger] tabViewEndSlide:contentOffsetY scrollView:scrollView];
}
//用户松手后的调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        // 用户松手后不会再滑动了
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        [[SlideManger shareSlideManger] tabViewEndSlide:contentOffsetY scrollView:scrollView];
    }
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
