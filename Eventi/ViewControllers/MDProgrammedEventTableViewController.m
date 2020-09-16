//
//  MDProgrammedEventTableViewController.m
//  Eventi
//
//  Created by Davide Alzeti on 13/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "MDProgrammedEventTableViewController.h"
#import "CreateEventViewController.h"
#import "MDProgrammedEventViewController.h"
#import "MDPastEventTableViewController.h"
#import "MDEvent.h"
#define DEBUGLOG(a) NSLog(@"%s: %@", __FUNCTION__, a)
#define SECTIONS_NUM 1

@interface MDProgrammedEventTableViewController () <MDNewEventProtocol>

@end

@implementation MDProgrammedEventTableViewController

@synthesize programmedEvents = _programmedEvents;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.programmedEvents = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeEvent:) name:@"removingProgrammedEvent" object:nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return SECTIONS_NUM;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.programmedEvents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProgrammedEventCell" forIndexPath:indexPath];
    
    DEBUGLOG(@"Cell configuration started");
    
    // Configure the cell...
    if ([self.programmedEvents[indexPath.row] isKindOfClass:[MDEvent class]]) {
        MDEvent *programmedEvent = self.programmedEvents[indexPath.row];
        
        cell.textLabel.text = programmedEvent.name;
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


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createNewEventSegue"]) {
        DEBUGLOG(@"Create new event segue");
        CreateEventViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"showProgrammedEventSegue"]){
        
        DEBUGLOG(@"Show programmed event segue");
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        MDProgrammedEventViewController *vc = segue.destinationViewController;
        if ([self.programmedEvents[indexPath.row] isKindOfClass:[MDEvent class]]) {
            vc.programmedEvent = (MDEvent *)self.programmedEvents[indexPath.row];
        }
    }
}


- (void)sendNewEvent:(MDEvent *)event{
    DEBUGLOG(@"New event added to events list");
    [event print];
    [self.programmedEvents addObject:event];
    [self.tableView reloadData];
}

- (void)removeEvent:(NSNotification *)notification{
    for (MDEvent *event in self.programmedEvents) {
        if ([event.name isEqualToString:notification.object]) {
            [self.programmedEvents removeObject:event];
            [self.tableView reloadData];
        }
    }
}

- (void)sortEventsByDueDate{
    [self.programmedEvents sortUsingComparator:^(MDEvent *event1, MDEvent *event2){
        if ([event1.dueDate compare:event2.dueDate]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else return (NSComparisonResult)NSOrderedAscending;
    }];
    
    [self.tableView reloadData];
}

- (void)sortEventsByCreationDate{
    [self.programmedEvents sortUsingComparator:^(MDEvent *event1, MDEvent *event2){
        if ([event1.creationDate compare:event2.creationDate]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else return (NSComparisonResult)NSOrderedAscending;
    }];
    
    [self.tableView reloadData];
}

- (void)sortEventsByCategory{
    [self.programmedEvents sortUsingComparator:^(MDEvent *event1, MDEvent *event2){
        if ([event1.category compare:event2.category]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else if ([event2.category compare:event1.category]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else return (NSComparisonResult)NSOrderedSame;
    }];
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"events size: %d", self.programmedEvents.count);
}

@end
