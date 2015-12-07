//
//  DetailViewController.h
//  DailyKitten
//
//  Created by Mengjue Wang on 12/1/15.
//  Copyright © 2015 Mengjue Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *DKWebView;
@property NSString *newsUrl;

@end
