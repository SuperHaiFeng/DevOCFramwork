//
//  DevOCFramworkTests.m
//  DevOCFramworkTests
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface DevOCFramworkTests : XCTestCase

@end

@implementation DevOCFramworkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void) testDemo {
    // 调用需要测试的方法，
    int result = [self getNum];
    // 如果不相等则会提示@“测试不通过”
    XCTAssertEqual(result, 120,@"测试不通过");
}

- (int)getNum {
    
    return 100;
}

@end
