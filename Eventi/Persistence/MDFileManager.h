//
//  MDFileManager.h
//  Eventi
//
//  Created by Davide Alzeti on 17/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDEvent.h"

@interface MDFileManager : NSObject

@property (strong, nonatomic, readonly) NSFileManager *fileManagerInstance;

@property (strong, nonatomic) NSMutableArray *programmedEventsArray;
@property (strong, nonatomic) NSMutableArray *pastEventsArray;

- (instancetype)init;

- (void)saveProgrammedEventsToFile:(NSMutableArray *)programmedEvents;

- (void)savePastEventsToFile:(NSMutableArray *)pastEvents;

- (NSMutableArray *)loadProgrammedEvents;

- (NSMutableArray *)loadPastEvents;

- (NSMutableDictionary *)convertToSerializableDictionary:(MDEvent *)event;

- (MDEvent *)deserializeDictionaryToEvent:(NSMutableDictionary *)eventsDictionary;

@end
