#import <UIKit/UIKit.h>

@class AAChartView;
@class AAOptions;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChartCompletionBlock)(AAChartView *aaChartView);

@interface ChartExampleCell : UITableViewCell

@property (nonatomic, strong, readonly) AAChartView *aaChartView;

/// 设置图表选项
/// @param options AAOptions 对象
/// @param completion 完成回调
- (void)setChartOptions:(AAOptions *)options completion:(nullable ChartCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
