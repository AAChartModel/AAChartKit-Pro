//
//  AAThemeTransitionAnimator.h
//  AAChartKit-ProDemo
//
//  Performs the orb-ripple animation when switching between light and dark themes.
//  A direct port of the Swift ThemeTransitionAnimator in the Swift companion app.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAThemeTransitionAnimator : NSObject

/**
 Runs the orb-ripple theme transition animation on the given window.

 @param isDark    Whether we are transitioning TO dark mode.
 @param window    The key window to animate on.
 @param origin    The point in window coordinates from which the orb expands
                  (typically the center of the toggle button).
 @param applyBlock The block that actually applies the theme change. It is called
                   approximately 0.16 s into the animation so the new UI appears
                   behind the dissolving snapshot.
 */
+ (void)animateToIsDark:(BOOL)isDark
               onWindow:(UIWindow *)window
             fromOrigin:(CGPoint)origin
             applyBlock:(void (^)(void))applyBlock;

@end

NS_ASSUME_NONNULL_END
