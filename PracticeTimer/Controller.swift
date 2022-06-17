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
    
    let data = Data()
    let defaults = UserDefaults.standard
    var soundPlayer = SoundPlayer()
    
    @Published var currentState: Mode = .waitingToStart
    //@StateObject var activityController: ActivityController = ActivityController()
    
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
    var pausedStateText: String {
        get {
            switch currentState {
            case .pausedWork:
                return "Work x\(currentRep)"
            case .pausedRest:
                return "Rest"
            case .pausedCountdown:
                return "Countdown"
            default:
                return "Error"
            }
        }
    }
    @Published var workDuration: Int
    @Published var restDuration: Int
    var countdownDuration: Int = 5
    @Published var reps: Int
    @Published var currentRep = 1
    @Published var isPaused = false
    
    @Published var timeRemaining: Int = 300
    
    init() {
        workDuration = defaults.integer(forKey: "work-duration") > 0 ? defaults.integer(forKey: "work-duration") : 29
        restDuration = defaults.integer(forKey: "rest-duration") > 0 ? defaults.integer(forKey: "rest-duration") : 10
        reps = defaults.integer(forKey: "reps") > 0 ? defaults.integer(forKey: "reps") : 5
        workDuration = workDuration > 45 ? 29 : workDuration
        restDuration = restDuration > 45 ? 10 : restDuration
        timeRemaining = Tools.timerValues[workDuration]
        
    }
    
    func saveSettings() {
        defaults.set(workDuration, forKey: "work-duration")
        defaults.set(restDuration, forKey: "rest-duration")
        defaults.set(reps, forKey: "reps")
    }
    

    func incrementTime() {
        
        let stoppedModes: [Mode] = [.pausedRest, .pausedWork, .waitingToStart, .finished, .pausedCountdown]
        
        if timeRemaining == 1 {
            soundPlayer.play(beep: "longBeep")
            if currentState == .countdown {
                currentState = .work
                timeRemaining = Tools.timerValues[workDuration]
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
                timeRemaining = Tools.timerValues[restDuration]
            } else {
                currentState = .work
                timeRemaining = Tools.timerValues[workDuration]
            }
            return
        }
        if timeRemaining > 1 && !stoppedModes.contains(currentState){
            timeRemaining -= 1
            
            if timeRemaining <= 4 {
                soundPlayer.play(beep: "shortBeep")
            }
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
            timeRemaining = Tools.timerValues[workDuration]
        }
        
        isPaused = [Mode.pausedCountdown, Mode.pausedWork, Mode.pausedRest].contains(currentState)
        return
    }
    
    func endButtonPressed() {
        currentState = .waitingToStart
        currentRep = 1
        timeRemaining = Tools.timerValues[workDuration]
        isPaused = false
    }
    
    func setTimeToDisplay() {
        timeRemaining = Tools.timerValues[workDuration]
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
