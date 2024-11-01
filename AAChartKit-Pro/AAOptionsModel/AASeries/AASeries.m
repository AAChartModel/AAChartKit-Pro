//
//  AASeries.m
//  AAChartKit
//
//  Created by An An on 17/1/19.
//  Copyright © 2017年 An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/12302132/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "AASeries.h"
#import "NSString+toPureJSString.h"

@implementation AASeries

AAPropSetFuncImplementation(AASeries, NSNumber     *, borderRadius)
AAPropSetFuncImplementation(AASeries, NSNumber     *, borderWidth)
AAPropSetFuncImplementation(AASeries, AAMarker     *, marker) 
AAPropSetFuncImplementation(AASeries, NSString     *, stacking) 
AAPropSetFuncImplementation(AASeries, AAAnimation  *, animation) 
AAPropSetFuncImplementation(AASeries, NSArray      *, keys) 
//AAPropSetFuncImplementation(AASeries, BOOL , colorByPoint) //设置为 true 则是给每个点分配颜色。
AAPropSetFuncImplementation(AASeries, BOOL ,          connectNulls) 
AAPropSetFuncImplementation(AASeries, AAEvents     *, events)
AAPropSetFuncImplementation(AASeries, AAShadow     *, shadow)
AAPropSetFuncImplementation(AASeries, AADataLabels *, dataLabels)
AAPropSetFuncImplementation(AASeries, AAStates     *, states)
AAPropSetFuncImplementation(AASeries, AAPoint      *, point)
AAPropSetFuncImplementation(AASeries, NSNumber     *, pointPadding)
AAPropSetFuncImplementation(AASeries, NSNumber     *, groupPadding)
AAPropSetFuncImplementation(AASeries, NSNumber     *, borderRadiusTopLeft)
AAPropSetFuncImplementation(AASeries, NSNumber     *, borderRadiusTopRight)
AAPropSetFuncImplementation(AASeries, NSNumber     *, borderRadiusBottomLeft)
AAPropSetFuncImplementation(AASeries, NSNumber     *, borderRadiusBottomRight)
AAPropSetFuncImplementation(AASeries, NSString     *, tileShape)
AAPropSetFuncImplementation(AASeries, AATooltip    *, tooltip)

@end


@implementation AAEvents

//AAPropSetFuncImplementation(AAEvents, NSString *, click)
//AAPropSetFuncImplementation(AAEvents, NSString *, mouseOver)
//AAPropSetFuncImplementation(AAEvents, NSString *, mouseOut)
//AAPropSetFuncImplementation(AAEvents, NSString *, legendItemClick)

AAJSFuncTypePropSetFuncImplementation(AAEvents, NSString *, click)
AAJSFuncTypePropSetFuncImplementation(AAEvents, NSString *, mouseOver)
AAJSFuncTypePropSetFuncImplementation(AAEvents, NSString *, mouseOut)
AAJSFuncTypePropSetFuncImplementation(AAEvents, NSString *, legendItemClick)

- (void)setClick:(NSString *)click {
    _click = [click aa_toPureJSString];
}

- (void)setMouseOver:(NSString *)mouseOver {
    _mouseOut = [mouseOver aa_toPureJSString];
}

- (void)setMouseOut:(NSString *)mouseOut {
    _mouseOut = [mouseOut aa_toPureJSString];
}

- (void)setLegendItemClick:(NSString *)legendItemClick {
    _legendItemClick = [legendItemClick aa_toPureJSString];
}

@end


@implementation AAPoint : NSObject

AAPropSetFuncImplementation(AAPoint, AAPointEvents     *, events)

@end


@implementation AAPointEvents : NSObject

//AAPropSetFuncImplementation(AAPointEvents, NSString *, click) //点击事件
//AAPropSetFuncImplementation(AAPointEvents, NSString *, mouseOut) //鼠标划出
//AAPropSetFuncImplementation(AAPointEvents, NSString *, mouseOver) //鼠标划过
//AAPropSetFuncImplementation(AAPointEvents, NSString *, remove) //删除
//AAPropSetFuncImplementation(AAPointEvents, NSString *, select) //选中
//AAPropSetFuncImplementation(AAPointEvents, NSString *, unselect) //取消选中
//AAPropSetFuncImplementation(AAPointEvents, NSString *, update) //更新

AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, click) //点击事件
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, mouseOut) //鼠标划出
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, mouseOver) //鼠标划过
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, remove) //删除
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, select) //选中
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, unselect) //取消选中
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, update) //更新

- (void)setClick:(NSString *)click {
    _click = [click aa_toPureJSString];
}

- (void)setMouseOut:(NSString *)mouseOut {
    _mouseOut = [mouseOut aa_toPureJSString];
}

- (void)setMouseOver:(NSString *)mouseOver {
    _mouseOver = [mouseOver aa_toPureJSString];
}

- (void)setRemove:(NSString *)remove {
    _remove = [remove aa_toPureJSString];
}

- (void)setSelect:(NSString *)select {
    _select = [select aa_toPureJSString];
}

- (void)setUnselect:(NSString *)unselect {
    _unselect = [unselect aa_toPureJSString];
}

- (void)setUpdate:(NSString *)update {
    _update = [update aa_toPureJSString];
}

@end
