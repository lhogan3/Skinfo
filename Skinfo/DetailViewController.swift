//
//  DetailViewController.swift
//  Skinfo
//
//  Created by Liam Hogan on 2/18/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //skiArea: The SkiArea object that was tapped and passed to this variable:
    var skiArea: SkiArea!
    
    @IBOutlet var skiAreaName: UILabel!
    @IBOutlet var skiAreaTrails: UILabel!
    @IBOutlet var skiAreaN: UILabel!
    @IBOutlet var skiAreaW: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    //----------------------------------------------------------------------------------------------------

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
    
    //----------------------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        skiAreaName.text = skiArea.name
        skiAreaTrails.text = String(skiArea.trailCount)
        configureView()
    }
    
    //----------------------------------------------------------------------------------------------------

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    //----------------------------------------------------------------------------------------------------

}

