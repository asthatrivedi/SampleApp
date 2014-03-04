//
//  SARootViewController.m
//  SampleApp
//
//  Created by Astha on 3/1/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import "SAAppDelegate.h"
#import "SARootViewController.h"
#import "SAFriendsViewController.h"
#import "SAFriend.h"


@interface SARootViewController ()

@property (nonatomic, strong, readwrite) __block NSMutableArray *friendsList;

@end


@implementation SARootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.friendsButton.enabled = NO;
    [self customiseButtons];
}


- (void)customiseButtons {
    self.loginButton.layer.backgroundColor = [UIColor colorWithRed:72.f/255.f
                                                             green:98.f/255.f
                                                              blue:167.f/255.f
                                                             alpha:1.0f].CGColor;
    self.loginButton.layer.cornerRadius = 8.0f;
    self.loginButton.layer.shadowColor = [UIColor grayColor].CGColor;
    self.loginButton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}


- (IBAction)performLogin:(id)sender {
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for basic_info permissions when opening a session
        __weak SARootViewController *weakSelf = self;
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             SAAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
             weakSelf.loginButton.enabled = NO;
             weakSelf.friendsButton.enabled = YES;
             [weakSelf requestForFriendsList];
         }];
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"push"]) {
        
        FBRequest* friendsRequest = [FBRequest requestForMyFriends];
        __weak SARootViewController *weakSelf = self;
        [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                      NSMutableDictionary* result,
                                                      NSError *error) {
            if (error) {
                NSLog(@"ERROR: %@",error.userInfo);
            }
            NSArray *frnds = [result objectForKey:@"data"];
            NSLog(@"Found: %lu friends", (unsigned long)[frnds count]);
            [weakSelf updateFriendsList:frnds];
        }];
    }
    return YES;
}


- (void)requestForFriendsList {
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    __weak SARootViewController *weakSelf = self;
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSMutableDictionary* result,
                                                  NSError *error) {
        if (error) {
            NSLog(@"ERROR: %@",error.userInfo);
        }
        else {
            NSArray *frnds = [result objectForKey:@"data"];
            NSLog(@"Found: %lu friends", (unsigned long)[frnds count]);
            [weakSelf updateFriendsList:frnds];
            [weakSelf performSegueWithIdentifier:@"push" sender:self];
        }
    }];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"push"]) {
        SAFriendsViewController *friendsView =
            (SAFriendsViewController *)[segue destinationViewController];
        friendsView.friendsList = [self.friendsList sortedArrayUsingComparator:
                                   ^(NSDictionary<FBGraphUser> *firstObject, NSDictionary<FBGraphUser> *secondObject) {
            return [firstObject.name compare:secondObject.name];
        }];
    }
}


- (void)updateFriendsList:(NSArray *)frnds {
    self.friendsList =
        (NSMutableArray *)[frnds sortedArrayUsingComparator:^(NSDictionary <FBGraphUser> *frnd1, NSDictionary <FBGraphUser> *frnd2) {
        return [frnd1.name compare:frnd2.name];
    }];
    NSMutableArray *frndArray = [NSMutableArray array];
    for (NSDictionary <FBGraphUser> *frnd in self.friendsList) {
        SAFriend *inFrnd = [[SAFriend alloc] initWithFriend:frnd];
        [frndArray addObject:inFrnd];
    }
    self.friendsList = nil;
    self.friendsList = frndArray;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
