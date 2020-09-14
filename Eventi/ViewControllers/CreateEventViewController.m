//
//  CreateEventViewController.m
//  Eventi
//
//  Created by Davide Alzeti on 14/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "CreateEventViewController.h"
#import "MDProgrammedEventTableViewController.h"
#define DEBUGLOG(a) NSLog(@"%s: %@", __FUNCTION__, a)



@interface CreateEventViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;

@property (strong, nonatomic) NSArray *categories;

- (void)setupCategories;

@end

@implementation CreateEventViewController

@synthesize delegate, createdEvent;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTapGesture];
    [self setupCategories];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (pickerView == self.categoryPicker) {
        return 1;
    }
    return 0;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.categoryPicker) {
        return self.categories.count;
    }
    return 0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.categoryPicker) {
        return self.categories[row];
    }
    return nil;
}


- (void)setupCategories{
    self.categories = @[@"Sport", @"Casa", @"Lavoro", @"Hobby"];
    
    self.categoryPicker.dataSource = self;
    self.categoryPicker.delegate = self;
}

- (void)addTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard{
    DEBUGLOG(@"Keyboard dismissed by clicking away");
    [self.eventNameTextField resignFirstResponder];
}


- (IBAction)createNewEvent:(id)sender {
    DEBUGLOG(@"Button pressed: new event created");
    createdEvent = [[MDEvent alloc] initWithName:self.eventNameTextField.text belongsToCategory:[self.categories objectAtIndex:[self.categoryPicker selectedRowInComponent:0]] wasCreatedOn:[NSDate date] isDueTo:[NSDate date] additionalNotes:@""];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillDisappear:(BOOL)animated{
    DEBUGLOG(@"viewWillDisappear called");
    [self.delegate sendNewEvent:createdEvent];
}

@end
