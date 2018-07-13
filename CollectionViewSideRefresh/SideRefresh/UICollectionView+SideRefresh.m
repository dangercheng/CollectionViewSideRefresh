//
//  UICollectionView+SideRefresh.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "UICollectionView+SideRefresh.h"
#import <objc/runtime.h>

@implementation UICollectionView (SideRefresh)

static const NSString *SideRefreshHeaderKey = @"SideRefreshHeaderKey";
static const NSString *SideRefreshFooterKey = @"SideRefreshFooterKey";

- (void)setSideRefreshFooter:(SideRefreshFooter *)sideRefreshFooter {
    if(self.sideRefreshFooter != sideRefreshFooter) {
        [self.sideRefreshFooter removeFromSuperview];
        [self willChangeValueForKey:@"sideRefreshFooter"];
        objc_setAssociatedObject(self, &SideRefreshFooterKey, sideRefreshFooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"sideRefreshFooter"];
        [self addSubview:sideRefreshFooter];
    }
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

@end
