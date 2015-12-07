//
//  DKClientDelegate.h
//  DailyKitten
//
//  Created by Mengjue Wang on 12/1/15.
//  Copyright © 2015 Mengjue Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DKClientDelegate <NSObject>

- (void)receiveResponseObject:(id)responseObject forAPIAddr:(NSString *)APIAddr;
- (BOOL)shouldTimeOut:(int)depth forAPIAddr:(NSString *)APIAddr;

@end