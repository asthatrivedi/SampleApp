//
//  SAProfilePicProcessor.h
//  SampleApp
//
//  Created by Astha on 3/1/14.
//  Copyright (c) 2014 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SAProfilePicProcessorDelegate  <NSObject>

- (void)updateWithProfilePics:(UIImage *)profilePic forFriend:(NSString *)frndID atIndexPath:(NSIndexPath *) indexPath;

@end

@interface SAProfilePicProcessor : NSObject {

    dispatch_queue_t backgroundQueue;
    
}

@property (nonatomic, strong, readwrite) NSArray *frnds;
@property (nonatomic, assign, readwrite) id<SAProfilePicProcessorDelegate> delegate;

- (id)initWithFriendsList:(NSArray *)frnds;
- (void)fetchProfilePics;

@end
