//
//  AAData.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AAData.h"
#import "NSString+toPureJSString.h"

@implementation AAData

AAPropSetFuncImplementation(AAData, NSString     *, csv)
//AAPropSetFuncImplementation(AAData, NSString     *, parsed)

AAJSFuncTypePropSetFuncImplementation(AAData, NSString     *, parsed)

- (void)setParsed:(NSString *)parsed {
    _parsed = [parsed aa_toPureJSString];
}

@end
