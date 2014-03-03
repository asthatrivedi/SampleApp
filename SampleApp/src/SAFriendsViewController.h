//
//  SAFriendsViewController.h
//  SampleApp
//
//  Created by Astha on 3/1/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAProfilePicProcessor.h"
#import "SALoadingView.h"

@interface SAFriendsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,
                                                                            SAProfilePicProcessorDelegate,SALoadingViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong, readwrite) NSArray *friendsList;
@property (nonatomic, strong, readwrite) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@end
