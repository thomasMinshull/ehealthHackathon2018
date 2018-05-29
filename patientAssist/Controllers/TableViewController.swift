//
//  TableViewController.swift
//  patientAssist
//
//  Created by thomas minshull on 2018-05-28.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

protocol AppointmentViewCellDelegate {
    func performSegueForAppointment(id: String)
    func toggleNeedsAssitaneForAppointment(id: String)
}

class TableViewController: UITableViewController, AppointmentViewCellDelegate {
    var appointments = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ToDo send off get request get data and reload data
        
//        let json = "{\"id\": 1,\"physicianId\": 2,\"startTime\": \"2017-01-01T12:00:00-04:00\",\"endTime\": \"2017-01-01T12:15:00-04:00\",\"typeId\": 3,\"changeId\": 5,\"patientId\": 2,“patientArrived”: \"F\",“requiresAssistance”: \"T\",“aptLocation”: \"Eye Care Center\"}"
//        
//        let data = json.data(using: String.Encoding.utf8, allowLossyConversion: false)!
//        let jsonArray = try? JSONSerialization.jsonObject(with: data, options : .allowFragments)
//        let appointmentWrapper = try! JSONDecoder().decode(Appointment.self, from: data)
//        
//        print(appointmentWrapper)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AppointmentTableViewCell
        
        cell.configureWith(appointment: appointments[indexPath.row])
        
        return cell
    }
    
    // MARK: - AppointmentViewCellDelegate
    func performSegueForAppointment(id: String) {
        //ToDo fetch the data for Appointment by Id
        // call segue and pass information forward
    }
    
    func toggleNeedsAssitaneForAppointment(id: String) {
        // ToDo update the NeedsAssistanceForAppointment value for the associated appointment
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
