//
//  Appointment.swift
//  patientAssist
//
//  Created by thomas minshull on 2018-05-28.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

/*
 {
 "addedAppointments": [{
 "id": 1,
 "physicianId": 2,
 "startTime": "2017-01-01T12:00:00-04:00",
 "endTime": "2017-01-01T12:15:00-04:00",
 "typeId": 3,
 "changeId": 5,
 "patientId": 2,
 “patientArrived”: "F",
 “requiresAssistance”: "T",
 “aptLocation”: "Eye Care Center"
 },
 {
 "id": 2,
 "physicianId": 2,
 "startTime": "2017-01-01T12:00:00-05:00",
 "endTime": "2017-01-01T12:15:00-05:00",
 "typeId": 3,
 "changeId": 5,
 "patientId": 2,
 “patientArrived”: "F",
 “requiresAssistance”: "T",
 “aptLocation”: "Stroke Prevention Clinic"
 }
 , ... (other appointments for VGH)],
 }
 
 */

import Foundation

struct Appointment: Codable {
    
    let id: Int
    let physicianId: Int
    let startTime: String
    let endTime: String
    let typeId: Int
    let changeId: Int
    let patientId: Int
    let patientArrived: String
    let requiresAssistance: String
    let aptLocation: String
    
    func hasPatientArrived() -> Bool {
        return patientArrived == "T"
    }
    
    func isAssitanceRequired() -> Bool {
        return requiresAssistance == "T"
    }
}
