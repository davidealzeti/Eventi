//
//  MDPastEventTableViewController.m
//  Eventi
//
//  Created by Davide Alzeti on 13/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "MDPastEventTableViewController.h"
#define DEBUGLOG(a) NSLog(@"%s: %@", __FUNCTION__, a)
#define SECTIONS_NUM 1

@interface MDPastEventTableViewController ()

@end

@implementation MDPastEventTableViewController

@synthesize pastEvents;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.pastEvents = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendPastEvent:) name:@"sendingPastEvent" object:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return SECTIONS_NUM;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.pastEvents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PastEventCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if ([self.pastEvents[indexPath.row] isKindOfClass:[MDEvent class]]) {
        MDEvent *pastEvent = self.pastEvents[indexPath.row];
        
        cell.textLabel.text = pastEvent.name;
    }
    
    return cell;
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




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (void)sendPastEvent:(NSNotification *)notification{
    NSLog(@"Received notification: %@", notification.name);
    if ([notification.object isKindOfClass:[MDEvent class]]) {
        DEBUGLOG(@"Past event added to events list");
        MDEvent *event = notification.object;
        [event print];
        [self.pastEvents addObject:event];
        [self.tableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"past events size: %d", self.pastEvents.count);
}

@end
