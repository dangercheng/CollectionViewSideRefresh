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

@interface UICollectionView (SideRefresh)

@property (nonatomic, strong) SideRefreshFooter *sideRefreshFooter;

@property (nonatomic, strong) SideRefreshHeader *sideRefreshHeader;

@end
