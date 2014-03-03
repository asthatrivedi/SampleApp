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
    self.title = self.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
