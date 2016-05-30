//
//  SKPariseButton.m
//  SKPariseButtonDemo
//
//  Created by Leou on 16/5/30.
//  Copyright © 2016年 Leou. All rights reserved.
//

#import "SKPariseButton.h"

@implementation SKPariseButton

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _normalImage = [UIImage imageNamed:@"new_normal"];
        _selectedImage = [UIImage imageNamed:@"new_selected"];
        
        [self initSubviews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _normalImage = [UIImage imageNamed:@"new_normal"];
        _selectedImage = [UIImage imageNamed:@"new_selected"];
        
        [self initSubviews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _normalImage = normalImage;
        _selectedImage = selectedImage;
    }
    
    return self;
}

- (instancetype)initWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
    
    self = [super init];
    
    if (self) {
        
        _normalImage = normalImage;
        _selectedImage = selectedImage;
    }
    
    return self;
}

- (void)initSubviews {
    
    /** 初始化图片 */
    skImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    skImageView.translatesAutoresizingMaskIntoConstraints = NO;
    skImageView.backgroundColor = [UIColor clearColor];
    [skImageView setImage:_normalImage];
    [skImageView setUserInteractionEnabled:YES];
    [self addSubview:skImageView];
    [self constraintItem:skImageView toItem:self topMultiplier:0 topConstant:0 bottomMultiplier:0 bottomConstant:0 leftMultiplier:1 leftConstant:10 rightMultiplier:0 rightConstant:0 widthMultiplier:0 width:20 heightMultiplier:0 height:20];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:skImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    UITapGestureRecognizer *tapImageViewGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animationPlay)];
    [skImageView addGestureRecognizer:tapImageViewGesture];
    
    /** 创建粒子发射系统 **/
    _effectLayer = [CAEmitterLayer layer];
    [skImageView.layer addSublayer:_effectLayer];
    [self constraintItem:skImageView toItem:skImageView topMultiplier:1 topConstant:0 bottomMultiplier:1 bottomConstant:0 leftMultiplier:1 leftConstant:0 rightMultiplier:1 rightConstant:0 widthMultiplier:0 width:0 heightMultiplier:0 height:0];
    [_effectLayer setEmitterShape:kCAEmitterLayerCircle];
    [_effectLayer setEmitterMode:kCAEmitterLayerOutline];
    [_effectLayer setEmitterPosition:CGPointMake(10, 10)];
    [_effectLayer setEmitterSize:CGSizeMake(CGRectGetWidth(skImageView.frame), CGRectGetHeight(skImageView.frame))];
    
    /** 创建粒子 **/
    _effectCell=[CAEmitterCell emitterCell];
    [_effectCell setName:@"zanShape"];
    [_effectCell setContents:(__bridge id)[UIImage imageNamed:@"EffectImage"].CGImage];
    [_effectCell setAlphaSpeed:1.0f];
    [_effectCell setLifetime:0.7f];
    [_effectCell setBirthRate:0];
    [_effectCell setVelocity:50];
    [_effectCell setVelocityRange:50];
    
    /** 绑定粒子 **/
    [_effectLayer setEmitterCells:@[_effectCell]];
}

/** 执行动画 **/ 
- (void)animationPlay {
    
    /** 点击之后暂时设置userInteractionEnabled为NO */
    if (_skPariseHandler) {
        
        skImageView.userInteractionEnabled = NO;
        _skPariseHandler(self);
    }else {
        
        return;
    }
    
    [skImageView setBounds:CGRectZero];
    [UIView animateWithDuration:.5f delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:5 options:UIViewAnimationOptionCurveLinear animations:^{
        
        [skImageView setBounds:CGRectMake(0, 0, 20, 20)];
        
        skImageView.hidden = NO;
        
        if (YES) {
            
            CABasicAnimation *effectLayerAnimation=[CABasicAnimation animationWithKeyPath:@"emitterCells.zanShape.birthRate"];
            [effectLayerAnimation setFromValue:[NSNumber numberWithFloat:100]];
            [effectLayerAnimation setToValue:[NSNumber numberWithFloat:0]];
            [effectLayerAnimation setDuration:0.0f];
            [effectLayerAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [_effectLayer addAnimation:effectLayerAnimation forKey:@"ZanCount"];
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setIsPariseSelected:(BOOL)isPariseSelected {
    
    _isPariseSelected = isPariseSelected;
    
    /** 逻辑：图片置为选中图片，并不可再点击 */
    if (_isPariseSelected) {
        
        skImageView.userInteractionEnabled = NO;
        [skImageView setImage:_selectedImage];
    }else {
        
        skImageView.userInteractionEnabled = YES;
        [skImageView setImage:_normalImage];
    }
}

/** 增加点击事件 */
- (void)setSkPariseHandler:(SKButtonHandler)skPariseHandler {
    
    _skPariseHandler = skPariseHandler;
}

- (void)addTargetHandler:(SKButtonHandler)skPariseHandler {
    
    _skPariseHandler = skPariseHandler;
}

#pragma mark - 依赖于superView的约束
- (void)constraintItem:(id)view1 toItem:(id)view2 topMultiplier:(CGFloat)topMultiplier topConstant:(CGFloat)top bottomMultiplier:(CGFloat)bottomMultiplier bottomConstant:(CGFloat)bottom leftMultiplier:(CGFloat)leftMultiplier leftConstant:(CGFloat)left rightMultiplier:(CGFloat)rightMultiplier rightConstant:(CGFloat)right widthMultiplier:(CGFloat)widthMultiplier width:(CGFloat)width heightMultiplier:(CGFloat)heightMultiplier height:(CGFloat)height {
    
    if (top != 0 || topMultiplier != 0) {
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:view1
                             attribute:NSLayoutAttributeTop
                             relatedBy:NSLayoutRelationEqual
                             toItem:view2
                             attribute:NSLayoutAttributeTop
                             multiplier:topMultiplier
                             constant:top]];
    }
    
    if (bottom != 0 || bottomMultiplier != 0) {
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:view1
                             attribute:NSLayoutAttributeBottom
                             relatedBy:NSLayoutRelationEqual
                             toItem:view2
                             attribute:NSLayoutAttributeBottom
                             multiplier:bottomMultiplier
                             constant:bottom]];
    }
    
    if (left != 0 || leftMultiplier != 0) {
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:view1
                             attribute:NSLayoutAttributeLeft
                             relatedBy:NSLayoutRelationEqual
                             toItem:view2
                             attribute:NSLayoutAttributeLeft
                             multiplier:leftMultiplier
                             constant:left]];
    }
    
    if (right != 0 || rightMultiplier != 0) {
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:view1
                             attribute:NSLayoutAttributeRight
                             relatedBy:NSLayoutRelationEqual
                             toItem:view2
                             attribute:NSLayoutAttributeRight
                             multiplier:rightMultiplier
                             constant:right]];
    }
    
    if (widthMultiplier != 0 || width != 0) {
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:view1
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:view2
                             attribute:NSLayoutAttributeWidth
                             multiplier:widthMultiplier
                             constant:width]];
    }
    
    if (heightMultiplier != 0 || height != 0) {
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:view1
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                             toItem:view2
                             attribute:NSLayoutAttributeHeight
                             multiplier:heightMultiplier
                             constant:height]];
    }
}

@end
