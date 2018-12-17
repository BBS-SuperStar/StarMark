//
//  BBSStarView.m
//  StarMark
//
//  Created by 李子栋 on 2018/3/14.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import "BBSStarView.h"

static NSString *const starStr =  @"★★★★★";

@interface BBSStarView ()

// 根据self的宽度来确定单个星星的大小 默认为self.frame.size.width/5.0
@property (nonatomic, assign) CGFloat starWidth;
@property (nonatomic, assign) CGSize starSize;
//需要显示的星星的长度
@property (nonatomic, assign) CGFloat selectedStarWidth;
//未点亮时候的颜色
@property (nonatomic, retain) UIColor *normalColor;
//点亮的星星的颜色
@property (nonatomic, retain) UIColor *selectedColor;

@end

@implementation BBSStarView

- (instancetype)initWithFrame:(CGRect)frame
                    starWidth:(CGFloat)starWidth
                        score:(CGFloat)score
                  normalColor:(UIColor *)normalColor
                selectedColor:(UIColor *)selectedColor
                         type:(BBSStarViewType)type {
    self = [self initWithFrame:frame];
    if (self) {
        if (starWidth > frame.size.width / 5.0) {
            starWidth = frame.size.width / 5.0;
        }
        if (type == BBSStarViewTypeShow) {
            self.userInteractionEnabled = NO;
        }
        self.starWidth = starWidth;
        self.normalColor = normalColor;
        self.selectedColor = selectedColor;
        UIFont *font = [UIFont boldSystemFontOfSize:self.starWidth];
        self.starSize = [starStr sizeWithAttributes:@{NSFontAttributeName : font}];
        self.selectedStarWidth = self.starSize.width * (score / 5.0);
    }
    return self;
}

// 重写initWithFrame：方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    if ( self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 星星的尺寸
        self.starWidth = frame.size.width/5.0;
        // 未点亮星星的颜色（可根据自己喜好设定）
        self.normalColor = [UIColor grayColor];
        // 点亮星星的颜色
        self.selectedColor = [UIColor yellowColor];
        // 默认长度
        self.selectedStarWidth = 0.0;
        
        [self addGestureRecognizers];
    }
    return self;
}

#pragma mark - EventResponse

- (void)handlePanAction:(UIPanGestureRecognizer *)pan {
    CGPoint currentPoint = [pan locationInView:self];
    [self updateStarsWithTouchPoint:currentPoint];
}

- (void)handleTapAction:(UITapGestureRecognizer *)tap {
    CGPoint currentPoint = [tap locationInView:self];
    [self updateStarsWithTouchPoint:currentPoint];
}

#pragma mark - Private

- (CGRect)drawStar {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize:self.starWidth];

    rect = CGRectMake((self.frame.size.width - self.starSize.width)/2, (self.frame.size.height - self.starSize.height)/2, self.starSize.width, self.starSize.height);
    [starStr drawInRect:rect
       withAttributes:@{NSFontAttributeName : font ,       NSForegroundColorAttributeName : self.normalColor}];
    
    CGRect clip = rect;
    // 裁剪的宽度 = 点亮星星宽度 = （显示的星星数/总共星星数）*总星星的宽度
    clip.size.width = clip.size.width * self.selectedStarWidth / self.starSize.width;
    CGContextClipToRect(context,clip);
    [starStr drawInRect:rect
       withAttributes:@{NSFontAttributeName : font , NSForegroundColorAttributeName : self.selectedColor}];
    return rect;
}

- (void)addGestureRecognizers {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
    [self addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)updateStarsWithTouchPoint:(CGPoint)touchPoint {
    self.selectedStarWidth = touchPoint.x * (self.starSize.width/self.frame.size.width);
    CGFloat score = 5.0 * (self.selectedStarWidth / self.starSize.width);
    if (self.callback) {
        self.callback(score);
    }
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    rect = [self drawStar];
}

#pragma mark - Getters & Setters

- (void)setNormalColor:(UIColor *)normalColor {
    if (_normalColor == normalColor) {
        return;
    }
    _normalColor = normalColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    if (_selectedColor == selectedColor) {
        return;
    }
    _selectedColor = selectedColor;
}

- (void)setStarWidth:(CGFloat)starWidth {
    if (_starWidth == starWidth) {
        return;
    }
    _starWidth = starWidth;
}

- (void)setSelectedStarWidth:(CGFloat)selectedStarWidth {
    if (_selectedStarWidth == selectedStarWidth) {
        return;
    }
    _selectedStarWidth = selectedStarWidth;
}

@end
