//
//  SideRefresh.h
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import <UIKit/UIKit.h>

//刷新条宽度
static const CGFloat SideRefreshWidth = 50.0;

/**
 刷新状态

 - SideRefreshStatusNormal: 常规状态
 - SideRefreshStatusPulling: 即将刷新
 - SideRefreshStatusLoading: 刷新中
 */
typedef NS_ENUM(NSUInteger, SideRefreshStatus) {
    SideRefreshStatusNormal,
    SideRefreshStatusPulling,
    SideRefreshStatusLoading,
};

/**
 刷新回调
 */
typedef void(^loadAction)(void);

@interface SideRefresh : UIView

/**
 依附的collectionView
 */
@property (nonatomic, weak) UICollectionView *collectionView;

/**
 刷新状态
 */
@property (nonatomic, assign) SideRefreshStatus refreshStatus;

/**
 旧的刷新状态
 */
@property (nonatomic, assign) SideRefreshStatus oldRefreshStatus;

/**
 拉动提示
 */
@property (nonatomic, copy) NSString *normalMessage;

/**
 即将刷新的提示
 */
@property (nonatomic, copy) NSString *pullingMessage;

/**
 加载中提示
 */
@property (nonatomic, copy) NSString *loadingMessage;

/**
 自定义的加载动画图片组
 */
@property (nonatomic, strong) NSArray<UIImage *> *loadingImages;

/**
 提示文本
 */
@property (nonatomic, strong) UILabel *messageLabel;

/**
 自定义的加载图片显示视图
 */
@property (nonatomic, strong) UIImageView *loadingImageView;

/**
 默认菊花
 */
@property (nonatomic, strong) UIActivityIndicatorView *defaultIndicator;

/**
 原始的ContentInset
 */
@property (nonatomic, assign) UIEdgeInsets originalContentInset;

/**
 是否支持page
 */
@property (nonatomic, assign) BOOL collectionViewPageEnabel;

/**
 隐藏文本
 */
@property (nonatomic, assign) BOOL hideMessage;

/**
 隐藏加载图片
 */
@property (nonatomic, assign) BOOL hideIndicator;

/**
 刷新执行回调
 */
@property (nonatomic, copy) loadAction loadActionBlock;

/**
 初始化

 @param loadActionBlock 刷新回调
 @return 实例
 */
+ (instancetype)refreshWithLoadAction:(loadAction)loadActionBlock;

/**
 开始刷新
 */
- (void)beginLoading;

/**
 结束刷新
 */
- (void)endLoading;

/**
 执行刷新回调
 */
- (void)startLoadingAction;

/**
 设置常规状态ContentOffset
 */
- (void)updateContentOffsetToNormal;

/**
 设置刷新状态ContentOffset
 */
- (void)updateContentOffsetToLoading;

/**
 是否到达可刷新状态

 @return YES 是，NO否
 */
- (BOOL)pullToReadyRefresh;

/**
 重置刷新视图位置
 */
- (void)resetRefreshFrame;

/**
 保持刷新状态的offset
 */
- (void)keepRefreshingOffset;

@end
