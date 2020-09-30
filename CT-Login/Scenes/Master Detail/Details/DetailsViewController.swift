//
//  DetailsViewController.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import UIKit
import MapKit
import Combine

class DetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    private lazy var viewModel : DetailsViewModel = {
        return DetailsViewModel()
    }()
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBindings()
    }
    
    private func configureBindings() {
        viewModel.$detailsModel.sink { [weak self] (detailsModel) in
            guard let self = self else { return }
            self.mapView.setRegion(self.viewModel.region, animated: true)
            self.mapView.addAnnotation(self.viewModel.pointAnnotation)
            self.fullNameLabel.text = detailsModel.name
            self.userNameLabel.text = detailsModel.username
            self.emailLabel.text = detailsModel.email
            self.phoneLabel.text = detailsModel.phone
            self.addressLabel.text = detailsModel.address
        }.store(in: &subscriptions)
    }
}

extension DetailsViewController : UserSelectedDelegate {
    func updateUserDetailsViewController(_ detailsModel: DetailsModel) {
        viewModel.updateDetailsModel(detailsModel)
    }
}
