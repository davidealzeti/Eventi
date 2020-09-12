//
//  MDEvent.m
//  Eventi
//
//  Created by Davide Alzeti on 12/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "MDEvent.h"

@interface MDEvent ()

- (void)print;

@end

@implementation MDEvent

@synthesize name = _name;
@synthesize category = _category;
@synthesize creationDate = _creationDate;
@synthesize dueDate = _dueDate;
@synthesize notes = _notes;

- (instancetype)initWithName:(NSString *)name
           belongsToCategory:(NSString *)category wasCreatedOn:(NSDate *)creationDate
                     isDueTo:(NSDate *)dueDate
             additionalNotes:(NSString *)notes{
    if (self = [super init]) {
        _name = name;
        _category = category;
        _creationDate = creationDate;
        _dueDate = dueDate;
        _notes = notes;
    }
    return self;
}

- (instancetype)init{
    return [self initWithName:@""
            belongsToCategory:@""
                 wasCreatedOn:[NSDate date]
                      isDueTo:[NSDate date]
              additionalNotes:@""];
}

- (void)print{
    NSLog(@"Name: %@ Category: %@ \nCreation: %@ \nDueDate: %@", _name, _category, _creationDate, _dueDate);
}

@end
