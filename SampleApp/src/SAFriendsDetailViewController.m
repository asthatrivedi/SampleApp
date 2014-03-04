//
//  SAFriendsDetailViewController.m
//  SampleApp
//
//  Created by Astha on 3/2/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import "SAFriendsDetailViewController.h"

@interface SAFriendsDetailViewController ()

@end

@implementation SAFriendsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.profilePicView.image = self.profilePic;
    self.profilePicView.layer.cornerRadius = 10.0f;
    self.profilePicView.layer.masksToBounds = YES;
    self.profilePicView.layer.borderColor = [UIColor blackColor].CGColor;
    self.profilePicView.layer.borderWidth = 4.0f;
    self.profilePicView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    self.title = self.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
