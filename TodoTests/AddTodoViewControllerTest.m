//
//  AddTodoViewControllerTest.m
//  Todo
//
//  Created by SHIMIZU Taku on 2015/06/04.
//  Copyright (c) 2015年 appdojo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "AddTodoViewController.h"

@interface AddTodoViewControllerTest : XCTestCase

@end

@implementation AddTodoViewControllerTest

- (void)setUp {
    [super setUp];
    AddTodoViewController *vc = [[AddTodoViewController alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testIsValidTodo {
    AddTodoViewController *vc = [[AddTodoViewController alloc] init];
    
    NSString *title = @"hogehoge";
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3600];
    
    NSDictionary *todo;
    
    // 正常系
    todo = @{@"title": title, @"date": date};
    XCTAssertTrue([vc isValidTodo:todo]);
    
    // 順正常系 : NOが返るパターン
    // 1. titleが空文字列の場合
    todo = @{@"title": @"", @"date": date};
    XCTAssertFalse([vc isValidTodo:todo]);
    
    // 2. titleがnilの場合
    todo = @{@"date": date};
    XCTAssertFalse([vc isValidTodo:todo]);

    // 3. titleが空白のみの場合
    todo = @{@"title": @"   　　", @"date": date};
    XCTAssertFalse([vc isValidTodo:todo]);
    
    // 4. dateが昔のパターン
    date = [NSDate dateWithTimeIntervalSinceNow:-2000];
    XCTAssertFalse([vc isValidTodo:todo]);
    
    // 5. dateがキーとして存在しないパターン
    todo = @{@"title": @"title"};
    XCTAssertFalse([vc isValidTodo:todo]);
    
    // 6. 引数にnilを渡したパターン
    XCTAssertFalse([vc isValidTodo:nil]);
    
    // 7. dateの型がNSStringの場合
    todo = @{@"title": @"title", @"date": @""};
    XCTAssertFalse([vc isValidTodo:todo]);
    
    // 8. 余分なkey-valueペアがある場合 : 成功するパターン
    date = [NSDate dateWithTimeIntervalSinceNow:3600];
    todo = @{@"title": @"title", @"date": date, @"extra": @"extra oil"};
}

@end
