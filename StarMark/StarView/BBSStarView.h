//
//  BBSStarView.h
//  StarMark
//
//  Created by 李子栋 on 2018/3/14.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , BBSStarViewType) {
    BBSStarViewTypeShow,//只显示
    BBSStarViewTypeMark//可打分
};

typedef void(^BBSStarViewDidChangeCallBack)(CGFloat score);

@interface BBSStarView : UIView

@property (copy, nonatomic) BBSStarViewDidChangeCallBack callback;

- (instancetype)initWithFrame:(CGRect)frame
                    starWidth:(CGFloat)starWidth
                        score:(CGFloat)score
                  normalColor:(UIColor *)normalColor
                selectedColor:(UIColor *)selectedColor
                         type:(BBSStarViewType)type;
- (void)setNormalColor:(UIColor *)normalColor;
- (void)setSelectedColor:(UIColor *)selectedColor;
- (void)setStarWidth:(CGFloat)starWidth;
- (void)setSelectedStarWidth:(CGFloat)selectedStarWidth;

@end
