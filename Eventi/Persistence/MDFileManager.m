//
//  MDFileManager.m
//  Eventi
//
//  Created by Davide Alzeti on 17/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "MDFileManager.h"

@implementation MDFileManager

@synthesize fileManagerInstance = _fileManagerInstance, programmedEventsArray = _programmedEventsArray, pastEventsArray = _pastEventsArray;

- (instancetype)init{
    if ([super init]) {
        _fileManagerInstance = [NSFileManager defaultManager];
        _programmedEventsArray = [[NSMutableArray alloc] init];
        _pastEventsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)saveProgrammedEventsToFile:(NSMutableArray *)programmedEvents{
    [self.programmedEventsArray removeAllObjects];
    
    for (MDEvent *event in programmedEvents) {
        NSMutableDictionary *dict = [self convertToSerializableDictionary:event];
        [self.programmedEventsArray addObject:dict];
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.programmedEventsArray options:0 error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSURL *documentDirectory = [self.fileManagerInstance URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *saveURL = [documentDirectory URLByAppendingPathComponent:[NSString stringWithFormat:@"programmati.json"]];
    
    [jsonString writeToURL:saveURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"Programmed events saved to json file.");
}

- (void)savePastEventsToFile:(NSMutableArray *)pastEvents{
    [self.pastEventsArray removeAllObjects];
    
    for (MDEvent *event in pastEvents) {
        NSMutableDictionary *dict = [self convertToSerializableDictionary:event];
        [self.pastEventsArray addObject:dict];
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.pastEventsArray options:0 error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSURL *documentDirectory = [self.fileManagerInstance URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *saveURL = [documentDirectory URLByAppendingPathComponent:[NSString stringWithFormat:@"passati.json"]];
    
    [jsonString writeToURL:saveURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"Past events saved to json file.");
}

- (NSMutableArray *)loadProgrammedEvents{
    
    NSURL *documentDirectory = [self.fileManagerInstance URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    NSURL *pathToFile = [documentDirectory URLByAppendingPathComponent:@"programmati.json"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:pathToFile];
    
    NSError *error;
    if(jsonData != nil){
        id programmedEventsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if ([programmedEventsArray isKindOfClass:[NSMutableArray class]]) {
            for (NSMutableDictionary *eventDictionary in programmedEventsArray) {
                [self.programmedEventsArray addObject:[self deserializeDictionaryToEvent:eventDictionary]];
            }
            NSLog(@"Programmed events loaded");
        }
    }
    
    return self.programmedEventsArray;
}

- (NSMutableArray *)loadPastEvents{
    
    NSURL *documentDirectory = [self.fileManagerInstance URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    NSURL *pathToFile = [documentDirectory URLByAppendingPathComponent:@"passati.json"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:pathToFile];
    
    NSError *error;
    if(jsonData != nil){
        id pastEventsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if ([pastEventsArray isKindOfClass:[NSMutableArray class]]) {
            for (NSMutableDictionary *eventDictionary in pastEventsArray) {
                [self.pastEventsArray addObject:[self deserializeDictionaryToEvent:eventDictionary]];
            }
            NSLog(@"Past events loaded");
        }
    }
    
    return self.pastEventsArray;
}

- (NSMutableDictionary *)convertToSerializableDictionary:(MDEvent *)event{
    
    NSDateComponents *creationDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:event.creationDate];
    
    NSDateComponents *dueDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:event.dueDate];
    
    NSNumber *isNotificationActiveNumber = [[NSNumber alloc] initWithBool:event.isNotificationActive];
    
    NSMutableDictionary *eventDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:event.name, @"name", event.category, @"category", [[NSNumber alloc] initWithInteger:[creationDateComponents day]], @"creationDateDay", [[NSNumber alloc] initWithInteger:[creationDateComponents month]], @"creationDateMonth", [[NSNumber alloc] initWithInteger:[creationDateComponents year]], @"creationeDateYear" ,[[NSNumber alloc] initWithInteger:[dueDateComponents day]], @"dueDateDay", [[NSNumber alloc] initWithInteger:[dueDateComponents month]], @"dueDateMonth", [[NSNumber alloc] initWithInteger:[dueDateComponents year]], @"dueDateYear", event.notes, @"notes", isNotificationActiveNumber, @"isNotificationActive" , nil];
    
    NSLog(@"Serialization of: %@ completed", event.name);
    
    return eventDictionary;
}

- (MDEvent *)deserializeDictionaryToEvent:(NSMutableDictionary *)eventsDictionary{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *creationDateComponents = [[NSDateComponents alloc] init];
    NSDateComponents *dueDateComponents = [[NSDateComponents alloc] init];
    
    NSNumber *creationDateDay = [eventsDictionary valueForKey:@"creationDateDay"];
    NSNumber *creationDateMonth = [eventsDictionary valueForKey:@"creationDateMonth"];
    NSNumber *creationDateYear = [eventsDictionary valueForKey:@"creationDateYear"];
    NSNumber *dueDateDay = [eventsDictionary valueForKey:@"dueDateDay"];
    NSNumber *dueDateMonth = [eventsDictionary valueForKey:@"dueDateMonth"];
    NSNumber *dueDateYear = [eventsDictionary valueForKey:@"dueDateYear"];
    
    [creationDateComponents setDay:[creationDateDay intValue]];
    [creationDateComponents setMonth:[creationDateMonth intValue]];
    [creationDateComponents setYear:[creationDateYear intValue]];
    [dueDateComponents setDay:[dueDateDay intValue]];
    [dueDateComponents setMonth:[dueDateMonth intValue]];
    [dueDateComponents setYear:[dueDateYear intValue]];
    
    NSDate *creationDate = [calendar dateFromComponents:creationDateComponents];
    NSDate *dueDate = [calendar dateFromComponents:dueDateComponents];
    
    NSString *name = [[NSString alloc] initWithString:[eventsDictionary valueForKey:@"name"]];
    NSString *category = [[NSString alloc] initWithString:[eventsDictionary valueForKey:@"category"]];
    NSString *notes = [[NSString alloc] initWithString:[eventsDictionary valueForKey:@"notes"]];
    
    NSNumber *num = [eventsDictionary valueForKey:@"isNotificationActive"];
    BOOL isNotificationActive = [num boolValue];
    
    MDEvent *event = [[MDEvent alloc] initWithName:name belongsToCategory:category wasCreatedOn:creationDate isDueTo:dueDate additionalNotes:notes getNotification:isNotificationActive];
    
    NSLog(@"Event: %@ deserialized", event.name);
    [event print];
    
    return event;
}

@end
