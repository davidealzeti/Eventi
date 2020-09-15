//
//  MDProgrammedEventViewController.h
//  Eventi
//
//  Created by Davide Alzeti on 15/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDEvent.h"

@protocol MDPastEventProtocol <NSObject>

@required
- (void)sendPastEvent:(MDEvent *)event;

@end

@interface MDProgrammedEventViewController : UIViewController

@property (strong, nonatomic) id delegate;

@property (strong, nonatomic) MDEvent *programmedEvent;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

@end
