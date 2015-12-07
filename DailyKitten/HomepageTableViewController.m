//
//  HomepageTableViewController.m
//  DailyKitten
//
//  Created by Mengjue Wang on 11/30/15.
//  Copyright © 2015 Mengjue Wang. All rights reserved.
//

#import "HomepageTableViewController.h"

@interface HomepageTableViewController ()
@property NSArray *data;
@property NSInteger row;

@end

@implementation HomepageTableViewController
- (BOOL)shouldTimeOut:(int)depth forAPIAddr:(NSString *)APIAddr {
    return NO;
}
    
- (void)receiveResponseObject:(id)responseObject forAPIAddr:(NSString *)APIAddr {
    NSDictionary *respData = (NSDictionary *)responseObject;
    NSArray *cats = [respData objectForKey:@"cats"];
    NSMutableArray *tempData = [NSMutableArray array];
    for (int i = 0; i < [cats count]; i++) {
        NSMutableDictionary *item = [NSMutableDictionary dictionary];
        [item setObject:[cats[i] objectForKey:@"name"] forKey:@"kittenName"];
        [item setObject:[cats[i] objectForKey:@"profile"] forKey:@"kittenImage"];
        [item setObject:[cats[i] objectForKey:@"age"] forKey:@"kittenAge"];
        [item setObject:[cats[i] objectForKey:@"sex"] forKey:@"kittenSex"];
        [item setObject:[cats[i] objectForKey:@"description"] forKey:@"kittenDescription"];
        
        double currentTime = [[NSDate date] timeIntervalSince1970];
        NSNumber *updateTime = [cats[i] objectForKey:@"updata_unix"];
        double deltaTime = currentTime - [updateTime intValue];
        NSString *deltaTimeString;
        if (deltaTime < 0) {
            deltaTimeString = @"Just now";
        } else if (deltaTime < 60) {
            deltaTimeString = [NSString stringWithFormat:@"%.0f Seconds Ago", deltaTime];
        } else if (deltaTime < 60 * 60) {
            deltaTimeString = [NSString stringWithFormat:@"%.0f Minutes Ago", deltaTime / 60];
        } else if (deltaTime < 60 * 60 * 24) {
            deltaTimeString = [NSString stringWithFormat:@"%.0f Hours Ago", deltaTime / 60 / 60];
        } else if (deltaTime < 60 * 60 * 24 * 30) {
            deltaTimeString = [NSString stringWithFormat:@"%.0f Days Ago", deltaTime / 60 / 60 / 24];
        } else if (deltaTime < 60 * 60 * 24 * 365) {
            deltaTimeString = [NSString stringWithFormat:@"%.0f Months Ago", deltaTime / 60 / 60 / 24 / 30];
        } else {
            deltaTimeString = [NSString stringWithFormat:@"%.0fYears Ago", deltaTime / 60 / 60 / 24 / 365];
        }
        
        [item setObject:deltaTimeString forKey:@"kittenTime"];
        
        [tempData addObject:item];
        
    }
    self.data = [tempData copy];
    [self.tableView reloadData];
}

- (void)generateTestData {
    NSMutableArray *tempData = [NSMutableArray array];
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    [item setObject:@"Kitty" forKey:@"kittenName"];
    [item setObject:@"http://i.telegraph.co.uk/multimedia/archive/02830/cat_2830677b.jpg" forKey:@"kittenImage"];
    
    [item setObject:[NSNumber numberWithInt:1] forKey:@"kittenAge"];
    [item setObject:@"male" forKey:@"kittenSex"];
    [item setObject:@"abc" forKey:@"kittenDescription"];
    
    [tempData addObject:[item copy]];
    [item setObject:@"Kuroneko" forKey:@"kittenName"];
    [item setObject:@"http://theheightsanimalhospital.com/clients/15389/images/playful-kitten-6683.jpg" forKey:@"kittenImage"];
    [item setObject:[NSNumber numberWithInt:3] forKey:@"kittenAge"];
    [item setObject:@"male" forKey:@"kittenSex"];
    [item setObject:@"abc" forKey:@"kittenDescription"];
    
    [tempData addObject:[item copy]];
    
    self.data = [tempData copy];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.client = [[DKClient alloc] init];
    self.client.delegate = self;
    self.APIAddr = @"http://daily-kitten-env-uyjmfnh2t5.elasticbeanstalk.com/api/cats";
    [self.client startRequest:self.APIAddr];
    
    // [self generateTestData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    HomepageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homepageTableViewCell" forIndexPath:indexPath];
    
    cell.kittenNameLabel.text = [self.data[indexPath.row - 1] objectForKey:@"kittenName"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.data[indexPath.row - 1] objectForKey:@"kittenImage"]]];
    cell.kittenImageView.image = [UIImage imageWithData:imageData];
    cell.kittenTimeLabel.text = [self.data[indexPath.row - 1] objectForKey:@"kittenTime"];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return 50;
    else
        return 128;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0) {
        //self.newsUrl = [[self.data objectAtIndex:indexPath.row] objectForKey:@"newUrl"];
        self.row = indexPath.row;
        [self performSegueWithIdentifier:@"showInformation" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showInformation"]) {
        InformationViewController *vcToPushTo = segue.destinationViewController;
        vcToPushTo.data = self.data[self.row - 1];
    }
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
