//
//  SideRefresh.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "SideRefresh.h"
#import "UICollectionView+SideExtension.h"
#import "UICollectionView+SideRefresh.h"

@implementation SideRefresh

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self removeObserver];
    if ([newSuperview isKindOfClass:[UICollectionView class]]) {
        self.collectionView = (UICollectionView *)newSuperview;
        self.collectionView.alwaysBounceHorizontal = YES;
        self.originalContentInset = self.collectionView.side_inset;
        self.collectionViewPageEnabel = self.collectionView.pagingEnabled;
        [self addObserver];
    }
}

- (void)startLoadingAction {
    if(self.loadActionBlock && self.superview) {
        self.loadActionBlock();
    }
}

- (void)beginLoading {
    self.refreshStatus = SideRefreshStatusLoading;
}

- (void)endLoading {
    self.refreshStatus = SideRefreshStatusNormal;
    [self.collectionView hideEmptyFooter];
}

- (void)removeObserver {
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    [self.superview removeObserver:self forKeyPath:@"contentSize"];
}

- (void)addObserver {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:options context:nil];
}

#pragma mark - ContentOffset Observer 
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if(![self.superview isEqual:self.collectionView]) {
        return;
    }
    if([keyPath isEqualToString:@"contentOffset"]) {
        [self handleContentOffsetChanged];
    }
    else if([keyPath isEqualToString:@"contentSize"]) {
        [self handleContentSizeChanged];
    }
}

- (void)handleContentOffsetChanged {
    if(self.collectionView.dragging) {
        if([self pullToReadyRefresh]) {
            if(self.refreshStatus == SideRefreshStatusNormal) {
                self.refreshStatus = SideRefreshStatusPulling;
            }
        } else {
            if(self.refreshStatus == SideRefreshStatusPulling) {
                self.refreshStatus = SideRefreshStatusNormal;
            } else if(self.refreshStatus == SideRefreshStatusLoading) {
//                self.collectionView.pagingEnabled = NO;
                self.refreshStatus = SideRefreshStatusNormal;
            }
        }
    } else {
        if(self.refreshStatus == SideRefreshStatusPulling) {
            self.refreshStatus = SideRefreshStatusLoading;
        }
        else if(self.refreshStatus == SideRefreshStatusLoading) {
            [self keepRefreshingOffset];
        }
    }
    [self updateRefreshFrame];
}

- (void)handleContentSizeChanged {
    [self resetRefreshFrame];
}

- (void)updateRefreshFrame {
    if(!self.hidden) {
        return;
    }
    [self resetRefreshFrame];
    [self updateRefreshContentFrame];
}

- (void)updateRefreshContentFrame {
    CGFloat indicatorWidth = 20.0;
    self.backgroundColor = self.collectionView.backgroundColor;
    
    CGFloat imgFitY = (self.frame.size.height / 2) - (indicatorWidth / 2);
    if(self.hideMessage) {
        self.messageLabel.hidden = YES;
    } else {
        self.messageLabel.frame = CGRectMake(15, 0, 15, self.collectionView.frame.size.height);
        NSString *maxLengthMessage = self.normalMessage;
        if(self.pullingMessage.length > maxLengthMessage.length) {
            maxLengthMessage = self.pullingMessage;
        }
        if(self.loadingMessage.length > maxLengthMessage.length) {
            maxLengthMessage = self.loadingMessage;
        }
        CGSize messageSize = [maxLengthMessage boundingRectWithSize:CGSizeMake(15, CGFLOAT_MAX)
                                                            options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName:self.messageLabel.font}
                                                            context:nil].size;
        imgFitY = (self.collectionView.frame.size.height - messageSize.height)/2 - indicatorWidth - 20;
    }
    
    if(self.hideIndicator) {
        self.loadingImageView.hidden = YES;
        [self.defaultIndicator removeFromSuperview];
    } else {
        self.loadingImageView.hidden = NO;
        if([self.loadingImages count] > 0) {
            [self.defaultIndicator removeFromSuperview];
            self.loadingImageView.frame = CGRectMake(12, imgFitY, indicatorWidth, indicatorWidth);
            self.loadingImageView.animationImages = self.loadingImages;
            self.loadingImageView.animationDuration = 0.5;
            self.loadingImageView.animationRepeatCount = NSIntegerMax;
            self.loadingImageView.image = self.loadingImages.firstObject;
        } else {
            self.loadingImageView.hidden = YES;
            self.defaultIndicator.frame = CGRectMake(12, imgFitY, indicatorWidth, indicatorWidth);
            self.defaultIndicator.hidesWhenStopped = NO;
        }
    }
}


#pragma mark - Child Recognize
+ (instancetype)refreshWithLoadAction:(loadAction)loadActionBlock {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)updateContentOffsetToNormal {
    [self doesNotRecognizeSelector:_cmd];
}


- (void)updateContentOffsetToLoading {
    [self doesNotRecognizeSelector:_cmd];
}

- (BOOL)pullToReadyRefresh {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

- (void)resetRefreshFrame {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)keepRefreshingOffset {
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark - setter & getter
- (void)setRefreshStatus:(SideRefreshStatus)refreshStatus {
    _refreshStatus = refreshStatus;
    switch (refreshStatus) {
        case SideRefreshStatusNormal:
            self.messageLabel.text = self.normalMessage;
            if(self.oldRefreshStatus == SideRefreshStatusLoading) {
                [self updateContentOffsetToNormal];
                [self.loadingImageView stopAnimating];
                [self.defaultIndicator stopAnimating];
            }
            break;
        case SideRefreshStatusPulling:
            self.messageLabel.text = self.pullingMessage;
            break;
        case SideRefreshStatusLoading:
            self.messageLabel.text = self.loadingMessage;
            [self updateContentOffsetToLoading];
            [self startLoadingAction];
            [self.loadingImageView startAnimating];
            [self.defaultIndicator startAnimating];
            break;
    }
    self.oldRefreshStatus = refreshStatus;
}

- (UIImageView *)loadingImageView {
    if(!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] init];
        [self addSubview:_loadingImageView];
    }
    return _loadingImageView;
}

- (UILabel *)messageLabel {
    if(!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textColor =  [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.text = self.normalMessage;
        [self addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (UIActivityIndicatorView *)defaultIndicator {
    if(!_defaultIndicator) {
        _defaultIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_defaultIndicator];
    }
    return _defaultIndicator;
}

@end
