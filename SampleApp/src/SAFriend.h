//
//  SAFriend.h
//  SampleApp
//
//  Created by Astha on 3/2/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>


@interface SAFriend : NSObject

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *frndID;
@property (nonatomic, strong, readwrite) UIImage *profilePic;


- (id)initWithFriend:(NSDictionary <FBGraphUser> *)inFrnd;


@end
