//
//  AAThemeTransitionOrbView.h
//  AAChartKit-ProDemo
//
//  A UIView subclass that uses a radial CAGradientLayer as its backing layer,
//  used as the expanding orb visual during theme transitions.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(ios(12.0))
@interface AAThemeTransitionOrbView : UIView

- (void)configureWithColors:(NSArray<UIColor *> *)colors;

@end

NS_ASSUME_NONNULL_END
