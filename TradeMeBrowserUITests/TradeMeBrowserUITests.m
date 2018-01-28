//
//  TradeMeBrowserUITests.m
//  TradeMeBrowserUITests
//
//  Created by Ian Stewart on 27/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TradeMeBrowserUITests : XCTestCase

@end

@implementation TradeMeBrowserUITests

- (void)setUp
{
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFullUI
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Trade Me Motors"]/*[[".cells.staticTexts[@\"Trade Me Motors\"]",".staticTexts[@\"Trade Me Motors\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElementQuery *scrollViewsQuery = app.scrollViews;
    [[[scrollViewsQuery childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeCollectionView].element swipeUp];
    
    XCUIElementQuery *elementsQuery = scrollViewsQuery.otherElements;
    XCUIElementQuery *cellsQuery = elementsQuery.collectionViews.cells;
    [[cellsQuery.otherElements containingType:XCUIElementTypeStaticText identifier:@"Pro1 Chi 0048"].element swipeUp];
    
    XCUIElementQuery *tablesQuery2 = elementsQuery.tables;
    [tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts[@"Cars"]/*[[".cells.staticTexts[@\"Cars\"]",".staticTexts[@\"Cars\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [[[cellsQuery.otherElements containingType:XCUIElementTypeStaticText identifier:@"Other 1969"] childrenMatchingType:XCUIElementTypeOther].element tap];
    /*@START_MENU_TOKEN@*/[app.staticTexts[@"$58,000"] pressForDuration:0.7];/*[["app.staticTexts[@\"$58,000\"]","["," tap];"," pressForDuration:0.7];"],[[[-1,0,1]],[[1,3],[1,2]]],[0,0]]@END_MENU_TOKEN@*/
    [app.navigationBars[@"Master"].buttons[@"Cars"] tap];
    [app.navigationBars[@"Cars"].buttons[@"Trade Me Motors"] tap];
    [app.navigationBars[@"Trade Me Motors"].buttons[@"Categories"] tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Trade Me Jobs"]/*[[".cells.staticTexts[@\"Trade Me Jobs\"]",".staticTexts[@\"Trade Me Jobs\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts[@"Accounting"]/*[[".cells.staticTexts[@\"Accounting\"]",".staticTexts[@\"Accounting\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts[@"Accountants"]/*[[".cells.staticTexts[@\"Accountants\"]",".staticTexts[@\"Accountants\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts[@"Assistant accountants"]/*[[".cells.staticTexts[@\"Assistant accountants\"]",".staticTexts[@\"Assistant accountants\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Assistant accountants"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeScrollView].element tap];
    [app.navigationBars[@"Assistant accountants"].buttons[@"Accountants"] tap];
    [app.navigationBars[@"Accountants"].buttons[@"Accounting"] tap];
    [app.navigationBars[@"Accounting"].buttons[@"Trade Me Jobs"] tap];
    [app.navigationBars[@"Trade Me Jobs"].buttons[@"Categories"] tap];
}

- (void)testNoImageUI
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *tradeMePropertyStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"Trade Me Property"]/*[[".cells.staticTexts[@\"Trade Me Property\"]",".staticTexts[@\"Trade Me Property\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [tradeMePropertyStaticText tap];
    
    [[app.scrollViews.otherElements.collectionViews.cells.otherElements containingType:XCUIElementTypeStaticText identifier:@"6282697"].staticTexts[@"No Image Available"] tap];
    [app.staticTexts[@"No Image Available"] tap];
    
    XCUIElement *masterNavigationBar = app.navigationBars[@"Master"];
    [masterNavigationBar.buttons[@"Trade Me Property"] tap];
    XCUIElement *categoriesButton = app.navigationBars[@"Trade Me Property"].buttons[@"Categories"];
    [categoriesButton tap];
}

@end
