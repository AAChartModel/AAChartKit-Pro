//
//  NSString+toPureJSString.m
//  AAChartKitDemo
//
//  Created by AnAn on 2020/8/11.
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
 * ------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/12302132/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "NSString+toPureJSString.h"

@implementation NSString (pureJSString)

- (NSString *)aa_toPureJSString {
    //https://stackoverflow.com/questions/34334232/why-does-function-not-work-but-function-does-chrome-devtools-node
    NSString *pureJSStr = [NSString stringWithFormat:@"(%@)",self];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\0" withString:@""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    return pureJSStr;
}

- (NSString *)aa_toPureHTMLString {
    //https://stackoverflow.com/questions/34334232/why-does-function-not-work-but-function-does-chrome-devtools-node
    NSString *pureJSStr = [NSString stringWithFormat:@"%@",self];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\0" withString:@""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    return pureJSStr;
}

- (NSString *)aa_toPureCSVString {
    //https://stackoverflow.com/questions/34334232/why-does-function-not-work-but-function-does-chrome-devtools-node
    NSString *pureJSStr = [NSString stringWithFormat:@"(%@)",self];
    //⚠️:这里替代单引号的方法有点缺陷, 当英文单词种类包含有单引号时,会导致替换错误
    //比如: 'I'm a student' 这个字符串,替换后会变成: "I"m a student", 这样会导致最终的 Highcharts 渲染失败
    //后续再想办法解决这个问题
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\0" withString:@""];
//    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    return pureJSStr;
}

@end
