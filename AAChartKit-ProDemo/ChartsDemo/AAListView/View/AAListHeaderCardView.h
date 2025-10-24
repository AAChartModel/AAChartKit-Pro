#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAListHeaderCardView : UIView

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *subtitleText;
@property (nonatomic, assign, getter=isDarkMode) BOOL darkMode;

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle;
- (void)applyThemeWithDarkMode:(BOOL)isDarkMode;
- (void)updateChipTitles:(NSArray<NSString *> *)chipTitles;

@end

NS_ASSUME_NONNULL_END
