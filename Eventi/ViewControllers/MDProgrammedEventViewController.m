//
//  MDProgrammedEventViewController.m
//  Eventi
//
//  Created by Davide Alzeti on 15/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "MDProgrammedEventViewController.h"
#define DEBUGLOG(a) NSLog(@"%s: %@", __FUNCTION__, a)

@interface MDProgrammedEventViewController ()


@property (weak, nonatomic) IBOutlet UIScrollView *showProgrammedEventScrollView;

- (void)setupLabels;

@end

@implementation MDProgrammedEventViewController

@synthesize programmedEvent, nameLabel, categoryLabel, dueDateLabel, notesLabel, showProgrammedEventScrollView, delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLabels];
    
}

- (void)setupLabels{
    self.nameLabel.text = self.programmedEvent.name;
    self.categoryLabel.text = self.programmedEvent.category;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.programmedEvent.dueDate];
    
    self.dueDateLabel.text = [NSString stringWithFormat:@"%d/%d/%d", [components day], [components month], [components year]];
    
    self.notesLabel.text = self.programmedEvent.notes;
}

- (IBAction)createPastEvent:(id)sender {
    DEBUGLOG(@"Button pressed: past event created");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendingPastEvent" object:self.programmedEvent];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removingProgrammedEvent" object:self.programmedEvent];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteEvent:(id)sender {
    DEBUGLOG(@"Button pressed: delete programmed event");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removingProgrammedEvent" object:self.programmedEvent];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
