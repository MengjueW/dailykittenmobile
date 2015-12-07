//
//  HomepageTableViewController.h
//  DailyKitten
//
//  Created by Mengjue Wang on 11/30/15.
//  Copyright © 2015 Mengjue Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleTableViewCell.h"
#import "HomepageTableViewCell.h"
#import "DKClient.h"
#import "InformationViewController.h"

@interface HomepageTableViewController : UITableViewController <DKClientDelegate>

@property NSString *APIAddr;
@property (nonatomic) DKClient *client;

@end
