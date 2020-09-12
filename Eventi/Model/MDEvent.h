//
//  MDEvent.h
//  Eventi
//
//  Created by Davide Alzeti on 12/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDEvent : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic, readonly) NSDate *creationDate;
@property (strong, nonatomic) NSDate *dueDate;
@property (strong, nonatomic) NSString *notes;

- (instancetype)init;
- (instancetype)initWithName:(NSString *)name
          belongsToCategory:(NSString *)category
               wasCreatedOn:(NSDate *)creationDate
                    isDueTo:(NSDate *)dueDate
         additionalNotes:(NSString *)notes;
- (void)print;



@end
