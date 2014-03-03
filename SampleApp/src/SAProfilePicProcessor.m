//
//  SAProfilePicProcessor.m
//  SampleApp
//
//  Created by Astha on 3/1/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import "SAProfilePicProcessor.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SAFriend.h"


@implementation SAProfilePicProcessor

- (id)initWithFriendsList:(NSArray *)frnds {
    if (self = [super init]) {
        self.frnds = frnds;
    }
    backgroundQueue = dispatch_queue_create("com.astha.sample_app_astha_trivedi.bgqueue", NULL);
    return self;
}

- (void)fetchProfilePics {
    dispatch_async(backgroundQueue, ^{
        [self getProfilePicsForFriends];
    });
}


- (void)getProfilePicsForFriends {
    for (SAFriend *frnd in self.frnds) {
        NSString *url =
            [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",frnd.frndID];
        NSLog(@"Accesing image for %@: with URL: %@",frnd.name, url);
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        if (imageData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.delegate &&
                    [self.delegate respondsToSelector:@selector(updateWithProfilePics:forFriend:atIndexPath:)])
                {
                    NSIndexPath *indexPath =
                        [NSIndexPath indexPathForRow:[self.frnds indexOfObject:frnd] inSection:0];
                    [self.delegate updateWithProfilePics:[UIImage imageWithData:imageData]
                                               forFriend:frnd.frndID
                                             atIndexPath:indexPath];
                }
            });
        }
    }
}

@end
