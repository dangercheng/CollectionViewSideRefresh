//
//  UICollectionView+SideRefresh.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "UICollectionView+SideRefresh.h"
#import <objc/runtime.h>

@interface UICollectionView ()
@property (nonatomic, strong) SideRefreshEmptyFooter *sideRefreshEmptyFooter;
@end

@implementation UICollectionView (SideRefresh)

static const NSString *SideRefreshHeaderKey = @"SideRefreshHeaderKey";
static const NSString *SideRefreshFooterKey = @"SideRefreshFooterKey";
static const NSString *SideRefreshEmptyFooterKey = @"SideRefreshEmptyFooterKey";
static const NSString *SideRefreshIsShowEmptyFooterKey = @"SideRefreshIsShowEmptyFooterKey";

- (void)setSideRefreshFooter:(SideRefreshFooter *)sideRefreshFooter {
    if(self.sideRefreshFooter != sideRefreshFooter) {
        [self.sideRefreshFooter removeFromSuperview];
        [self willChangeValueForKey:@"sideRefreshFooter"];
        objc_setAssociatedObject(self, &SideRefreshFooterKey, sideRefreshFooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"sideRefreshFooter"];
        [self addSubview:sideRefreshFooter];
    }
    if(self.sideRefreshEmptyFooter) {
        [self.sideRefreshEmptyFooter removeFromSuperview];
    }
    self.isShowEmptyFooter = NO;
}

- (SideRefreshFooter *)sideRefreshFooter {
   return objc_getAssociatedObject(self, &SideRefreshFooterKey);
}

- (void)setSideRefreshHeader:(SideRefreshHeader *)sideRefreshHeader {
    if(self.sideRefreshHeader != sideRefreshHeader) {
        [self.sideRefreshHeader removeFromSuperview];
        [self willChangeValueForKey:@"sideRefreshHeader"];
        objc_setAssociatedObject(self, &SideRefreshHeaderKey, sideRefreshHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"sideRefreshHeader"];
        [self insertSubview:sideRefreshHeader atIndex:0];
    }
}

- (SideRefreshHeader *)sideRefreshHeader {
    return objc_getAssociatedObject(self, &SideRefreshHeaderKey);
}

- (void)setSideRefreshEmptyFooter:(SideRefreshEmptyFooter *)sideRefreshEmptyFooter {
    if(self.sideRefreshEmptyFooter != sideRefreshEmptyFooter) {
        [self.sideRefreshEmptyFooter removeFromSuperview];
        [self willChangeValueForKey:@"sideRefreshEmptyFooter"];
        objc_setAssociatedObject(self, &SideRefreshEmptyFooterKey, sideRefreshEmptyFooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"sideRefreshEmptyFooter"];
        [self addSubview:sideRefreshEmptyFooter];
    }
}

- (SideRefreshEmptyFooter *)sideRefreshEmptyFooter {
    return objc_getAssociatedObject(self, &SideRefreshEmptyFooterKey);
}

- (void)setIsShowEmptyFooter:(BOOL)isShowEmptyFooter {
    if(self.isShowEmptyFooter != isShowEmptyFooter) {
        objc_setAssociatedObject(self, &SideRefreshIsShowEmptyFooterKey, [NSNumber numberWithBool:isShowEmptyFooter], OBJC_ASSOCIATION_ASSIGN);
    }
}

- (BOOL)isShowEmptyFooter {
    return [objc_getAssociatedObject(self, &SideRefreshIsShowEmptyFooterKey) boolValue];
}

- (void)showEmptyFooter {
    [self showEmptyFooterWithMessage:nil];
}

- (void)showEmptyFooterWithMessage:(NSString *)message {
    if(!message) {
        message = @"没有更多数据了";
    }
    [self.sideRefreshFooter removeFromSuperview];
    CGFloat frameX = self.contentSize.width + self.contentInset.right;
    self.sideRefreshEmptyFooter = [[SideRefreshEmptyFooter alloc] initWithFrame:CGRectMake(frameX, 0, SideRefreshEmptyFooterWidth, self.frame.size.height)];
    self.sideRefreshEmptyFooter.message = message;
    self.isShowEmptyFooter = YES;
}

- (void)hideEmptyFooter {
    [self.sideRefreshEmptyFooter removeFromSuperview];
    self.isShowEmptyFooter = NO;
    if(self.sideRefreshFooter) {
        [self addSubview:self.sideRefreshFooter];
    }
}

@end
