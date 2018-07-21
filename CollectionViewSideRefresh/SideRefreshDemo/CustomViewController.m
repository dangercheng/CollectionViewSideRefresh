//
//  CustomViewController.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/13.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "CustomViewController.h"
#import "UICollectionView+SideRefresh.h"
#import "MyCollectionViewCell.h"

@interface CustomViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat itemCount;
@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"自定义";
    self.itemCount = 3;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300.0);
    flowLayout.minimumLineSpacing = 0.0;
    
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    
    [self setupRefreshHeaderFoorer];
}

- (void)setupRefreshHeaderFoorer {
    __weak typeof(self) weakSelf = self;
    SideRefreshHeader *refreshHeader = [SideRefreshHeader refreshWithLoadAction:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong __typeof(self) strongSelf = weakSelf;
            strongSelf.itemCount = 3;
            [strongSelf.collectionView.sideRefreshHeader endLoading];
            [strongSelf.collectionView reloadData];
        });
    }];
    NSMutableArray *loadingImages = [NSMutableArray array];
    for(int i = 1; i <= 9; i++) {
        UIImage *loadingImg = [UIImage imageNamed:[NSString stringWithFormat:@"loading_0%d", i]];
        if(loadingImg) {
            [loadingImages addObject:loadingImg];
        }
    }
    refreshHeader.loadingImages = loadingImages;//自定义图片动画
    //自定义提示文案
    refreshHeader.normalMessage = @"再拉我试试!";
    refreshHeader.pullingMessage = @"松开，松开";
    refreshHeader.loadingMessage = @"奔跑...";
    self.collectionView.sideRefreshHeader = refreshHeader;
    
    SideRefreshFooter *refreshFooter = [SideRefreshFooter refreshWithLoadAction:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong __typeof(self) strongSelf = weakSelf;
            strongSelf.itemCount += 3;
            [strongSelf.collectionView.sideRefreshFooter endLoading];
            [strongSelf.collectionView reloadData];
        });
    }];
    refreshFooter.loadingImages = [loadingImages mutableCopy];//自定义图片动画
    //自定义提示文案
    refreshFooter.normalMessage = @"再拉我试试!";
    refreshFooter.pullingMessage = @"松开，松开";
    refreshFooter.loadingMessage = @"奔跑...";
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
    NSLog(@"CustomViewController delloc");
}

@end
