//
//  Data.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 05/06/2022.
//

import SwiftUI
import RealmSwift
import AVFoundation

class RealmManager: ObservableObject {
    
    private(set) var localRealm: Realm?
    @Published var intervals: [Interval] = []
    @Published var schedule: [[Slot]] = [[]]
    @Published var slots: [Slot] = []
    
    init() {
        openRealm()
        getIntervals()
        getSchedule()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 8) // Might need migration block if updating schema...
            
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch  {
            print("Error opening realm! \(error)")
        }
    }
    
    //MARK: - Interval Functions
    
    func addInterval(title: String){
        if let localRealm = localRealm {
            do {
                try localRealm.write{
                    let newItem = Interval(value: ["title": title])
                    localRealm.add(newItem)
                    getIntervals()
                    print("New Interval added to Realm \(newItem)")
                    
                }
            } catch  {
                print("Error adding Interval to realm \(error)")
            }
        }
    }
    
    func getIntervals() {
        if let localRealm = localRealm {
            let allIntervals = localRealm.objects(Interval.self).sorted(byKeyPath: "title")
            intervals = []
            allIntervals.forEach { interval in
                intervals.append(interval)
            }
        }
    }
    
    func updateInterval(id: ObjectId, active: Bool) {
        if let localRealm = localRealm {
            do {
                let intervalToUpdate = localRealm.objects(Interval.self).filter(NSPredicate(format: "id == %@", id))
                guard !intervalToUpdate.isEmpty else { return }
                
                try localRealm.write{
                    intervalToUpdate[0].active = active
                    getIntervals()
                    print("Updated task with id: \(id). Active status: \(active)")
                }
            } catch  {
                print("Error updating interval \(id) to realm: \(error)")
            }
        }
    }
    
    func deleteInterval(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let intervalToDelete = localRealm.objects(Interval.self).filter(NSPredicate(format: "id == %@", id))
                guard !intervalToDelete.isEmpty else { return }
                try localRealm.write{
                    localRealm.delete(intervalToDelete)
                    getIntervals()
                    print("Deleted interval with id: \(id).")
                }
            } catch {
                print("Error deleting interval with id: \(id). \(error)")
            }
        }
    }
    
    //MARK: - Schedule Functions
    
    func getSchedule() {  // Seems to work
        
        if let localRealm = localRealm {
            let scheduleObjects = localRealm.objects(Schedule.self)
            if scheduleObjects.isEmpty {
                addSession()
            }
            let savedSchedule = localRealm.objects(Schedule.self)[0]
            let allSessions = savedSchedule.sessions
            schedule = []
            allSessions.forEach { session in
                schedule.append([])
                session.slots.forEach { slot in
                    schedule[schedule.count-1].append(slot)
                }
            }
        }
        print(schedule)
    }
    
    func addSession() {
        if let localRealm = localRealm {
            do {
                try localRealm.write{
                    let newSession = Session(value: [])
                    let newSlot = Slot(value: [])
                    newSession.slots.append(newSlot)
                    let scheduleObjects = localRealm.objects(Schedule.self)
                    if scheduleObjects.isEmpty {
                        let schedule = Schedule(value: [])
                        localRealm.add(schedule)
                    }
                    let schedule = localRealm.objects(Schedule.self)[0]
                    schedule.sessions.append(newSession)
                    getSchedule()
                    print("New Session added to Realm \(newSession)")
                }
            } catch  {
                print("Error adding Session to realm \(error)")
            }
        }
    }
    
    func deleteSession(sessionNumber: Int){
        if let localRealm = localRealm {
            do {
                let schedule = localRealm.objects(Schedule.self)[0]
                let sessionToDelete = schedule.sessions[sessionNumber]
                try localRealm.write{
                    localRealm.delete(sessionToDelete)
                    getSchedule()
                    print("Session \(sessionNumber) deleted")
                }
            } catch {
                print("Error deleting session \(sessionNumber). \(error)")
            }
        }
    }
    
    func addSlot(sessionNumber: Int){
        if let localRealm = localRealm {
            do {
                try localRealm.write{
                    let newSlot = Slot(value: [])
                    let schedule = localRealm.objects(Schedule.self)[0]
                    let sessionToAppend = schedule.sessions[sessionNumber]
                    sessionToAppend.slots.append(newSlot)
                    getSchedule()
                    print("New Slot added to Session: \(sessionNumber) \(newSlot)")
                    
                }
            } catch  {
                print("Error adding Slot to realm \(error)")
            }
        }
    }
    
    func deleteSlot(sessionNumber: Int, position: Int) {
        if let localRealm = localRealm {
            do {
                let session = localRealm.objects(Session.self)[sessionNumber]
                let slotToDelete = session.slots[position]
                try localRealm.write{
                    localRealm.delete(slotToDelete)
                    print("Deleted slot in session \(sessionNumber) and position \(position).")
                }
                if session.slots.count == 0{
                    deleteSession(sessionNumber: sessionNumber)
                }
                getSchedule()
            } catch {
                print("Error deleting slot in session \(sessionNumber) and position \(position). \(error)")
            }
        }
    }
    
    func updateSlot(session: Int, position: Int, interval: Interval? = nil) {  //Check and fix
        if let localRealm = localRealm {
            do {
                let schedule = localRealm.objects(Schedule.self)[0]
                let sessionToUpdate = schedule.sessions[session]
                let slotToUpdate = sessionToUpdate.slots[position]
                try localRealm.write{
                    slotToUpdate.interval = interval
                    getSchedule()
                    print("Updated slot in session \(session) and position \(position).")
                }
            } catch  {
                print("Error updating slot in session \(session) and position \(position): \(error)")
            }
        }
    }
}

//MARK: - Object Classes

class Interval: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var active = true
    @Persisted var dynamic = 0
    @Persisted var tempo = 0
    @Persisted var articulation = 0
    @Persisted var includeInRandom = false
    @Persisted var repeatInRandom = false
    
    var dynamicToDisplay: String {
        get {
            switch dynamic {
            case 0:
                return "mf"
            case 1:
                return "pp"
            case 2:
                return "ff"
            default:
                return "error!"
            }
        }
    }
    var tempoToDisplay: String {
        get {
            switch tempo {
            case 0:
                return "Moderato"
            case 1:
                return "Adagie"
            case 2:
                return "Presto"
            default:
                return "error!"
            }
        }
    }
    var articulationToDisplay: String {
        get {
            switch articulation {
            case 0:
                return "Normal"
            case 1:
                return "Legato"
            case 2:
                return "Staccato"
            default:
                return "error!"
            }
        }
    }
}

class Slot: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var interval: Interval? = nil
    @Persisted var random = false
    
    var text: String {
        get {
            if random { return "Random" }
            if let interval = interval {
                return interval.title
            }
            return "Empty"
        }
    }
}

class Session: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var slots = RealmSwift.List<Slot>()
}

class Schedule: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var sessions = RealmSwift.List<Session>()
}

