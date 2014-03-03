//
//  SAFriendsViewController.m
//  SampleApp
//
//  Created by Astha on 3/1/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import "SAFriendsViewController.h"
#import "SAFriendsDetailViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SALoadingView.h"
#import "SAFriend.h"


@interface SAFriendsViewController ()


@property (nonatomic, strong, readwrite) SALoadingView *loadingView;
@property (nonatomic, strong, readwrite) NSMutableArray *results;


@end

@implementation SAFriendsViewController


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
    self.navigationItem.hidesBackButton = YES;
    SAProfilePicProcessor *processor = [[SAProfilePicProcessor alloc] initWithFriendsList:self.friendsList];
    processor.delegate = self;
    [processor fetchProfilePics];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name beginswith[c] %@", searchText];
    self.results = [[self.friendsList filteredArrayUsingPredicate:resultPredicate] mutableCopy];
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    SAFriend* friend = nil;
    if (tableView == self.tableView) {
        friend = (SAFriend *)[self.friendsList objectAtIndex:indexPath.row];
        cell.textLabel.text = friend.name;
        cell.imageView.image = friend.profilePic;
    }
    else {
        friend = (SAFriend *)[self.results objectAtIndex:indexPath.row];
        cell.imageView.image = friend.profilePic;
    }
    cell.textLabel.text = friend.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if  (tableView == self.tableView) {
        return [self.friendsList count];
    }
    else {
        return [self.results count];
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"pushDetailView"]) {
        SAFriendsDetailViewController *friendsDetailView =
            (SAFriendsDetailViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = nil;
        SAFriend *frnd = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            frnd = [self.results objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            frnd = [self.friendsList objectAtIndex:indexPath.row];
        }
        friendsDetailView.name = frnd.name;
        friendsDetailView.profilePic = frnd.profilePic;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"pushDetailView" sender:self];
}


- (void)updateWithProfilePics:(UIImage *)profilePic forFriend:(NSString *)frndID atIndexPath:(NSIndexPath *) indexPath {
    for (SAFriend * inFrnd in self.friendsList) {
        if ([inFrnd.frndID isEqualToString:frndID]) {
            inFrnd.profilePic = profilePic;
            break;
        }
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationRight];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
