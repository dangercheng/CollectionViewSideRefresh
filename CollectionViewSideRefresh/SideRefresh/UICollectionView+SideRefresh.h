//
//  UICollectionView+SideRefresh.h
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideRefreshHeader.h"
#import "SideRefreshFooter.h"
#import "SideRefreshEmptyFooter.h"

@interface UICollectionView (SideRefresh)

/**
 刷新头
 */
@property (nonatomic, strong) SideRefreshFooter *sideRefreshFooter;

/**
 刷新脚
 */
@property (nonatomic, strong) SideRefreshHeader *sideRefreshHeader;

/**
 是否已显示空刷新脚
 */
@property (nonatomic, assign, readonly) BOOL isShowEmptyFooter;

/**
 显示默认空刷新脚，默认提示："没有更多数据了"
 */
- (void)showEmptyFooter;

/**
 显示自定义提示内容的空刷新脚

 @param message 提示内容
 */
- (void)showEmptyFooterWithMessage:(NSString *)message;

/**
 隐藏空刷新脚
 */
- (void)hideEmptyFooter;

@end
