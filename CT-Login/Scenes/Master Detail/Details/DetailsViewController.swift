//
//  DetailsViewController.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    private var viewModel : DetailsViewModel!
    
    class func instantiate(_ viewModel : DetailsViewModel) -> UIViewController {
        let viewController = DetailsViewController.instantiate(fromStoryboard: .Details)
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
