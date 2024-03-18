//
//  ViewController.swift
//  GOL
//
//  Created by niv ben-porath on 18/03/2024.
//

import UIKit

enum State: String {
    case live
    case dead
}

struct Cell {
    let state: State
}

struct Horizontal {
    let cellStates: [State]
}

struct Vertical {
    let cellStates: [State]
}

struct Grid {
    let horizontal: Horizontal
    let vertical:  Vertical
}



class ViewController: UIViewController {

    var currentGrid: [[State]] = [
        [.dead, .dead, .dead, .dead, .dead],
        [.dead, .dead, .dead, .dead, .dead],
        [.dead, .live, .live, .live, .dead],
        [.dead, .dead, .dead, .dead, .dead],
        [.dead, .dead, .dead, .dead, .dead],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        printGrid()
        while true {
            newGeneration()
        }
        
    }
    
    
    func newGeneration() {
        let horizontal = currentGrid.count
        let vertical = currentGrid[0].count
        
//        var firstArray = [State](repeating: .dead, count: horizontal)
//        firstArray.reserveCapacity(vertical)
        
        var newGrid = currentGrid
//        newGrid.reserveCapacity(horizontal)
        
        for i in 0..<horizontal {
            for j in 0..<vertical {
                if i == -1 || j == -1 || i > currentGrid.count || j > currentGrid[i].count {
                    continue // we are out of bounds
                }
                let newState = liveOrDie(at: i, verticalIndex: j)
                newGrid[i][j] = newState
            }
        }
        
        currentGrid = newGrid
        printGrid()
    }
    
    func liveOrDie(at horizontalIndex: Int, verticalIndex: Int) -> State {
        let currentState = currentGrid[horizontalIndex][verticalIndex]
        switch currentState {
        case .dead:
            return deadToLive(at: horizontalIndex, verticalIndex: verticalIndex)
        case .live:
            return liveToDead(at: horizontalIndex, verticalIndex: verticalIndex)
        }
    }
    
    func deadToLive(at horizontalIndex: Int, verticalIndex: Int) -> State {
        var liveNeighbors = 0
        for i in horizontalIndex-1...horizontalIndex+1 {
            for j in verticalIndex-1...verticalIndex+1 {
                if i == horizontalIndex && j == verticalIndex {
                    continue // we are on the cell we are checking
                }
                else {
                    if i == -1 || j == -1 || i > currentGrid.count-1 || j > currentGrid[i].count-1 {
                        continue // we are out of bounds
                    }
                    if currentGrid[i][j] == .live {
                        liveNeighbors += 1
                        if liveNeighbors > 3 {
                            return .dead
                        }
                    }
                }
            }
        }
        if liveNeighbors == 3 {
            return .live
        }
        else {
            return .dead
        }
    }
    
    func liveToDead(at horizontalIndex: Int, verticalIndex: Int) -> State {
        var liveNeighbors = 0
        for i in horizontalIndex-1...horizontalIndex+1 {
            for j in verticalIndex-1...verticalIndex+1 {
                if i == horizontalIndex && j == verticalIndex {
                    continue // we are on the cell we are checking
                }
                else {
                    if i == -1 || j == -1 || i > currentGrid.count-1 || j > currentGrid[i].count-1 {
                        continue // we are out of bounds
                    }
                    if currentGrid[i][j] == .live {
                        liveNeighbors += 1
                        if liveNeighbors > 3 {
                            return .dead
                        }
                    }
                }
            }
        }
        if liveNeighbors > 1 && liveNeighbors < 4 {
            return .live
        }
        else {
            return .dead
        }
    }
    
    

    func printGrid() {
        for i in 0..<currentGrid.count {
            let states = currentGrid[i].map({$0.rawValue}).joined(separator: ", ")
//            let joinedString = states.
            print(states)
        }
        print("\n")
    }
    
    

}

