//
//  SKPariseButton.h
//  SKPariseButtonDemo
//
//  Created by Leou on 16/5/30.
//  Copyright © 2016年 Leou. All rights reserved.
//


/*  *************************** */
/** 程序内部控件使用自动布局 */
/*  *************************** */


#import <UIKit/UIKit.h>

/** 回调绑定, id obj是将自身传过去，传过去之后可以用来调用该类的方法 */
typedef void (^SKButtonHandler)(id obj);

@interface SKPariseButton : UIView {
    
    UIImageView *skImageView;
    
    /** 
     *  CAEmitterLayer CAEmitterCell。 
     *      
     *      CAEmitterLayer提供了一个基于Core Animation的粒子发射系统，粒子用CAEmitterCell来初始化。 
     */
    CAEmitterLayer *_effectLayer;
    CAEmitterCell  *_effectCell;
}

/** 增加点击事件 */
/** 点击事件属性：在Button点击事件实现传self，可以将block绑定到button的点击事件上 */
@property (nonatomic, copy)SKButtonHandler skPariseHandler;
/** 点击事件方法 */
- (void)addTargetHandler:(SKButtonHandler)skPariseHandler;

/** 点击之后 如果需要可以置为选中状态 */
@property (nonatomic, assign)BOOL isPariseSelected;


/** 按钮默认的宽高20*20 **/
- (instancetype)initWithFrame:(CGRect)frame normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

- (instancetype)initWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

@property (nonatomic, strong)UIImage *normalImage;

@property (nonatomic, strong)UIImage *selectedImage;

@end
