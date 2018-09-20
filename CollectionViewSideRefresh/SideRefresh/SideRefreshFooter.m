//
//  SideRefreshFooter.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "SideRefreshFooter.h"
#import "UICollectionView+SideRefresh.h"
#import "UICollectionView+SideExtension.h"

@implementation SideRefreshFooter

+ (instancetype)refreshWithLoadAction:(loadAction)loadActionBlock {
    SideRefreshFooter *freshFooter = [[SideRefreshFooter alloc] init];
    freshFooter.loadActionBlock = loadActionBlock;
    return freshFooter;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        self.normalMessage = @"左拉加载更多...";
        self.pullingMessage = @"松开加载...";
        self.loadingMessage = @"加载中...";
        self.hidden = YES;
    }
    return self;
}

- (void)updateContentOffsetToNormal {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong __typeof(self) strongSelf = weakSelf;
        if(!strongSelf)return;
        if(strongSelf.collectionView.isShowEmptyFooter) {
           [strongSelf.collectionView setSide_insetR:strongSelf.originalContentInset.right];
        }
    });
    if(self.collectionViewPageEnabel) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.collectionView setSide_insetR:self.originalContentInset.right];
        }];
    }
}

- (void)updateContentOffsetToLoading {
    if(self.collectionView.isShowEmptyFooter) {
        [self resetRefreshFrame];
        return;
    }
    CGFloat targetRight = self.originalContentInset.right + SideRefreshWidth;
    [UIView animateWithDuration:0.3 animations:^{
        [self.collectionView setSide_insetR:targetRight];
    }];
}

- (BOOL)pullToReadyRefresh {
    CGFloat offsetX = self.collectionView.contentOffset.x;
    CGFloat targetX = SideRefreshWidth + self.collectionView.contentSize.width - self.collectionView.frame.size.width;
    return offsetX > targetX;
}

- (void)resetRefreshFrame {
    CGFloat frameX = self.collectionView.contentSize.width + self.originalContentInset.right;
    self.frame = CGRectMake(frameX, 0, SideRefreshWidth, self.collectionView.frame.size.height);
    if(!(self.collectionView.contentSize.width > self.collectionView.frame.size.width)) {
        self.frame = CGRectMake(self.collectionView.frame.size.width, 0, SideRefreshWidth, self.collectionView.frame.size.height);
    }
    self.hidden = NO;
}

- (void)keepRefreshingOffset {
    if(!self.collectionView.pagingEnabled) {
        return;
    }
    CGFloat targetX = SideRefreshWidth + self.originalContentInset.right + self.collectionView.contentSize.width - self.collectionView.frame.size.width;
    [self.collectionView setContentOffset:CGPointMake(targetX, self.collectionView.contentOffset.y) animated:NO];
}

@end
