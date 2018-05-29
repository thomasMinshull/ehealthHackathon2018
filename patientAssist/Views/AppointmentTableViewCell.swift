//
//  AppointmentTableViewCell.swift
//  patientAssist
//
//  Created by thomas minshull on 2018-05-28.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {
    var delegate: AppointmentViewCellDelegate?
    private var appointementId: String?

    @IBOutlet var toggle: UISwitch!
    @IBOutlet var drLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var clinicLabel: UILabel!
    
    func configureWith(appointment: Appointment) {
        //appointementId = appointment.id
        // ToDo Need to populate Dr Label
        drLabel.text = appointment.physicianId
        timeLabel.text = appointment.startTime
        clinicLabel.text = appointment.aptLocation
        // ToDo clinic label
        toggle.isOn = appointment.isAssitanceRequired()
        
    }
    
    @IBAction func DirectionsButtonTapped(_ sender: Any) {
        delegate?.performSegueForAppointment(id: "")
    }
    
    @IBAction func switchToggled(_ sender: Any) {
        delegate?.toggleNeedsAssitaneForAppointment(id: "")
    }
    
}
