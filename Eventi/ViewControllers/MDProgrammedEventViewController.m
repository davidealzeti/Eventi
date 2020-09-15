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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setupLabels{
    self.nameLabel.text = self.programmedEvent.name;
    self.categoryLabel.text = self.programmedEvent.category;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.programmedEvent.dueDate];
    
    self.dueDateLabel.text = [NSString stringWithFormat:@"%d/%d/%d", [components day], [components month], [components year]];
    
    self.notesLabel.text = self.programmedEvent.notes;
}

- (IBAction)createPastEvent:(id)sender {
    DEBUGLOG(@"Button pressed: new event created");
    
    [self.delegate sendPastEvent:programmedEvent];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
