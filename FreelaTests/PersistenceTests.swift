//
//  PersistenceTests.swift
//  FreelaTests
//
//  Created by Albert Rayneer on 21/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import XCTest
@testable import Freela

class PersistenceTests: XCTestCase {

    func test_readAllFavoriteJobs_jobArray() {
        //given
        let sut = FavoriteJobRepository()
        
        //When
        let output = sut.readAllItems()
        
        //Then
        XCTAssert(type(of: output) == [Job].self)
        
    }
    
    func test_createNewFavoriteJob_emptyJob_persistedJob() {
        //given
        let sut = FavoriteJobRepository()
        let input = Job()
        
        //when
        let output = sut.createNewItem(item: input)
        
        //then
        XCTAssertNotNil(output)
        
        sut.delete(id: output.id)
        
    }
    
    func test_deleteFavoriteJob_someJobId_toBeEqualTrue() {
        //given
        let sut = FavoriteJobRepository()
        let input = sut.createNewItem(item: Job())
        
        //when
        let output = sut.delete(id: input.id)
        
        //then
        XCTAssertEqual(output, true)
        
    }
}
