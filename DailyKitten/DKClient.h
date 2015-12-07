//
//  DKClient.h
//  DailyKitten
//
//  Created by Mengjue Wang on 12/1/15.
//  Copyright © 2015 Mengjue Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKClientDelegate.h"

@interface DKClient : NSObject
@property (retain) id <DKClientDelegate> delegate;
- (void)startRequest:(NSString *)APIAddr;

@end
