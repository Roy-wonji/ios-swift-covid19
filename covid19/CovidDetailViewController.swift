//
//  CovidDetailViewController.swift
//  covid19
//
//  Created by 서원지 on 2021/10/25.
//

import UIKit

class CovidDetailViewController: UITableViewController {

    @IBOutlet var newCaseCell: UITableViewCell!
    @IBOutlet var tottalCaseCell: UITableViewCell!
    @IBOutlet var recoveredCell: UITableViewCell!
    @IBOutlet var deathCell: UITableViewCell!
    @IBOutlet var percentageCell: UITableViewCell!
    @IBOutlet var overseasInflowCell: UITableViewCell!
    @IBOutlet var regionalOutbreakCell: UITableViewCell!
    
    var covidOverview: CoviedOverview?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
       
    }
    
    func configureView() {
        guard let  covidOverview = covidOverview else { return }
        self.title = covidOverview.countryName
        self.newCaseCell.detailTextLabel? .text = "\(covidOverview.newCase)명"
        self.tottalCaseCell.detailTextLabel?.text = "\(covidOverview.totalCase)명"
        self.recoveredCell.detailTextLabel?.text = "\(covidOverview.recovered)명"
        self.deathCell.detailTextLabel?.text = "\(covidOverview.death)명"
        self.percentageCell.detailTextLabel?.text = "\(covidOverview.percentage)명"
        self.overseasInflowCell.detailTextLabel?.text = "\(covidOverview.newFcase)명"
        self.regionalOutbreakCell.detailTextLabel?.text = "\(covidOverview.newCcase)명"
        

    }
}
