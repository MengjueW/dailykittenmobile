//
//  InformationViewController.m
//  DailyKitten
//
//  Created by Mengjue Wang on 12/1/15.
//  Copyright © 2015 Mengjue Wang. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.data objectForKey:@"kittenImage"]]];
    self.bigCatImageView.image = [UIImage imageWithData:imageData];
    self.catName.text = [self.data objectForKey:@"kittenName"];
    self.catAge.text = [[self.data objectForKey:@"kittenAge"] stringValue];
    self.catSex.text = [self.data objectForKey:@"kittenSex"];
    self.catDescription.text = [self.data objectForKey:@"kittenDescription"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
