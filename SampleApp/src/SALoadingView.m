//
//  SALoadingView.h
//  Sample App
//
//  Created by Astha on 3/01/14.
//  Copyright 2014 Astha. All rights reserved.
///

#import "SALoadingView.h"


#define kSALoadingLabelTag 1001


// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface SALoadingView ()

// modified for ARC conversion
//@property (nonatomic, assign, readwrite, getter=isInSeparateWindow) BOOL inSeparateWindow;
@property (nonatomic, strong, readwrite) UIWindow *separateWindow;

@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation SALoadingView


+ (SALoadingView *)showLoadingViewWithMessage:(NSString *)message view:(UIView *)view {
    
    SALoadingView *loadingView =
    [SALoadingView loadingViewInView:view
                          withMessage:message
                            withStyle:SALoadingViewStyleFull
                         withDelegate:nil];
    return loadingView;
}


+ (void)removeLoadingView:(SALoadingView *)loadingView {
    [loadingView removeView];
}


+ (id)loadingViewInNewWindowWithMessage:(NSString *)message delegate:(id)delegate {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    // modified for ARC conversion
    //UIWindow *window = [[UIWindow alloc] initWithFrame:frame]; // Releasing in removeView
    UIWindow *window = [[UIWindow alloc] initWithFrame:frame];
    
    window.backgroundColor = [UIColor clearColor];
    window.opaque = NO;
    
    UIView *placementView = [[UIView alloc] initWithFrame:window.bounds];
    [window addSubview:placementView];
    
    SALoadingView *loadingView = [self loadingViewInView:placementView
                                              withMessage:message
                                                withStyle:SALoadingViewStyleFull
                                             withDelegate:delegate];
    // modified for ARC conversion
    //loadingView.inSeparateWindow = YES;
    loadingView.separateWindow = window;
    window.windowLevel = UIWindowLevelStatusBar + 1; // Highest level
    [window makeKeyAndVisible];
    NSLog(@"Added new window for loading view: %@", window);
    
    // modified for ARC conversion
    
    return loadingView;
}


+ (id)loadingViewInView:(UIView *)aSuperview withDelegate:(id)delegate {
    return [SALoadingView loadingViewInView:aSuperview withMessage:@"Loading..."  withStyle:SALoadingViewStyleDefault withDelegate:delegate];
}


+ (id)loadingViewInView:(UIView *)aSuperview withMessage:(NSString *)message withStyle:(SALoadingViewStyle)style withDelegate:(id)delegate {
    SALoadingView *loadingView =
    [[SALoadingView alloc] initWithFrame:[aSuperview.window bounds]];
    if (!loadingView) {
        return nil;
    }
    
    loadingView.delegate = delegate;
    loadingView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.85f];
    
    loadingView.opaque = NO;
    loadingView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [aSuperview.window addSubview:loadingView];
    
    const CGFloat DEFAULT_LABEL_WIDTH = 280.0;
    const CGFloat DEFAULT_LABEL_HEIGHT = 50.0;
    CGRect labelFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:labelFrame];
    loadingLabel.text = NSLocalizedString(message, nil);
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    loadingLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    loadingLabel.numberOfLines = 3;
    loadingLabel.tag = kSALoadingLabelTag;
    
    [loadingView addSubview:loadingLabel];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView addSubview:activityIndicatorView];
    activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [activityIndicatorView startAnimating];
    
    CGFloat totalHeight = loadingLabel.frame.size.height + activityIndicatorView.frame.size.height;
    labelFrame.origin.x = floor(0.5f * (loadingView.frame.size.width - DEFAULT_LABEL_WIDTH));
    labelFrame.origin.y = floor(0.5f * (loadingView.frame.size.height - totalHeight));
    loadingLabel.frame = labelFrame;
    
    CGRect activityIndicatorRect = activityIndicatorView.frame;
    activityIndicatorRect.origin.x = 0.5f * (loadingView.frame.size.width - activityIndicatorRect.size.width);
    activityIndicatorRect.origin.y = loadingLabel.frame.origin.y + loadingLabel.frame.size.height;
    activityIndicatorView.frame = activityIndicatorRect;
    
    // Set up the fade-in animation
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    [[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
    
    NSObject<SALoadingViewDelegate> *tmpDelegate = loadingView.delegate; // get rid of ARC warnign
    if ([tmpDelegate respondsToSelector:@selector(didStartLoadingViewAnimation:)]) {
        [tmpDelegate didStartLoadingViewAnimation:loadingView];
    }
    
    return loadingView;
}

- (void)removeView {
    // create a strong reference to the delegate because it could be nil'ed out at anytime
    NSObject<SALoadingViewDelegate> *strongDelegate = self.delegate;
    
    if (self.separateWindow) {
        [self.separateWindow removeFromSuperview];
        NSLog(@"Removing window from application: %@", self.separateWindow);
    }
    
	UIView *aSuperview = [self superview];
	[super removeFromSuperview];
	
	// Set up the animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
	
	if (strongDelegate &&
        [strongDelegate respondsToSelector:@selector(didEndLoadingViewAnimation:)])
		[strongDelegate didEndLoadingViewAnimation:self];
    
    // modified for ARC conversion
    self.separateWindow = nil;
}


- (void)updateMessage:(NSString *)message {
    UILabel *loadingLabel = (UILabel *) [self viewWithTag:kSALoadingLabelTag];
    loadingLabel.text = message;
}


@end
