//
//  SACustomButton.m
//  SampleApp
//
//  Created by Astha on 3/1/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import "SACustomButton.h"

@implementation SACustomButton


+ (SACustomButton *)createButtonForType:(CustomButtonType)buttonType title:(NSString *)title {
    SACustomButton *customButton = [SACustomButton buttonWithType:UIButtonTypeCustom];
    customButton.frame = CGRectZero;
    switch (buttonType) {
        case CustomButtonTypeLogin: {
            customButton.backgroundColor = [UIColor blueColor];
            customButton.titleLabel.textColor = [UIColor whiteColor];
        }
        break;
        case CustomButtonProceed: {
            customButton.backgroundColor = [UIColor redColor];
            customButton.titleLabel.textColor = [UIColor whiteColor];
        }
            break;
        default:
            break;
    }
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitle:title forState:UIControlStateSelected];
    
    CGSize size =
        [title sizeWithFont:[UIFont boldSystemFontOfSize:14]
                   forWidth:300
              lineBreakMode:NSLineBreakByWordWrapping];
    
    customButton.frame = CGRectMake(0, 0, size.width, size.height);
    return customButton;
}


- (void)addTarget:(id)target :(SEL)selector {
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
