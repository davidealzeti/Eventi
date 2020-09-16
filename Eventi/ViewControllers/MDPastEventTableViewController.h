//
//  MDPastEventTableViewController.h
//  Eventi
//
//  Created by Davide Alzeti on 13/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDEvent.h"
#import "MDProgrammedEventViewController.h"

@interface MDPastEventTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *pastEvents;

- (void)sendPastEvent:(NSNotification *)notification;

@end
