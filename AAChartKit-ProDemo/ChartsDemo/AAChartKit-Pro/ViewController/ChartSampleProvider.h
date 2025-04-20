#import <Foundation/Foundation.h>

// 假设 AAOptions 和其他 Composer 类在 Objective-C 中可用且已导入
#import "AAOptions.h"
#import "AARelationshipChartComposer.h"
#import "AABubbleChartComposer.h"
#import "AAColumnVariantChartComposer.h"
#import "AAHeatmapChartComposer.h"
#import "AATilemapChartComposer.h"
#import "AATreemapChartComposer.h"
#import "AAHeatmapChartComposer.h"
#import "AATreegraphChartComposer.h"

// 假设 ChartProVC 的方法在 Objective-C 中有等效实现，可能需要一个包装类或直接调用
// #import "ChartProVCWrapper.h" // 示例导入

NS_ASSUME_NONNULL_BEGIN

@interface ChartSampleProvider : NSObject

+ (NSArray<AAOptions *> *)allProTypeSamples;

@end

NS_ASSUME_NONNULL_END
