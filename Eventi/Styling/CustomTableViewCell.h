//
//  CustomTableViewCell.h
//  Eventi
//
//  Created by Davide Alzeti on 16/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;

@end
