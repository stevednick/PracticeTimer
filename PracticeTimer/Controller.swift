//
//  Controller.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 03/05/2022.
//

import SwiftUI

enum Mode {
    case work
    case rest
    case pausedWork
    case pausedRest
    case waitingToStart
    case finished
    case countdown
    case pausedCountdown
}

public struct PracticeElement {
    enum Tempos {
        case slow
        case neutral
        case fast
    }
    enum Articulations {
        case legato
        case neutral
        case articulated
    }
    enum Volumes {
        case quiet
        case neutral
        case loud
    }
    let name: String
    let volume: Volumes
    let articulation: Articulations
    let tempo: Tempos
}

class Controller: ObservableObject {
    @Published var currentState: Mode = .waitingToStart
    @Published var timeRemaining: Int = 10 // Get rid of this starting value...
    var startButtonText: String {
        get {
            if [Mode.pausedRest, Mode.pausedWork].contains(currentState) { return "Go" }
            if currentState == .waitingToStart { return "Start" }
            if currentState == .finished { return "Done" }
            return "Pause"
        }
    }
    var stateText: String {
        get {
            if currentState == .waitingToStart { return "Ready" }
            if currentState == .work { return "Work x\(currentRep)"}
            if currentState == .rest { return "Rest" }
            if currentState == .finished { return "Finished" }
            if currentState == .countdown { return "Get Ready" }
            return "Paused"
        }
    }
    @Published var workDuration: Int = 10
    @Published var restDuration: Int = 10
    var countdownDuration: Int = 5
    @Published var reps: Int = 2
    @Published var currentRep = 1
    

    func incrementTime() {
        
        let stoppedModes: [Mode] = [.pausedRest, .pausedWork, .waitingToStart, .finished, .pausedCountdown]
        
        if timeRemaining == 1 {
            if currentState == .countdown {
                currentState = .work
                timeRemaining = workDuration
                return
            }
            if currentState == .work {
                currentRep += 1
                if currentRep > reps {
                    currentState = .finished
                    timeRemaining = 0
                    return
                }
                currentState = .rest
                timeRemaining = restDuration
            } else {
                currentState = .work
                timeRemaining = workDuration
            }
            return
        }
        if timeRemaining > 1 && stoppedModes.contains(currentState) == false{
            timeRemaining -= 1
        }
        
    }
    
    func startButtonPressed() {
        switch currentState {
        case .work:
            currentState = .pausedWork
        case .rest:
            currentState = .pausedRest
        case .countdown:
            currentState = .pausedCountdown
        case .pausedCountdown:
            currentState = .countdown
        case .pausedWork:
            currentState = .work
        case .pausedRest:
            currentState = .rest
        case .waitingToStart:
            currentState = .countdown
            timeRemaining = countdownDuration
        case .finished:
            currentState = .waitingToStart
            currentRep = 1
            timeRemaining = workDuration
        }
    }
}

extension Int {
    func timeDisplay() -> String {
        let minutes = Int(Double(self)/60.0)
        var seconds = String(self % 60)
        if seconds.count == 1 {
            seconds = "0" + seconds
        }
        return String(minutes) + ":" + seconds
    }
}
