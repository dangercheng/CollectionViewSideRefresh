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
        [strongSelf.collectionView setSide_insetR:strongSelf.originalContentInset.right];
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
    CGFloat showWidth = self.collectionView.frame.size.width - self.originalContentInset.right;
    CGFloat spaceWidth = showWidth - self.collectionView.contentSize.width;
    [UIView animateWithDuration:0.3 animations:^{
        if(spaceWidth > 0) {//应当考虑content显示不完整个CollectionView的情况
            [self.collectionView setSide_insetR:(targetRight + spaceWidth)];
        } else {
            [self.collectionView setSide_insetR:targetRight];
        }
    }];
}

- (BOOL)pullToReadyRefresh {
    CGFloat offsetX = self.collectionView.contentOffset.x;
    CGFloat mostRightOffset = self.collectionView.contentSize.width - self.collectionView.frame.size.width;
    if(mostRightOffset < 0) {//考虑Content显示不完整个CollectionView的情况
        mostRightOffset = 0;
    }
    CGFloat targetX = SideRefreshWidth + mostRightOffset;
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
