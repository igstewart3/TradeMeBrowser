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

- (void)testBrowseCategoriesLandscape
{
    [[XCUIDevice sharedDevice] setOrientation:UIDeviceOrientationLandscapeLeft];
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Trade Me Motors"]/*[[".cells.staticTexts[@\"Trade Me Motors\"]",".staticTexts[@\"Trade Me Motors\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *motorbikesStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Motorbikes"]/*[[".cells.staticTexts[@\"Motorbikes\"]",".staticTexts[@\"Motorbikes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [motorbikesStaticText tap];
    [motorbikesStaticText tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Dual purpose"]/*[[".cells.staticTexts[@\"Dual purpose\"]",".staticTexts[@\"Dual purpose\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *backButton = app.navigationBars[@"Categories"].buttons[@"Back"];
    [backButton tap];
    [backButton tap];
    [backButton tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Trade Me Property"]/*[[".cells.staticTexts[@\"Trade Me Property\"]",".staticTexts[@\"Trade Me Property\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Commercial Property"]/*[[".cells.staticTexts[@\"Commercial Property\"]",".staticTexts[@\"Commercial Property\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Car parks"]/*[[".cells.staticTexts[@\"Car parks\"]",".staticTexts[@\"Car parks\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *carParksNavigationBar = app.navigationBars[@"Car parks"];
    [carParksNavigationBar.buttons[@"Switch to full screen mode"] tap];
    [carParksNavigationBar.buttons[@"Master"] tap];
    [backButton tap];
    [backButton tap];
    [[[app.collectionViews.cells.otherElements containingType:XCUIElementTypeStaticText identifier:@"Widget 100 by Junk 1B"] childrenMatchingType:XCUIElementTypeOther].element tap];
    [app.navigationBars[@"Root"].buttons[@"Root"] tap];
}

- (void)testBrowseCategoriesPortriat
{
    [[XCUIDevice sharedDevice] setOrientation:UIDeviceOrientationPortrait];
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Trade Me Motors"]/*[[".cells.staticTexts[@\"Trade Me Motors\"]",".staticTexts[@\"Trade Me Motors\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *motorbikesStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Motorbikes"]/*[[".cells.staticTexts[@\"Motorbikes\"]",".staticTexts[@\"Motorbikes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [motorbikesStaticText tap];
    [motorbikesStaticText tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Dual purpose"]/*[[".cells.staticTexts[@\"Dual purpose\"]",".staticTexts[@\"Dual purpose\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    [app.navigationBars[@"Dual purpose"].buttons[@"Categories"] tap];
    XCUIElement *backButton = app.navigationBars[@"Categories"].buttons[@"Back"];
    [backButton tap];
    [backButton tap];
    [backButton tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Trade Me Property"]/*[[".cells.staticTexts[@\"Trade Me Property\"]",".staticTexts[@\"Trade Me Property\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Commercial Property"]/*[[".cells.staticTexts[@\"Commercial Property\"]",".staticTexts[@\"Commercial Property\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Car parks"]/*[[".cells.staticTexts[@\"Car parks\"]",".staticTexts[@\"Car parks\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [app.navigationBars[@"Car parks"].buttons[@"Categories"] tap];
    [backButton tap];
    [backButton tap];
}

@end
