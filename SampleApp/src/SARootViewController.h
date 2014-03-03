//
//  SARootViewController.h
//  SampleApp
//
//  Created by Astha on 3/1/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SARootViewController : UIViewController

@property (nonatomic, strong, readwrite)IBOutlet UIButton *loginButton;
@property (nonatomic, strong, readwrite)IBOutlet UIButton *friendsButton;


- (IBAction)performLogin:(id)sender;

@end
