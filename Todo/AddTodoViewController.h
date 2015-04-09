//
//  AddTodoViewController.h
//  Todo
//
//  Created by SHIMIZU Taku on 2015/04/09.
//  Copyright (c) 2015年 appdojo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddTodoViewControllerDelegate <NSObject>
- (void)addTodoViewControllerDoneButtonTapped:(NSString *)todo;
@end

@interface AddTodoViewController : UIViewController
@property (nonatomic, weak) id<AddTodoViewControllerDelegate> delegate;
@end