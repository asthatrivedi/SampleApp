//
//  SAFriendsDetailViewController.h
//  SampleApp
//
//  Created by Astha on 3/2/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAFriendsDetailViewController : UIViewController

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) UIImage *profilePic;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicView;

@end
