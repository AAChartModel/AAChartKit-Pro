#import "BackgroundEffectsScene.h"
#import <SpriteKit/SpriteKit.h>

// 重新定义常量
#define NUM_SEARCHLIGHTS 2
#define OVERLAP_ANGLE_THRESHOLD (M_PI / 12.0) // 光束角度小于这个阈值视为重叠 (可调整)
#define FLASH_DURATION 0.5 // 碰撞闪烁的总持续时间

@interface BackgroundEffectsScene()

// 重新添加探照灯属性
@property (nonatomic, strong) NSMutableArray<SKShapeNode *> *searchlightNodes;
@property (nonatomic, strong) SKEffectNode *effectNode; // 用于模糊和混合
@property (nonatomic, strong) NSArray<SKColor *> *lightColors; // 预设颜色
@property (nonatomic, strong) NSMutableArray<NSNumber *> *isFlashing; // 跟踪每个光束是否在闪烁
@property (nonatomic, strong) SKAction *collisionFlashAction; // 碰撞时的闪烁动作

@end

@implementation BackgroundEffectsScene

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];

    // 恢复深色背景
    self.backgroundColor = [SKColor colorWithRed:0.01 green:0.01 blue:0.05 alpha:1.0];

    // 恢复初始化颜色数组
    self.lightColors = @[
        [SKColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:0.7], // Red-ish
        [SKColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:0.7], // Green-ish
        [SKColor colorWithRed:0.2 green:0.4 blue:0.9 alpha:0.7], // Blue-ish
        [SKColor colorWithRed:0.8 green:0.8 blue:0.2 alpha:0.7], // Yellow-ish
        [SKColor colorWithRed:0.8 green:0.3 blue:0.8 alpha:0.7], // Magenta-ish
        [SKColor colorWithRed:0.2 green:0.8 blue:0.8 alpha:0.7]  // Cyan-ish
    ];

    // 恢复初始化闪烁状态跟踪数组
    self.isFlashing = [NSMutableArray arrayWithCapacity:NUM_SEARCHLIGHTS];
    for (int i = 0; i < NUM_SEARCHLIGHTS; ++i) {
        [self.isFlashing addObject:@(NO)];
    }

    // 恢复调用探照灯设置方法
    [self setupEffectNode];
    [self setupSearchlights]; // 使用固定数量的设置方法
    [self createCollisionFlashAction];
    [self startSearchlightAnimation]; // 使用固定数量的动画方法
}

// 恢复：设置效果节点 (模糊和混合)
- (void)setupEffectNode {
    self.effectNode = [SKEffectNode node];
    self.effectNode.filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                   withInputParameters:@{@"inputRadius": @15.0}];
    self.effectNode.shouldEnableEffects = YES;
    self.effectNode.blendMode = SKBlendModeAdd;
    self.effectNode.zPosition = 1;
    [self addChild:self.effectNode];
}

// 恢复：设置固定数量的探照灯
- (void)setupSearchlights {
    self.searchlightNodes = [NSMutableArray array];
    CGPoint origin = CGPointMake(0, 0);
    CGFloat beamLength = self.size.height * 1.8;
    CGFloat beamWidth = 150.0;

    for (int i = 0; i < NUM_SEARCHLIGHTS; ++i) {
        SKShapeNode *lightNode = [SKShapeNode node];

        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, origin.x, origin.y);
        CGPathAddLineToPoint(path, NULL, beamLength, -beamWidth / 2.0);
        CGPathAddLineToPoint(path, NULL, beamLength, beamWidth / 2.0);
        CGPathCloseSubpath(path);
        lightNode.path = path;
        CFRelease(path);

        lightNode.fillColor = self.lightColors[arc4random_uniform((uint32_t)self.lightColors.count)];
        lightNode.strokeColor = [SKColor clearColor];

        CGFloat initialAngle = (M_PI / 8.0) + (arc4random_uniform(100) / 100.0) * (M_PI / 4.0);
        lightNode.zRotation = initialAngle;

        [self.effectNode addChild:lightNode];
        [self.searchlightNodes addObject:lightNode];
    }
}

// 恢复：创建碰撞闪烁动作
- (void)createCollisionFlashAction {
    SKAction *flashToWhite = [SKAction colorizeWithColor:[SKColor colorWithWhite:1.0 alpha:0.9] colorBlendFactor:1.0 duration:FLASH_DURATION / 2.0];
    flashToWhite.timingMode = SKActionTimingEaseOut;
    SKAction *revertColor = [flashToWhite reversedAction];
    revertColor.timingMode = SKActionTimingEaseIn;
    self.collisionFlashAction = [SKAction sequence:@[flashToWhite, revertColor]];
}

// 恢复：启动固定数量探照灯的动画 (使用之前的 runBlock 方式确保连续)
- (void)startSearchlightAnimation {
    for (int i = 0; i < self.searchlightNodes.count; ++i) {
         SKShapeNode *lightNode = self.searchlightNodes[i];
         // 使用弱引用避免 block 循环引用
         __weak SKShapeNode *weakLightNode = lightNode;
         __weak BackgroundEffectsScene *weakSelf = self;

         [lightNode removeAllActions]; // 清除旧动画

        // 创建一个无限循环的动作块
        SKAction * (^createAnimationBlock)(void) = ^{
            // 确保弱引用仍然有效
            SKShapeNode *strongLightNode = weakLightNode;
            BackgroundEffectsScene *strongSelf = weakSelf;
            if (!strongLightNode || !strongSelf) return [SKAction waitForDuration:0.1]; // 如果节点或场景已释放，返回空动作

            // --- 旋转动作 ---
            CGFloat currentAngle = strongLightNode.zRotation;
            CGFloat targetAngle = (M_PI / 8.0) + (arc4random_uniform(100) / 100.0) * (5.0 * M_PI / 16.0);
            if (fabs(targetAngle - currentAngle) < M_PI / 16.0) {
                 targetAngle += M_PI / 8.0 * (arc4random_uniform(2) ? 1 : -1);
                 targetAngle = MAX(M_PI / 8.0, MIN(7.0 * M_PI / 16.0, targetAngle));
            }
            SKAction *rotate = [SKAction rotateToAngle:targetAngle duration:(arc4random_uniform(20) + 30) / 10.0];
            rotate.timingMode = SKActionTimingEaseInEaseOut;

            // --- 颜色动作 ---
            SKColor *nextColor = strongSelf.lightColors[arc4random_uniform((uint32_t)strongSelf.lightColors.count)];
            while ([nextColor isEqual:strongLightNode.fillColor] && strongSelf.lightColors.count > 1) {
                 nextColor = strongSelf.lightColors[arc4random_uniform((uint32_t)strongSelf.lightColors.count)];
            }
            SKAction *changeColor = [SKAction colorizeWithColor:nextColor colorBlendFactor:1.0 duration:1.5];

            // --- 组合动作 ---
            CGFloat maxDuration = MAX(rotate.duration, changeColor.duration + 0.5);
            SKAction *group = [SKAction group:@[rotate, changeColor]];
            SKAction *wait = [SKAction waitForDuration:maxDuration + (arc4random_uniform(10)/10.0)];

            return [SKAction sequence:@[group, wait]];
        };

        // 创建一个无限重复执行上述动作块的动作
        SKAction *repeatBlock = [SKAction repeatActionForever:[SKAction sequence:@[
            [SKAction runBlock:^{
                SKShapeNode *strongLightNode = weakLightNode;
                if (strongLightNode) {
                    SKAction *singleAnimation = createAnimationBlock();
                    [strongLightNode runAction:singleAnimation withKey:@"singleCycle"];
                }
            }],
            [SKAction waitForDuration:6.0 withRange:2.0]
        ]]];

        [lightNode runAction:repeatBlock withKey:@"mainLoop"];
    }
}

#pragma mark - Update Loop for Animation / Collision Check

// 恢复 Update 循环 (只检查前两个)
- (void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];

    // 恢复碰撞检查 (简化为只检查前两个)
    if (self.searchlightNodes.count >= 2) {
        SKShapeNode *light1 = self.searchlightNodes[0];
        SKShapeNode *light2 = self.searchlightNodes[1];
        // 确保 isFlashing 数组至少有两个元素
        if (self.isFlashing.count < 2) return;

        BOOL flashing1 = [self.isFlashing[0] boolValue];
        BOOL flashing2 = [self.isFlashing[1] boolValue];

        CGFloat angleDifference = fabs(light1.zRotation - light2.zRotation);
        if (angleDifference > M_PI) {
            angleDifference = 2 * M_PI - angleDifference;
        }

        if (angleDifference < OVERLAP_ANGLE_THRESHOLD) {
            if (!flashing1) {
                self.isFlashing[0] = @(YES);
                [light1 runAction:self.collisionFlashAction completion:^{
                    // 检查索引是否仍然有效
                    if (self.isFlashing.count > 0) self.isFlashing[0] = @(NO);
                }];
            }
            if (!flashing2) {
                self.isFlashing[1] = @(YES);
                [light2 runAction:self.collisionFlashAction completion:^{
                     if (self.isFlashing.count > 1) self.isFlashing[1] = @(NO);
                }];
            }
        }
    }
}

// 当场景尺寸变化时调整精灵节点尺寸
- (void)didChangeSize:(CGSize)oldSize {
    [super didChangeSize:oldSize];

    // 探照灯效果基于原点绘制，通常不需要在尺寸变化时调整，
    // 但如果 effectNode 不是全屏或需要更精确控制，可以在此调整
    // self.effectNode.position = CGPointMake(self.size.width / 2, self.size.height / 2);
}

@end
