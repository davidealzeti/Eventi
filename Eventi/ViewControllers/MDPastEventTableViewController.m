//
//  MDPastEventTableViewController.m
//  Eventi
//
//  Created by Davide Alzeti on 13/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "MDPastEventTableViewController.h"
#import "MDPastEventViewController.h"
#import "MDFileManager.h"
#define DEBUGLOG(a) NSLog(@"%s: %@", __FUNCTION__, a)
#define SECTIONS_NUM 1

@interface MDPastEventTableViewController ()

@property (strong, nonatomic) MDFileManager *fm;

@end

@implementation MDPastEventTableViewController

@synthesize pastEvents;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.fm = [[MDFileManager alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendPastEvent:) name:@"sendingPastEvent" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeEvent:) name:@"removingPastEvent" object:nil];
    
    [self loadPastEvent];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return SECTIONS_NUM;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.pastEvents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PastEventCell"];
    
    // Configure the cell...
    if ([self.pastEvents[indexPath.row] isKindOfClass:[MDEvent class]]) {
        
        MDEvent *pastEvent = self.pastEvents[indexPath.row];
        
        cell.nameLabel.textColor = [UIColor redColor];
        
        cell.nameLabel.text = pastEvent.name;
        cell.categoryLabel.text = pastEvent.category;
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:pastEvent.dueDate];
        
        cell.dueDateLabel.text = [NSString stringWithFormat:@"%d/%d/%d", [components day], [components month], [components year]];
        
        NSLog(@"Data: %@",pastEvent.dueDate);
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
    if ([segue.identifier isEqualToString:@"showPastEventSegue"]){
        
        DEBUGLOG(@"Show past event segue");
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        MDPastEventViewController *vc = segue.destinationViewController;
        if ([self.pastEvents[indexPath.row] isKindOfClass:[MDEvent class]]) {
            vc.pastEvent = (MDEvent *)self.pastEvents[indexPath.row];
        }
    }
}

- (void)loadPastEvent{
    self.pastEvents = [[NSMutableArray alloc] initWithArray:[self.fm loadPastEvents]];
    
    [self.tableView reloadData];
}


- (void)sendPastEvent:(NSNotification *)notification{
    NSLog(@"Received notification: %@", notification.name);
    if ([notification.object isKindOfClass:[MDEvent class]]) {
        DEBUGLOG(@"Past event added to events list");
        MDEvent *event = notification.object;
        [event print];
        [self.pastEvents addObject:event];
        [self.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePast" object:self.pastEvents];
    }
}

- (void)removeEvent:(NSNotification *)notification{
    [self.pastEvents removeObject:notification.object];
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePast" object:self.pastEvents];
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"past events size: %d", self.pastEvents.count);
}

- (void)viewDidDisappear:(BOOL)animated{
}

@end
