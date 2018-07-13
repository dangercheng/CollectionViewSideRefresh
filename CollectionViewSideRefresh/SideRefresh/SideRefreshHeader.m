//
//  SideRefreshHeader.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "SideRefreshHeader.h"

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
    [UIView animateWithDuration:0.3 animations:^{
        [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    } completion:nil];
}

- (void)updateContentOffsetToLoading {
    CGFloat targetX = (SideRefreshWidth + self.collectionView.contentInset.left) * -1;
    [UIView animateWithDuration:0.3 animations:^{
        [self.collectionView setContentOffset:CGPointMake(targetX, 0) animated:YES];
    }];
}

- (BOOL)pullToReadyRefresh {
    CGFloat offsetX = self.collectionView.contentOffset.x * -1;
    offsetX = offsetX - self.collectionView.contentInset.left;
    return offsetX > SideRefreshWidth;
}

- (void)resetRefreshFrame {
    CGFloat frameX = (SideRefreshWidth + self.collectionView.contentInset.left) * - 1;
    self.frame = CGRectMake(frameX, 0, SideRefreshWidth, self.collectionView.frame.size.height);
    self.hidden = NO;
}

@end
