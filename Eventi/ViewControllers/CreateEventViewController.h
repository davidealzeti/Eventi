//
//  CreateEventViewController.h
//  Eventi
//
//  Created by Davide Alzeti on 14/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDEvent.h"

@protocol MDNewEventProtocol <NSObject>

@required
- (void)sendNewEvent:(MDEvent *)event;

@end

@interface CreateEventViewController : UIViewController

@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) MDEvent *createdEvent;

@end
