//
//  MDPastEventViewController.m
//  Eventi
//
//  Created by Davide Alzeti on 17/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "MDPastEventViewController.h"
#define DEBUGLOG(a) NSLog(@"%s: %@", __FUNCTION__, a)

@interface MDPastEventViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *showPastEventScrollView;

@end

@implementation MDPastEventViewController

@synthesize pastEvent, nameLabel, categoryLabel, dueDateLabel, notesLabel, showPastEventScrollView, delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLabels];
    
}

- (void)setupLabels{
    self.nameLabel.text = self.pastEvent.name;
    self.categoryLabel.text = self.pastEvent.category;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.pastEvent.dueDate];
    
    self.dueDateLabel.text = [NSString stringWithFormat:@"%d/%d/%d", [components day], [components month], [components year]];
    
    self.notesLabel.text = self.pastEvent.notes;
}

- (IBAction)deleteEvent:(id)sender {
    DEBUGLOG(@"Button pressed: delete past event");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removingPastEvent" object:self.pastEvent];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
