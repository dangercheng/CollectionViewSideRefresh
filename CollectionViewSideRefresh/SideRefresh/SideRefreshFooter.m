//
//  SideRefreshFooter.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "SideRefreshFooter.h"
#import "UICollectionView+SideRefresh.h"

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
    self.hidden = YES;
    self.frame = CGRectZero;
}

- (void)updateContentOffsetToLoading {
    if(self.collectionView.isShowEmptyFooter) {
        [self resetRefreshFrame];
        return;
    }
    CGFloat targetX = self.collectionView.contentSize.width - self.collectionView.frame.size.width + self.collectionView.contentInset.right + SideRefreshWidth;
    [UIView animateWithDuration:0.3 animations:^{
        [self.collectionView setContentOffset:CGPointMake(targetX, 0) animated:YES];
    }];
}

- (BOOL)pullToReadyRefresh {
    CGFloat offsetX = self.collectionView.contentOffset.x;
    CGFloat targetX = SideRefreshWidth + self.collectionView.contentSize.width - self.collectionView.frame.size.width;
    return offsetX > targetX;
}

- (void)resetRefreshFrame {
    CGFloat frameX = self.collectionView.contentSize.width + self.collectionView.contentInset.right;
    self.frame = CGRectMake(frameX, 0, SideRefreshWidth, self.collectionView.frame.size.height);
    if(self.collectionView.contentSize.width > self.collectionView.frame.size.width) {
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
}

@end
