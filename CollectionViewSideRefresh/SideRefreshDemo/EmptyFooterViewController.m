//
//  EmptyFooterViewController.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/21.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "EmptyFooterViewController.h"
#import "UICollectionView+SideRefresh.h"
#import "MyCollectionViewCell.h"

@interface EmptyFooterViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, assign) CGFloat itemCount;
@end

@implementation EmptyFooterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"没有更多数据-提示";
    self.itemCount = 0;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300.0);
    flowLayout.minimumLineSpacing = 0.0;
    
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    
    [self setupRefreshHeaderFoorer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.collectionView.sideRefreshHeader beginLoading];
}

- (void)setupRefreshHeaderFoorer {
    __weak typeof(self) weakSelf = self;
    SideRefreshHeader *refreshHeader = [SideRefreshHeader refreshWithLoadAction:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong __typeof(self) strongSelf = weakSelf;
            strongSelf.itemCount = 3;
            [strongSelf.collectionView.sideRefreshHeader endLoading];
            [strongSelf.collectionView reloadData];
        });
    }];
    refreshHeader.hideMessage = YES;//隐藏提示
    NSMutableArray *loadingImages = [NSMutableArray array];
    for(int i = 1; i <= 9; i++) {
        UIImage *loadingImg = [UIImage imageNamed:[NSString stringWithFormat:@"loading_0%d", i]];
        if(loadingImg) {
            [loadingImages addObject:loadingImg];
        }
    }
    refreshHeader.loadingImages = loadingImages;
    self.collectionView.sideRefreshHeader = refreshHeader;
    
    SideRefreshFooter *refreshFooter = [SideRefreshFooter refreshWithLoadAction:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong __typeof(self) strongSelf = weakSelf;
            strongSelf.itemCount += 3;
            [strongSelf.collectionView.sideRefreshFooter endLoading];
            [strongSelf.collectionView reloadData];
            if(strongSelf.itemCount == 6) {
                [strongSelf.collectionView showEmptyFooter];
//                [strongSelf.collectionView showEmptyFooterWithMessage:@"不要看了，没有了。"];
            }
        });
    }];
    refreshFooter.hideIndicator = YES;//隐藏加载动画
    refreshFooter.loadingImages = [loadingImages mutableCopy];
    self.collectionView.sideRefreshFooter = refreshFooter;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *myCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    myCollectionCell.titleLabel.text = [NSString stringWithFormat:@"NO.%ld", (indexPath.row + 1)];
    return myCollectionCell;
}

- (void)dealloc {
    NSLog(@"EmptyFooterViewController delloc");
}


@end
