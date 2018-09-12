//
//  UICollectionView+SideExtension.h
//  CollectionViewSideRefresh
//
//  Created by dangercheng on 2018/9/12.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (SideExtension)
@property (nonatomic, assign, readonly) UIEdgeInsets side_inset;
@property (nonatomic, assign) CGFloat side_insetL;
@property (nonatomic, assign) CGFloat side_insetR;
@end
