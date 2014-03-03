//
//  SAFriend.m
//  SampleApp
//
//  Created by Astha on 3/2/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import "SAFriend.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation SAFriend


- (id)initWithFriend:(NSDictionary <FBGraphUser> *)inFrnd {
    if (self = [super init]) {
        self.name = inFrnd.name;
        self.frndID = inFrnd.id;
    }
    return self;
}



@end
