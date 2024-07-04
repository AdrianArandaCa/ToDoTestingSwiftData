//
//  NotasUITests.swift
//  NotasUITests
//
//  Created by Adrian Aranda Campanario on 4/7/24.
//

import XCTest

final class NotasUITests: XCTestCase {

    func testCreateNote() throws {
        
        let app = XCUIApplication()
        app.launch() //Puesto manualmente, el simulador no lo pone
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear nota"]/*[[".otherElements[\"Crear nota\"]",".buttons[\"Crear nota\"].staticTexts[\"Crear nota\"]",".staticTexts[\"Crear nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        let titleTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView.tap()
        titleTextView.typeText("UITest Titulo")
        
        let textoTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textoTextView.tap()
        textoTextView.typeText("UITest Texto")
        
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Crear nota"]/*[[".otherElements[\"Crear nota\"].buttons[\"Crear nota\"]",".buttons[\"Crear nota\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                
    }
    
    func testCreateTwoNotes() throws {
        let app = XCUIApplication()
        app.launch() //Puesto manualmente, el simulador no lo pone
        
        //Crear primera nota
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear nota"]/*[[".otherElements[\"Crear nota\"]",".buttons[\"Crear nota\"].staticTexts[\"Crear nota\"]",".staticTexts[\"Crear nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        let titleTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView.tap()
        titleTextView.typeText("UITest Titulo")
        
        let textoTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textoTextView.tap()
        textoTextView.typeText("UITest Texto")
        
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Crear nota"]/*[[".otherElements[\"Crear nota\"].buttons[\"Crear nota\"]",".buttons[\"Crear nota\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //Creamos segunda nota
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear nota"]/*[[".otherElements[\"Crear nota\"]",".buttons[\"Crear nota\"].staticTexts[\"Crear nota\"]",".staticTexts[\"Crear nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let titleTextView2 = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView2.tap()
        titleTextView2.typeText("UITest Titulo 2")
        
        let textoTextView2 = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textoTextView2.tap()
        textoTextView2.typeText("UITest Texto 2")
        
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Crear nota"]/*[[".otherElements[\"Crear nota\"].buttons[\"Crear nota\"]",".buttons[\"Crear nota\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testRemoveNote() throws {
        let app = XCUIApplication()
        app.launch() //Puesto manualmente, el simulador no lo pone
        
        //Crear primera nota
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear nota"]/*[[".otherElements[\"Crear nota\"]",".buttons[\"Crear nota\"].staticTexts[\"Crear nota\"]",".staticTexts[\"Crear nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        let titleTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView.tap()
        titleTextView.typeText("UITest Titulo")
        
        let textoTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textoTextView.tap()
        textoTextView.typeText("UITest Texto")
        
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Crear nota"]/*[[".otherElements[\"Crear nota\"].buttons[\"Crear nota\"]",".buttons[\"Crear nota\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let firstNote = collectionViewsQuery.cells.element(boundBy: 0)
        firstNote.tap()
        app.buttons["Eliminar nota"].tap()
    }
}
