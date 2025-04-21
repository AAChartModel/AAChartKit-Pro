#import <UIKit/UIKit.h>
#import "AAChartKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartExampleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readonly) AAChartView *aaChartView; // 假设已有图表视图属性

// 添加方法声明
- (void)configureAppearanceForNightMode:(BOOL)isNightMode;

- (void)setChartOptions:(AAOptions *)chartOptions completion:(void (^)(AAChartView *aaChartView))completion;

@end

NS_ASSUME_NONNULL_END
