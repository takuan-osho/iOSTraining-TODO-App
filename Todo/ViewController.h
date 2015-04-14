//
//  ViewController.h
//  Todo
//
//  Created by appdojo on 2015/03/16.
//  Copyright (c) 2015年 appdojo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoTableViewCell.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *todo;
@property (strong, nonatomic) TodoTableViewCell *offscreenCell;
@end

