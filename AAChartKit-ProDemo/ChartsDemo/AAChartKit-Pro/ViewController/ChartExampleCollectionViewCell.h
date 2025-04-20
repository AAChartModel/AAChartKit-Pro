#import <UIKit/UIKit.h>

@class AAChartView;
@class AAOptions;

NS_ASSUME_NONNULL_BEGIN

// 重用 TableViewCell 的 Block 定义
typedef void(^ChartCompletionBlock)(AAChartView *aaChartView);

@interface ChartExampleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readonly) AAChartView *aaChartView;

/// 设置图表选项
/// @param options AAOptions 对象
/// @param completion 完成回调
- (void)setChartOptions:(AAOptions *)options completion:(nullable ChartCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
