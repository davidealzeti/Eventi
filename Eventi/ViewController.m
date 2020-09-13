//
//  ViewController.m
//  Eventi
//
//  Created by Davide Alzeti on 11/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "ViewController.h"
#import "MDEvent.h"
#define DEBUGLOG(a) NSLog(@"%s: %@", __FUNCTION__, a)

@interface ViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;

@property (weak, nonatomic) IBOutlet UIDatePicker *dueDate;

- (void)registerForKeyboardNotifications;
- (void)unregisterForKeyboardNotifications;
- (void)keyboardWasShown:(NSNotification *)aNotification;
- (void)keyboardWillBeHidden:(NSNotification *)aNotification;
- (void)dismissKeyboard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)registerForKeyboardNotifications{
    DEBUGLOG(@"Registering for keyboard notifications");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterForKeyboardNotifications{
    DEBUGLOG(@"Unregistering for keyboard notifications");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWasShown:(NSNotification *)aNotification{
    DEBUGLOG(@"Keyboard shown");
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification{
    DEBUGLOG(@"Keyboard hidden");
}

- (void)dismissKeyboard{
    [_eventNameTextField resignFirstResponder];
    DEBUGLOG(@"Keyboard dismissed");
}

- (void)viewWillAppear:(BOOL)animated{
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self unregisterForKeyboardNotifications];
}



@end
