//
//  DKClient.m
//  DailyKitten
//
//  Created by Mengjue Wang on 12/1/15.
//  Copyright © 2015 Mengjue Wang. All rights reserved.
//

#import "DKClient.h"
#import <AFNetworking.h>

@implementation DKClient
- (void)startRequest:(NSString *)APIAddr {
    [self startRequest:APIAddr forDepth:0];
}

- (void)startRequest:(NSString *)APIAddr forDepth:(int)dep{
    if ([self.delegate shouldTimeOut:dep forAPIAddr:APIAddr]) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:APIAddr];
    NSMutableURLRequest *request = [[NSURLRequest requestWithURL:url] mutableCopy];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       [self.delegate receiveResponseObject:responseObject forAPIAddr:APIAddr];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self startRequest:APIAddr forDepth:dep + 1];
        });
    }];
    
    [operation start];
}

@end