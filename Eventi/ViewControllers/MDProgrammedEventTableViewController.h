//
//  MDProgrammedEventTableViewController.h
//  Eventi
//
//  Created by Davide Alzeti on 13/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDProgrammedEventTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *programmedEvents;

@end
