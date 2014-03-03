//
//  SALoadingView.h
//  Sample App
//
//  Created by Astha on 3/01/14.
//  Copyright 2014 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    SALoadingViewStyleDefault = 0,
    SALoadingViewStyleRounded,
    SALoadingViewStyleFull
} SALoadingViewStyle;

@class SALoadingView;
@protocol SALoadingViewDelegate <NSObject>
@optional

- (void)didStartLoadingViewAnimation:(SALoadingView *)loadingView;
- (void)didEndLoadingViewAnimation:(SALoadingView *)loadingView;

@end


@interface SALoadingView : UIView


@property (nonatomic, assign, readwrite) SALoadingViewStyle style;
@property (nonatomic, weak  , readwrite) NSObject<SALoadingViewDelegate> *delegate;


+ (id)loadingViewInNewWindowWithMessage:(NSString *)message delegate:(id)delegate;
+ (id)loadingViewInView:(UIView *)aSuperview withDelegate:(id)delegate;
+ (id)loadingViewInView:(UIView *)aSuperview withMessage:(NSString *)message withStyle:(SALoadingViewStyle)style withDelegate:(id)delegate;
- (void)removeView;
+ (SALoadingView *)showLoadingViewWithMessage:(NSString *)message view:(UIView *)view;
- (void)updateMessage:(NSString *)message;

@end


