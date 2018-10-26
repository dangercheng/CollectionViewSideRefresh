//
//  SideRefreshEmptyFooter.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/20.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "SideRefreshEmptyFooter.h"

@interface SideRefreshEmptyFooter()

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation SideRefreshEmptyFooter

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setupMessageLabel];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self.superview removeObserver:self forKeyPath:@"contentSize"];
    if([newSuperview isKindOfClass:[UICollectionView class]]) {
        self.collectionView = (UICollectionView *)newSuperview;
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [self.collectionView addObserver:self forKeyPath:@"contentSize" options:options context:nil];
        self.backgroundColor = self.collectionView.backgroundColor;
    }
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.messageLabel.text = message;
}

- (void)setupMessageLabel {
    CGFloat labelWidth = 15;
    CGFloat labelX = (self.frame.size.width - labelWidth) * 0.5;
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 0, labelWidth, self.frame.size.height)];
    _messageLabel.numberOfLines = 0;
    _messageLabel.font = [UIFont systemFontOfSize:12];
    _messageLabel.textColor =  [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_messageLabel];
}

#pragma mark - ContentOffset Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentSize"]) {
        CGFloat frameX = self.collectionView.contentSize.width + self.collectionView.contentInset.right;
        self.frame = CGRectMake(frameX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
}
@end
