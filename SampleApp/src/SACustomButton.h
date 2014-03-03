//
//  SACustomButton.h
//  SampleApp
//
//  Created by Astha on 3/1/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    CustomButtonTypeLogin = 0,
    CustomButtonProceed,
}CustomButtonType;


@interface SACustomButton : UIButton


+ (SACustomButton *)createButtonForType:(CustomButtonType)buttonType title:(NSString *)title;


@end
