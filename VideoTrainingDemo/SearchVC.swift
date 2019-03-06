//
//  SearchVCViewController.swift
//  VideoTrainingDemo
//
//  Created by Farren Tong on 23/2/2019.
//  Copyright © 2019 FEHD EdUHK. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var videoLabels: [String] = []

    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var resultTableView: UITableView!
    
    //
    // Implement UIVIewController
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.searchText.text == "" {
            searchText.becomeFirstResponder()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //
    // Implement UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        videoLabels = ["Instruction for using Media Toolkit", "Pay and Motivation", "Catering Assessment", "人與大自然", "What is Curriculum", "Counselling Skill", "Organization Behavior"]

        textField.resignFirstResponder()
        self.resultTableView.reloadData()

        return true
    }
    
    
    
    //
    // Implement UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "search_video_cell", for: indexPath)
            
            // Configure the cell...
            cell.textLabel?.text = self.videoLabels[indexPath.row]
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showVideo", sender: self)
    }
    

}
