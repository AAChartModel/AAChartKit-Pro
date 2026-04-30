//
//  AAThemeTransitionOrbView.m
//  AAChartKit-ProDemo
//

#import "AAThemeTransitionOrbView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AAThemeTransitionOrbView

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.layer.cornerRadius = frame.size.width / 2.0f;
        self.layer.masksToBounds = YES;

        CAGradientLayer *g = (CAGradientLayer *)self.layer;
        if (@available(iOS 12.0, *)) {
            g.type = kCAGradientLayerRadial;
        }
        g.startPoint = CGPointMake(0.5, 0.5);
        g.endPoint = CGPointMake(1.0, 1.0);
        g.locations = @[@0.0, @0.42, @1.0];
    }
    return self;
}

- (void)configureWithColors:(NSArray<UIColor *> *)colors {
    CAGradientLayer *g = (CAGradientLayer *)self.layer;
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *c in colors) {
        [cgColors addObject:(__bridge id)c.CGColor];
    }
    g.colors = cgColors;
}

@end
