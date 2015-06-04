//
//  AddTodoViewController.m
//  Todo
//
//  Created by yuichi.takeda on 4/3/15.
//  Copyright (c) 2015 appdojo. All rights reserved.
//

#import "AddTodoViewController.h"

@interface AddTodoViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomConstraint;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelButtonTapped:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(doneButtonTapped:)];

    // キーボード表示時の通知を受け取るようにオブザーバーとして登録する
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)dealloc
{
    // インスタンスが破棄されても通知は呼ばれるので通知されないようにする
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)keyboardWillShow:(NSNotification *)notification
{
    // キーボードのサイズを取得
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    // キーボードのサイズに合わせてTextViewの下マージンの値を変える
    self.textViewBottomConstraint.constant = CGRectGetHeight(keyboardFrame);
}

- (void)cancelButtonTapped:(id)sender
{
    // キャンセルボタンがタップされた時にdelegateに通知する. 新しいToDoはnil
    [self.delegate addTodoViewController:self addTodoCompleted:nil];
}

- (void)doneButtonTapped:(id)sender
{
    // doneボタンがタップされた時にdelegateに通知する. 新しいToDoはTextViewのテキストと締切
    NSDictionary *newTodo = @{@"title": self.textView.text,
                              @"date": self.datePicker.date};
    
    if ([self isValidTodo:newTodo]) {
        // delegateに伝播
        [self.delegate addTodoViewController:self addTodoCompleted:newTodo];
    } else {
        
    }
    // 不正な場合なのでアラートを表示
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"TODOの追加に失敗しました"
                                                                   message:@"本文が空か締め切り日時が過去になっています"
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                // alertボタンタップ時のハンドラ
                                                NSLog(@"ok button tapped");
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"NG1"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"NG2"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)isValidTodo:(NSDictionary *)todo {
    NSString *title = todo[@"title"];
    NSDate *date = todo[@"date"];
    
    NSString *trimmedTitle = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (date == nil) {
        return NO;
    }
    
    if ([date isKindOfClass:[NSDate class]] == NO) {
        return NO;
    }
    
    if (trimmedTitle.length == 0) {
        return NO;
    }
    
    if ([date timeIntervalSinceNow] < 0.0) {
        return NO;
    }
    
    return YES;
}

@end
