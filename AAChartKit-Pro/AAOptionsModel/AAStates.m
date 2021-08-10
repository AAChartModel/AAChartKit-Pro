//
//  AAStates.m
//  AAChartKitDemo
//
//  Created by AnAn on 2020/1/6.
//  Copyright © 2020 An An. All rights reserved.
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

#import "AAStates.h"

@implementation AAStates

AAPropSetFuncImplementation(AAStates, AAHover    *, hover)
AAPropSetFuncImplementation(AAStates, AASelect   *, select)
AAPropSetFuncImplementation(AAStates, AAInactive *, inactive)

@end


@implementation AAHover

- (instancetype)init {
    self = [super init];
    if (self) {
        _enabled = true;
    }
    return self;
}

AAPropSetFuncImplementation(AAHover, BOOL,       enabled)
AAPropSetFuncImplementation(AAHover, NSString *, borderColor)
AAPropSetFuncImplementation(AAHover, NSNumber *, brightness)
AAPropSetFuncImplementation(AAHover, NSString *, color)
AAPropSetFuncImplementation(AAHover, AAHalo   *, halo)
AAPropSetFuncImplementation(AAHover, NSNumber *, lineWidth)
AAPropSetFuncImplementation(AAHover, NSNumber *, lineWidthPlus)



@end


@implementation AASelect

- (instancetype)init {
    self = [super init];
    if (self) {
        _enabled = true;
    }
    return self;
}

AAPropSetFuncImplementation(AASelect, BOOL,       enabled)
AAPropSetFuncImplementation(AASelect, NSString *, borderColor)
AAPropSetFuncImplementation(AASelect, NSString *, color)
AAPropSetFuncImplementation(AASelect, AAHalo   *, halo)

@end


@implementation AAHalo

AAPropSetFuncImplementation(AAHalo, NSDictionary *, attributes)
AAPropSetFuncImplementation(AAHalo, NSNumber *, opacity)
AAPropSetFuncImplementation(AAHalo, NSNumber *, size)

@end


@implementation AAInactive

- (instancetype)init {
    self = [super init];
    if (self) {
        _enabled = true;
    }
    return self;
}

AAPropSetFuncImplementation(AAInactive, BOOL,       enabled)
AAPropSetFuncImplementation(AAInactive, NSNumber *, opacity)

@end
