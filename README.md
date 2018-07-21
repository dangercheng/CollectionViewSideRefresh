# 一款简单好用的UICollectionView横向滚动刷新控件

[源码地址:(GitHub)](https://github.com/dangercheng/CollectionViewSideRefresh)

# 实现功能：

- **接入简单，不侵入代码**
- **右拉刷新，左拉加载更多**
- **自定义提示文案和加载动画**
- **方便隐藏和显示加载提示文本和动画**
- **支持 ‘没有更多数据’ 提示**

# 接入方式
1. 下载源码，将文件夹 "SideRefresh"添加进工程
2. 引入头文件 #import "UICollectionView+SideRefresh.h"
3. 创建SideRefreshHeader和SideRefreshFooter并添加给UICollectionView即可

## 默认刷新样式
```
SideRefreshHeader *refreshHeader = [SideRefreshHeader refreshWithLoadAction:^{
    //执行刷新
}];
self.collectionView.sideRefreshHeader = refreshHeader;

SideRefreshFooter *refreshFooter = [SideRefreshFooter refreshWithLoadAction:^{
    //执行加载更多
}];
self.collectionView.sideRefreshFooter = refreshFooter;
```
![默认样式](https://sfault-image.b0.upaiyun.com/304/614/3046140025-5b4876a3a0bb3_articlex)

## 自定义刷新提示和图片动画
```
SideRefreshHeader *refreshHeader = [SideRefreshHeader refreshWithLoadAction:^{
    //执行刷新
}];
NSMutableArray *loadingImages = [NSMutableArray array];
for(int i = 1; i <= 9; i++) {
    UIImage *loadingImg = [UIImage imageNamed:[NSString stringWithFormat:@"loading_0%d", i]];
    if(loadingImg) {
        [loadingImages addObject:loadingImg];
    }
}
refreshHeader.loadingImages = loadingImages;//自定义图片动画
//自定义提示文案
refreshHeader.normalMessage = @"再拉我试试!";
refreshHeader.pullingMessage = @"松开，松开";
refreshHeader.loadingMessage = @"奔跑...";
self.collectionView.sideRefreshHeader = refreshHeader;

SideRefreshFooter *refreshFooter = [SideRefreshFooter refreshWithLoadAction:^{
    //执行加载更多
}];
self.collectionView.sideRefreshFooter = refreshFooter;
```
![自定义](https://sfault-image.b0.upaiyun.com/376/316/3763166665-5b4876ff3f97f_articlex)
## 隐藏刷新提示或动画
```
SideRefreshHeader *refreshHeader = [SideRefreshHeader refreshWithLoadAction:^{
    //执行刷新
}];
refreshHeader.hideMessage = YES;//隐藏提示
self.collectionView.sideRefreshHeader = refreshHeader;

SideRefreshFooter *refreshFooter = [SideRefreshFooter refreshWithLoadAction:^{
    //执行加载更多
}];
refreshFooter.hideIndicator = YES;//隐藏加载动画
self.collectionView.sideRefreshFooter = refreshFooter;
```
![隐藏提示或动画](https://sfault-image.b0.upaiyun.com/365/863/3658631273-5b487722e5f30_articlex)
## ‘没有更多数据’ 提示
显示默认提示
```
[self.collectionView showEmptyFooter]
```
显示自定义提示
```
[self.collectionView showEmptyFooterWithMessage:@"不要看了，没有了。"];
```
![没有更多数据](https://sfault-image.b0.upaiyun.com/213/366/2133667725-5b52f8f714335_articlex)

**PS:隐藏需要手动调用**
```
[self.collectionView hideEmptyFooter];
```

# 实现方式

- **通过Runtime为UICollectionView添加SideRefreshHeader和SideRefreshFooter属性**
- **观察UICollectionView的contentOffset实现拖动相关逻辑**
- **观察UICollectionView的contentSize来重置刷新视图**
- 更多细节参见源码Demo

如果觉得好用欢迎Star [github](https://github.com/dangercheng/CollectionViewSideRefresh), 使用问题请Issue。



