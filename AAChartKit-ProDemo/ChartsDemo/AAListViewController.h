//
//  AAListViewController.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2025/10/23.
//  Copyright © 2025 An An. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AAListViewController;

#pragma mark - AAListViewDataSource

@protocol AAListViewDataSource <NSObject>

@required
/// 返回分组数量
- (NSInteger)numberOfSectionsInListView:(AAListViewController *)listViewController;

/// 返回每个分组的行数
- (NSInteger)listView:(AAListViewController *)listViewController numberOfRowsInSection:(NSInteger)section;

/// 返回分组标题数组
- (NSArray<NSString *> *)sectionTitlesForListView:(AAListViewController *)listViewController;

/// 返回每个分组的数据数组
- (NSArray<NSArray<NSString *> *> *)dataArrayForListView:(AAListViewController *)listViewController;

@end

#pragma mark - AAListViewDelegate

@protocol AAListViewDelegate <NSObject>

@required
/// 点击某一行的回调
- (void)listView:(AAListViewController *)listViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
/// 自定义分组标题（可选）
- (NSString *)listView:(AAListViewController *)listViewController titleForHeaderInSection:(NSInteger)section;

@end

#pragma mark - AAListViewController

@interface AAListViewController : UIViewController

@property (nonatomic, weak) id<AAListViewDataSource> dataSource;
@property (nonatomic, weak) id<AAListViewDelegate> delegate;

/// 只读的主列表视图，方便外部做额外配置（如注册 cell 等）
@property (nonatomic, strong, readonly) UITableView *tableView;

/// 是否启用手动主题切换按钮（默认YES）
@property (nonatomic, assign) BOOL enableThemeToggle;

/// 主标题文本（可选，用于自定义header）
@property (nonatomic, copy, nullable) NSString *headerTitle;

/// 副标题文本（可选，用于自定义header）
@property (nonatomic, copy, nullable) NSString *headerSubtitle;

/// 是否显示表头卡片（默认YES）
@property (nonatomic, assign) BOOL showHeaderCard;

/// 刷新列表数据
- (void)reloadData;

/// 手动应用主题
- (void)applyTheme;

@end

NS_ASSUME_NONNULL_END
