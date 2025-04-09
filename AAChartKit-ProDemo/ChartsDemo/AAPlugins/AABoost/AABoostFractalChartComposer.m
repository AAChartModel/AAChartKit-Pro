//
//  AABoostFractalChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2025/4/9.
//  Copyright © 2025 An An. All rights reserved.
//

#import "AABoostFractalChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptions+boost.h"

@implementation AABoostFractalChartComposer

/**
 
 function generateSierpinskiData() {
     const data = [];
     const canvasSize = 800; // 匹配容器尺寸

     // --- Carpet Parameters ---
     const maxDepth = 6; // 控制递归深度和细节 (6-7 通常足够)
     // const pointDensity = 1; // 1: 中心点, 2: 角点, >2: 更多点填充
     // --- End Carpet Parameters ---

     // --- Vibrant Color Function (保持不变或微调) ---
     function getColor(depth, maxDepth, x, y, size) {
         // 使用深度 t (0 到 1) 来驱动颜色变化
         const t = depth / maxDepth;

         // 霓虹/宇宙风格
         const freq1 = 0.25, phase1 = 1.5; // 调整频率相位获得不同效果
         const freq2 = 0.30, phase2 = 2.5;
         const freq3 = 0.35, phase3 = 0.5;

         // 可以加入位置影响，例如：
         const posFactor = (x + y) / (2 * canvasSize) * 0.2; // 轻微位置影响

         let r = Math.sin(freq1 * depth + phase1 + posFactor) * 127 + 128;
         let g = Math.sin(freq2 * depth + phase2 + posFactor) * 127 + 128;
         let b = Math.sin(freq3 * depth + phase3 + posFactor) * 127 + 128;

         // 亮度增强 (可以基于深度或位置)
         const brightnessBoost = Math.pow(t, 0.6);
         r = r * (0.7 + brightnessBoost * 0.8);
         g = g * (0.7 + brightnessBoost * 0.8);
         b = b * (0.7 + brightnessBoost * 0.8);

         r = Math.max(0, Math.min(255, Math.floor(r)));
         g = Math.max(0, Math.min(255, Math.floor(g)));
         b = Math.max(0, Math.min(255, Math.floor(b)));

         return `rgb(${r}, ${g}, ${b})`;
     }
     // --- End Color Function ---

     function generateCarpet(x, y, size, depth) {
         // Base Case: 当达到最大深度时，绘制当前方块区域的点
         if (depth >= maxDepth) {
             // 绘制代表这个小方块的点 (可以增加点数提高密度)
             const color = getColor(depth, maxDepth, x, y, size);
             // 绘制中心点
             data.push({ x: x + size / 2, y: y + size / 2, color: color });

              // 可选：增加角点提高密度
              // data.push({ x: x, y: y, color: color });
              // data.push({ x: x + size, y: y, color: color });
              // data.push({ x: x, y: y + size, color: color });
              // data.push({ x: x + size, y: y + size, color: color });

              // 可选：随机填充更多点 (性能消耗更大)
              
              // const numPoints = 5; // 每个最小方块填充的点数
              // for (let i = 0; i < numPoints; i++) {
              //     data.push({
              //         x: x + Math.random() * size,
              //         y: y + Math.random() * size,
              //         color: color
              //     });
              // }
              
             return;
         }

         // Recursive Step: 分成 3x3 网格，对 8 个非中心方块进行递归
         const newSize = size / 3;
         for (let i = 0; i < 3; i++) { // 列 (x)
             for (let j = 0; j < 3; j++) { // 行 (y)
                 // 跳过中心方块 (i=1, j=1)
                 if (i === 1 && j === 1) {
                     continue;
                 }
                 // 计算新方块的左下角坐标 (注意 Highcharts Y 轴向上)
                 const newX = x + i * newSize;
                 const newY = y + j * newSize; // 在 Highcharts 中，Y=0 在底部，所以这样计算是正确的
                 generateCarpet(newX, newY, newSize, depth + 1);
             }
         }
     }

     // 初始调用，覆盖整个画布
     // 注意：Highcharts Y轴从下到上，所以 (0,0) 是左下角
     generateCarpet(0, 0, canvasSize, 0);

     console.log("Generated points:", data.length);
     return data;
 }

 Highcharts.chart('container', {
     chart: {
         type: 'scatter',
         zoomType: 'xy',
         boost: {
             useGPUTranslations: true,
             usePreallocated: true,
             seriesThreshold: 1
         },
         backgroundColor: 'transparent', // 透明背景
         renderTo: 'container'
     },
     title: {
         text: 'Colorful Sierpinski Carpet', // 更新标题
         style: {
             color: '#e0f0ff',
             fontSize: '24px',
             textShadow: '0 0 5px #ffffff'
          }
     },
     // 设置坐标轴范围以匹配画布大小
     xAxis: { min: 0, max: 800, visible: false, startOnTick: false, endOnTick: false },
     yAxis: { min: 0, max: 800, visible: false, startOnTick: false, endOnTick: false },
     legend: { enabled: false },
     plotOptions: {
         scatter: {
             marker: {
                 radius: 1, // 根据 maxDepth 和点密度调整
                 symbol: 'square' // 方形标记更符合地毯主题
             },
             tooltip: { enabled: false },
             boostThreshold: 1,
             states: {
                 hover: { enabled: false },
                 inactive: { enabled: false }
             }
         }
     },
     series: [{
         name: 'Carpet',
         data: generateSierpinskiData(),
         // animation: false // 可选：禁用动画
     }],
     credits: { enabled: false }
 });

 */

+ (NSArray *)generateSierpinskiData {
    NSMutableArray *data = [NSMutableArray array];
    CGFloat canvasSize = 800; // 匹配容器尺寸
    
    // --- Carpet Parameters ---
    NSInteger maxDepth = 6; // 控制递归深度和细节 (6-7 通常足够)
    // const pointDensity = 1; // 1: 中心点, 2: 角点, >2: 更多点填充
    // --- End Carpet Parameters ---
    
    // --- 用于递归生成地毯的内部方法 ---
    // 首先声明block变量，使其可以在自身内部引用
    __block void (^generateCarpet)(CGFloat x, CGFloat y, CGFloat size, NSInteger depth);
    
    generateCarpet = ^(CGFloat x, CGFloat y, CGFloat size, NSInteger depth) {
        // --- Vibrant Color Function (保持不变或微调) ---
        NSString* (^getColor)(NSInteger depth, NSInteger maxDepth, CGFloat x, CGFloat y, CGFloat size) = ^NSString*(NSInteger depth, NSInteger maxDepth, CGFloat x, CGFloat y, CGFloat size) {
            // 使用深度 t (0 到 1) 来驱动颜色变化
            CGFloat t = (CGFloat)depth / maxDepth;
            
            // 霓虹/宇宙风格
            CGFloat freq1 = 0.25, phase1 = 1.5; // 调整频率相位获得不同效果
            CGFloat freq2 = 0.30, phase2 = 2.5;
            CGFloat freq3 = 0.35, phase3 = 0.5;
            
            // 可以加入位置影响，例如：
            CGFloat posFactor = (x + y) / (2 * canvasSize) * 0.2; // 轻微位置影响
            
            CGFloat r = sin(freq1 * depth + phase1 + posFactor) * 127 + 128;
            CGFloat g = sin(freq2 * depth + phase2 + posFactor) * 127 + 128;
            CGFloat b = sin(freq3 * depth + phase3 + posFactor) * 127 + 128;
            
            // 亮度增强 (可以基于深度或位置)
            CGFloat brightnessBoost = pow(t, 0.6);
            r = r * (0.7 + brightnessBoost * 0.8);
            g = g * (0.7 + brightnessBoost * 0.8);
            b = b * (0.7 + brightnessBoost * 0.8);
            
            r = MAX(0, MIN(255, floor(r)));
            g = MAX(0, MIN(255, floor(g)));
            b = MAX(0, MIN(255, floor(b)));
            
            return [NSString stringWithFormat:@"rgb(%d, %d, %d)", (int)r, (int)g, (int)b];
        };
        // --- End Color Function ---
        
        // Base Case: 当达到最大深度时，绘制当前方块区域的点
        if (depth >= maxDepth) {
            // 绘制代表这个小方块的点 (可以增加点数提高密度)
            NSString *color = getColor(depth, maxDepth, x, y, size);
            // 绘制中心点
            [data addObject:@{
                @"x": @(x + size / 2),
                @"y": @(y + size / 2),
                @"color": color
            }];
            
            // 可选：增加角点提高密度
            // [data addObject:@{@"x": @(x), @"y": @(y), @"color": color}];
            // [data addObject:@{@"x": @(x + size), @"y": @(y), @"color": color}];
            // [data addObject:@{@"x": @(x), @"y": @(y + size), @"color": color}];
            // [data addObject:@{@"x": @(x + size), @"y": @(y + size), @"color": color}];
            
            // 可选：随机填充更多点 (性能消耗更大)
            /*
            NSInteger numPoints = 5; // 每个最小方块填充的点数
            for (NSInteger i = 0; i < numPoints; i++) {
                [data addObject:@{
                    @"x": @(x + ((CGFloat)arc4random() / UINT32_MAX) * size),
                    @"y": @(y + ((CGFloat)arc4random() / UINT32_MAX) * size),
                    @"color": color
                }];
            }
            */
            
            return;
        }
        
        // Recursive Step: 分成 3x3 网格，对 8 个非中心方块进行递归
        CGFloat newSize = size / 3;
        for (NSInteger i = 0; i < 3; i++) { // 列 (x)
            for (NSInteger j = 0; j < 3; j++) { // 行 (y)
                // 跳过中心方块 (i=1, j=1)
                if (i == 1 && j == 1) {
                    continue;
                }
                // 计算新方块的左下角坐标 (注意 Highcharts Y 轴向上)
                CGFloat newX = x + i * newSize;
                CGFloat newY = y + j * newSize; // 在 Highcharts 中，Y=0 在底部，所以这样计算是正确的
                generateCarpet(newX, newY, newSize, depth + 1);
            }
        }
    };
    
    // 初始调用，覆盖整个画布
    // 注意：Highcharts Y轴从下到上，所以 (0,0) 是左下角
    generateCarpet(0, 0, canvasSize, 0);
    
    NSLog(@"Generated points: %lu", (unsigned long)data.count);
    return [data copy];
}

+ (AAOptions *)boostFractalChart {
    // 配置 AAChartKit 图表选项
    AAChart *chart = AAChart.new
        .typeSet(AAChartTypeScatter)
//        .zoomTypeSet(AAChartZoomTypeXY)
        .backgroundColorSet(@"transparent")
//        .boostSet(AABoost.new
//            .useGPUTranslationsSet(true)
//            .usePreallocatedSet(true)
//            .seriesThresholdSet(@1))
    ;
    
    AABoost *boost = AABoost.new
        .useGPUTranslationsSet(@true)
        .usePreallocatedSet(@true)
        .seriesThresholdSet(@1);

    AATitle *title = AATitle.new
        .textSet(@"Colorful Sierpinski Carpet")
        .styleSet(AAStyle.new
            .colorSet(@"#e0f0ff")
            .fontSizeSet(@"24px")
            .textOutlineSet(@"0 0 5px #ffffff"));

    AAXAxis *xAxis = AAXAxis.new
        .minSet(@0)
        .maxSet(@800)
        .visibleSet(false)
        .startOnTickSet(false)
        .endOnTickSet(false);

    AAYAxis *yAxis = AAYAxis.new
        .minSet(@0)
        .maxSet(@800)
        .visibleSet(false)
        .startOnTickSet(false)
        .endOnTickSet(false);

    AASeriesElement *seriesElement = AASeriesElement.new
        .nameSet(@"Carpet")
        .dataSet([self generateSierpinskiData])
        .markerSet(AAMarker.new
            .radiusSet(@1)
            .symbolSet(AAChartSymbolTypeSquare));

    AAOptions *options = AAOptions.new
        .chartSet(chart)
        .boostSet(boost)
        .titleSet(title)
        .xAxisSet(xAxis)
        .yAxisSet(yAxis)
        .seriesSet(@[seriesElement])
        .creditsSet(AACredits.new.enabledSet(false));

    return options;
}

@end
