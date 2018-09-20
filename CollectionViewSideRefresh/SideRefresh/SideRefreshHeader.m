//
//  SideRefreshHeader.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "SideRefreshHeader.h"
#import "UICollectionView+SideExtension.h"

@implementation SideRefreshHeader

+ (instancetype)refreshWithLoadAction:(loadAction)loadActionBlock {
    SideRefreshHeader *freshHeader = [[SideRefreshHeader alloc] init];
    freshHeader.loadActionBlock = loadActionBlock;
    return freshHeader;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        self.normalMessage = @"右拉刷新...";
        self.pullingMessage = @"松开刷新...";
        self.loadingMessage = @"刷新中...";
        self.hidden = YES;
    }
    return self;
}

- (void)updateContentOffsetToNormal {
    self.collectionView.pagingEnabled = self.collectionViewPageEnabel;
    [UIView animateWithDuration:0.3 animations:^{
        [self.collectionView setContentInset:self.originalContentInset];
    }];
}

- (void)updateContentOffsetToLoading {
    self.collectionView.pagingEnabled = NO;
    CGFloat targetLeft = (SideRefreshWidth + self.originalContentInset.left);
    [UIView animateWithDuration:0.3 animations:^{
        [self.collectionView setSide_insetL:targetLeft];
    }];
}

- (BOOL)pullToReadyRefresh {
    CGFloat offsetX = self.collectionView.contentOffset.x * -1;
    offsetX = offsetX - self.collectionView.contentInset.left;
    return offsetX > SideRefreshWidth;
}

- (void)resetRefreshFrame {
    CGFloat frameX = (SideRefreshWidth + self.originalContentInset.left) * - 1;
    self.frame = CGRectMake(frameX, 0, SideRefreshWidth, self.collectionView.frame.size.height);
    self.hidden = NO;
}

- (void)keepRefreshingOffset {
    if(!self.collectionViewPageEnabel) {
        return;
    }
    CGFloat targetX = (SideRefreshWidth + self.originalContentInset.left) * - 1;
    [self.collectionView setContentOffset:CGPointMake(targetX, self.collectionView.contentOffset.y) animated:NO];
}

@end
