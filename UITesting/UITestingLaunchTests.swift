//
//  UITestingLaunchTests.swift
//  UITesting
//
//  Created by James Yip on 14/1/2022.
//

import XCTest

class UITestingLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testCreateYourOwn() throws {
        
        let app = XCUIApplication()
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements/*@START_MENU_TOKEN@*/.buttons["createYourOwn"]/*[[".scrollViews.buttons[\"createYourOwn\"]",".buttons[\"createYourOwn\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["createYourOwn_createNow"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["threeCam_fv"]/*[[".otherElements[\"threeCam_continue\"].buttons[\"threeCam_fv\"]",".buttons[\"threeCam_fv\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets["Front View"].scrollViews.otherElements.buttons["Take Photo"].tap()
        
        let photocaptureButton = app/*@START_MENU_TOKEN@*/.buttons["PhotoCapture"]/*[[".buttons[\"Take Picture\"]",".buttons[\"PhotoCapture\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        photocaptureButton.tap()
        photocaptureButton.tap()
        
        let image = scrollViewsQuery.children(matching: .image).element
        image.tap()
        image.tap()
        app/*@START_MENU_TOKEN@*/.buttons["threeCam_bv"]/*[[".otherElements[\"threeCam_continue\"].buttons[\"threeCam_bv\"]",".buttons[\"threeCam_bv\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let choosePhotoFromLibraryButton = app.sheets["Back View"].scrollViews.otherElements.buttons["Choose Photo from Library"]
        choosePhotoFromLibraryButton.tap()
        choosePhotoFromLibraryButton.tap()
        choosePhotoFromLibraryButton.tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Screenshot, 13 January, 1:22 PM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Screenshot, 13 January, 8:26 PM, Photo, 13 January, 4:01 PM, Photo, 13 January, 3:32 PM, Photo, 13 January, 3:31 PM, Photo, 13 January, 3:31 PM, Photo, 13 January, 3:16 PM, Screenshot, 13 January, 2:52 PM, Screenshot, 13 January, 1:22 PM, Screenshot, 13 January, 1:07 PM, Live Photo, 12 January, 1:28 PM, Screenshot, 12 January, 4:07 AM, Photo, 12 January, 2:57 AM, Photo, 12 January, 2:55 AM, Photo, 12 January, 2:53 AM, Photo, 12 January, 1:44 AM, Screenshot, 12 January, 1:31 AM, Screenshot, 12 January, 1:29 AM, Screenshot, 11 January, 5:25 PM\"].images[\"Screenshot, 13 January, 1:22 PM\"]",".images[\"Screenshot, 13 January, 1:22 PM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()

        
        let previeweditFvScrollView = app/*@START_MENU_TOKEN@*/.scrollViews.containing(.button, identifier:"previewEdit_fv").element/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 2 pages\").element",".scrollViews.containing(.button, identifier:\"previewEdit_tv\").element",".scrollViews.containing(.button, identifier:\"previewEdit_bv\").element",".scrollViews.containing(.button, identifier:\"previewEdit_fv\").element"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        previeweditFvScrollView/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app/*@START_MENU_TOKEN@*/.buttons["previewEdit_tv"]/*[[".scrollViews.buttons[\"previewEdit_tv\"]",".buttons[\"previewEdit_tv\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).tap()
        app.sheets["Top View"].scrollViews.otherElements.buttons["Cancel"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["previewEdit_bv"]/*[[".scrollViews.buttons[\"previewEdit_bv\"]",".buttons[\"previewEdit_bv\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets["Back View"].scrollViews.otherElements.buttons["Cancel"].tap()
        previeweditFvScrollView.tap()
        app/*@START_MENU_TOKEN@*/.buttons["previewEdit_fv"]/*[[".scrollViews.buttons[\"previewEdit_fv\"]",".buttons[\"previewEdit_fv\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets["Front View"].scrollViews.otherElements.buttons["Cancel"].tap()
        previeweditFvScrollView.swipeUp()
        app/*@START_MENU_TOKEN@*/.buttons["previewEdit_continue"]/*[[".buttons[\"Continue\"]",".buttons[\"previewEdit_continue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let firstNameTextField = elementsQuery.textFields["First name*"]
        firstNameTextField.tap()
        
        let lastNameTextField = elementsQuery.textFields["Last name*"]
        lastNameTextField.tap()
        firstNameTextField.tap()
        app.collectionViews.cells["suggestion"].children(matching: .other).element.children(matching: .other).element.tap()
        
        let asciicapableKey = app/*@START_MENU_TOKEN@*/.keys["ASCIICapable"]/*[[".keyboards.keys[\"ASCIICapable\"]",".keys[\"ASCIICapable\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        asciicapableKey.tap()
        asciicapableKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards.buttons[\"shift\"]",".buttons[\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let jKey = app/*@START_MENU_TOKEN@*/.keys["J"]/*[[".keyboards.keys[\"J\"]",".keys[\"J\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        jKey.tap()
        jKey.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        mKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        sKey.tap()
        lastNameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["y"]/*[[".keyboards.keys[\"y\"]",".keys[\"y\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        iKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".keyboards.keys[\"p\"]",".keys[\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        elementsQuery/*@START_MENU_TOKEN@*/.pickerWheels["Bulgaria"]/*[[".pickers.pickerWheels[\"Bulgaria\"]",".pickerWheels[\"Bulgaria\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery/*@START_MENU_TOKEN@*/.pickerWheels["Austria"]/*[[".pickers.pickerWheels[\"Austria\"]",".pickerWheels[\"Austria\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery/*@START_MENU_TOKEN@*/.pickerWheels["Hong Kong"]/*[[".pickers.pickerWheels[\"Hong Kong\"]",".pickerWheels[\"Hong Kong\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.textFields["Contact number*"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        key.tap()
        key.tap()
        key.tap()
        scrollViewsQuery.otherElements.containing(.textField, identifier:"Send the invoice to my email address").element.tap()
        elementsQuery.textFields["Send the invoice to my email address"].tap()
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["cancel order"]/*[[".buttons[\"cancel order\"].staticTexts[\"cancel order\"]",".buttons[\"orderConfirm_cancel\"].staticTexts[\"cancel order\"]",".staticTexts[\"cancel order\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets["Order cancellation"].scrollViews.otherElements.buttons["dismiss"].tap()
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["PAY NOW"]/*[[".buttons[\"PAY NOW\"].staticTexts[\"PAY NOW\"]",".buttons[\"orderConfirm_pay\"].staticTexts[\"PAY NOW\"]",".staticTexts[\"PAY NOW\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let verticalScrollBar3PagesScrollView = app/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 3 pages").element/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 3 pages\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        verticalScrollBar3PagesScrollView.tap()
        verticalScrollBar3PagesScrollView.tap()
        verticalScrollBar3PagesScrollView.tap()
        verticalScrollBar3PagesScrollView.tap()
        app.buttons["finalInvoice_close"].tap()
    }
    
    func testInvoiceSearch() {
        
        let app = XCUIApplication()
        let button = app/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 3 pages")/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\")",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 3 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element(boundBy: 0)
        button.swipeUp()
        button.swipeDown()
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.buttons["invoiceTracking"]/*[[".scrollViews.buttons[\"invoiceTracking\"]",".buttons[\"invoiceTracking\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.staticTexts["Last order: #826635"].tap()
        app.staticTexts["Find Your Order"].tap()
        app.staticTexts["Search and track here"].tap()
        
        let inputYourInvoiceNumberTextField = app.textFields["Input your invoice number"]
        inputYourInvoiceNumberTextField.tap()
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.keys["8"]/*[[".keyboards.keys[\"8\"]",".keys[\"8\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let key = app2/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        key.tap()
        
        let key2 = app2/*@START_MENU_TOKEN@*/.keys["6"]/*[[".keyboards.keys[\"6\"]",".keys[\"6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        
        let key3 = app2/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key3.tap()
        key3.tap()
        key3.tap()
        key3.tap()
        key3.tap()
        key3.tap()
        
        let key4 = app2/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key4.tap()
        key4.tap()
        
        let deleteKey = app2/*@START_MENU_TOKEN@*/.keys["Delete"]/*[[".keyboards.keys[\"Delete\"]",".keys[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteKey.tap()
        deleteKey.tap()
        key3.tap()
        key3.tap()
        
        
        let clickToShowAddressScrollView = app/*@START_MENU_TOKEN@*/.scrollViews.containing(.button, identifier:"Click to show address").element/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 3 pages\").element",".scrollViews.containing(.button, identifier:\"Click to show address\").element"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        clickToShowAddressScrollView.tap()
        clickToShowAddressScrollView.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Click to show address"]/*[[".scrollViews.buttons[\"Click to show address\"]",".buttons[\"Click to show address\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Click to show address"].tap()
        
        
        let verticalScrollBar1PageScrollView = app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 1 page").element/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 3 pages\").element",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 1 page\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        verticalScrollBar1PageScrollView.swipeDown()
        
        let verticalScrollBar3PagesScrollView = app/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 3 pages").element/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 3 pages\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        verticalScrollBar3PagesScrollView.tap()
        verticalScrollBar1PageScrollView.tap()
        verticalScrollBar3PagesScrollView/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeDown()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 3 pages")/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\")",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 3 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        
        let element4 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        let element6 = element4.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let element5 = element6.children(matching: .other).element(boundBy: 1)
        let element = element5.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        element.tap()
        
        let invoice826635StaticText = app.staticTexts["Invoice #826635"]
        invoice826635StaticText.tap()
        app.staticTexts["19 JAN"].tap()
        app.staticTexts["Estimated arrival"].tap()
        app.staticTexts["~5 days"].tap()
        app.staticTexts["KTShipping Station"].tap()
        element.tap()
        app.staticTexts["~26.74 KM"].tap()
        app.staticTexts["Flat 3F, Tower 2, Chateau \n3 Mount Kelleet Road \nThe Peak, HK Island\nHong Kong, Hong Kong\n"].tap()
        
        let element2 = element5.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).children(matching: .other).element
        element2.tap()
        element2.tap()
        
        let element3 = element6.children(matching: .other).element(boundBy: 0)
        element3.tap()
        app/*@START_MENU_TOKEN@*/.maps.containing(.other, identifier:"Central Green Trail").element.swipeRight()/*[[".maps.containing(.other, identifier:\"The Peak\").element",".swipeDown()",".swipeRight()",".maps.containing(.other, identifier:\"Barker Road\").element",".maps.containing(.other, identifier:\"Madame Tussauds Hong Kong\").element",".maps.containing(.other, identifier:\"Peak Circle Walk\").element",".maps.containing(.other, identifier:\"Mount Austin Playground\").element",".maps.containing(.other, identifier:\"May Road\").element",".maps.containing(.other, identifier:\"Central Green Trail\").element"],[[[-1,8,1],[-1,7,1],[-1,6,1],[-1,5,1],[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        element3.tap()
        element6.children(matching: .button).element.tap()
        invoice826635StaticText.tap()
        element4.children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
                        
                
    }
    
    func testWorkshop() {
        
        let app = XCUIApplication()
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.buttons["workshop"]/*[[".scrollViews.buttons[\"workshop\"]",".buttons[\"workshop\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let moreScrollView = app.scrollViews.containing(.button, identifier:"more").element
        moreScrollView.tap()
        moreScrollView.swipeLeft()
        moreScrollView.swipeRight()
        app.staticTexts["Workshop"].tap()
        moreScrollView.tap()
        moreScrollView.tap()
        moreScrollView.tap()
        app/*@START_MENU_TOKEN@*/.buttons["more"]/*[[".scrollViews.buttons[\"more\"]",".buttons[\"more\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.staticTexts["Workshop: Mini Dough Warrior"].tap()
        
        let signUpNowScrollView = app/*@START_MENU_TOKEN@*/.scrollViews.containing(.button, identifier:"sign up now").element/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 4 pages\").element",".scrollViews.containing(.button, identifier:\"sign up now\").element"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        signUpNowScrollView.tap()
        signUpNowScrollView.tap()
        signUpNowScrollView.tap()
        signUpNowScrollView.tap()
        signUpNowScrollView.tap()
        signUpNowScrollView/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.containing(.link, identifier:"Legal").children(matching: .other).element.children(matching: .map).element.swipeDown()
        scrollViewsQuery.otherElements/*@START_MENU_TOKEN@*/.maps.containing(.other, identifier:"Kowloon").element.swipeLeft()/*[[".maps.containing(.other, identifier:\"Victoria Harbour\").element",".swipeUp()",".swipeLeft()",".maps.containing(.other, identifier:\"Workshop Venue, Workshop Venue\").element",".maps.containing(.other, identifier:\"Kowloon\").element"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        signUpNowScrollView.tap()
        signUpNowScrollView.tap()
        signUpNowScrollView.tap()
        signUpNowScrollView.tap()
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.buttons["sign up now"]/*[[".scrollViews.buttons[\"sign up now\"]",".buttons[\"sign up now\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["First name*"].tap()
        
        let tKey = app2/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        tKey.tap()
        app.textFields["Last name*"].tap()
        app2/*@START_MENU_TOKEN@*/.pickerWheels["10:00 am"]/*[[".pickers.pickerWheels[\"10:00 am\"]",".pickerWheels[\"10:00 am\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tKey.tap()
        
        let emailAddressTextField = app.textFields["Email address*"]
        emailAddressTextField.tap()
        emailAddressTextField.tap()
        
        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        gKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
        nKey.tap()
        
        let jKey = app/*@START_MENU_TOKEN@*/.keys["j"]/*[[".keyboards.keys[\"j\"]",".keys[\"j\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        jKey.tap()
        jKey.tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        let element = element2.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        app.textFields["Mobile number*"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        key2.tap()
        
        let key3 = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key3.tap()
        key3.tap()
        key3.tap()
        app/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        key.tap()
        key2.tap()
        key2.tap()
        app.textFields["Pax*"].tap()
        app/*@START_MENU_TOKEN@*/.keys["Delete"]/*[[".keyboards.keys[\"Delete\"]",".keys[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        key2.tap()
        key2.tap()
        element.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["10:00 am"]/*[[".pickers.pickerWheels[\"10:00 am\"]",".pickerWheels[\"10:00 am\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app/*@START_MENU_TOKEN@*/.pickerWheels["2:30 pm"]/*[[".pickers.pickerWheels[\"2:30 pm\"]",".pickerWheels[\"2:30 pm\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Done"]/*[[".buttons[\"Done\"].staticTexts[\"Done\"]",".staticTexts[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let button = element2.children(matching: .other).element.children(matching: .button).element
        button.tap()
        button.tap()
                        
    }

}
