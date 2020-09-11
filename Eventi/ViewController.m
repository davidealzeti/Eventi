//
//  ViewController.m
//  Eventi
//
//  Created by Davide Alzeti on 11/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "ViewController.h"
#define DEBUGLOG(a) NSLog(@"%s: %@", __FUNCTION__, a)

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSNumber *count;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)setCount:(NSNumber *)count{
    _count = count;
    self.label.text = [NSString stringWithFormat:@"Count: %d", self.count.intValue];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    self.count = @(self.count.intValue + 1);
    DEBUGLOG(@"Button pressed");
}


@end
