//
//  DetailViewController.swift
//  TodoApp
//
//  Created by TJ Maynes on 1/2/17.
//  Copyright © 2017 TJ Maynes. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!

  var itemInfo: (ItemManager, Int)?

  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    return dateFormatter
  }()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    guard let itemInfo = itemInfo else { return }
    let item = itemInfo.0.itemAtIndex(itemInfo.1)

    titleLabel.text = item.title
    locationLabel.text = item.location?.name
    descriptionLabel.text = item.itemDescription

    if let timestamp = item.timestamp {
      let date = Date(timeIntervalSince1970: timestamp)
      dateLabel.text = dateFormatter.string(from: date)
    }

    if let coordinate = item.location?.coordinate {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
      mapView.region = region
    }
  }

  func checkItem() {
    if let itemInfo = itemInfo {
      itemInfo.0.checkItemAtIndex(itemInfo.1)
    }
  }

}
