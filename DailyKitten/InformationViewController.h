//
//  InformationViewController.h
//  DailyKitten
//
//  Created by Mengjue Wang on 12/1/15.
//  Copyright © 2015 Mengjue Wang. All rights reserved.
//

#import "ViewController.h"

@interface InformationViewController : ViewController
@property (weak, nonatomic) IBOutlet UIImageView *bigCatImageView;
@property (weak, nonatomic) IBOutlet UILabel *catName;
@property (weak, nonatomic) IBOutlet UILabel *catAge;
@property (weak, nonatomic) IBOutlet UILabel *catSex;
@property (weak, nonatomic) IBOutlet UILabel *catDescription;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@property NSDictionary *data;

@end
