//
//  RequestManagerTests.m
//  TradeMeBrowserTests
//
//  Created by Ian Stewart on 28/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RequestManager.h"

@interface RequestManagerTests : XCTestCase

@end

@implementation RequestManagerTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSharedInstance
{
    // Should never be nil
    RequestManager *requestManager = [RequestManager sharedInstance];
    XCTAssertNotNil(requestManager);
}

- (void)testRetrieveAllCategories
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request - all categories"];
    
    [[RequestManager sharedInstance] retrieveAllCategoriesWithCompletionHandler:^(NSDictionary *data)
    {
        XCTAssertNotNil(data);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testRetrieveCategoryListings
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request - listings"];
    
    [[RequestManager sharedInstance] retrieveListingsForCategory:@"0124-3419-" withCompletionHandler:^(NSDictionary *data)
     {
         XCTAssertNotNil(data);
         
         [expectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testRetrieveCategoryListingFail
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request - listings fail"];
    
    [[RequestManager sharedInstance] retrieveListingsForCategory:@"555555A" withCompletionHandler:^(NSDictionary *data)
     {
         XCTAssertNil(data);
         
         [expectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testRetrieveListingForID
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request - listing for ID"];
    
    [[RequestManager sharedInstance] retrieveListingForID:@6375232 withCompletionHandler:^(NSDictionary *data)
     {
         XCTAssertNotNil(data);
         
         [expectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testRetrieveListingForIDFail
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request - listing for ID fail"];
    
    [[RequestManager sharedInstance] retrieveListingForID:@2000000000 withCompletionHandler:^(NSDictionary *data)
     {
         XCTAssertNil(data);
         
         [expectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
