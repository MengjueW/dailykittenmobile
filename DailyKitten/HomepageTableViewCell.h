//
//  HomepageTableViewCell.h
//  DailyKitten
//
//  Created by Mengjue Wang on 11/30/15.
//  Copyright © 2015 Mengjue Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomepageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *kittenImageView;
@property (weak, nonatomic) IBOutlet UILabel *kittenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *kittenTimeLabel;

@end
