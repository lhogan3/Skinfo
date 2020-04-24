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
    
    //@IBOutlet var skiAreaName: UILabel!
    @IBOutlet weak var skiAreaName: UIImageView!
    @IBOutlet var skiAreaTrails: UILabel!
    @IBOutlet var skiAreaHours: UILabel!
    @IBOutlet var skiAreaAddress: UILabel!
    @IBOutlet var skiAreaPrice: UILabel!
    @IBOutlet weak var skiAreaTemp: UILabel!
    @IBOutlet weak var skiAreaProb: UILabel!
   // @IBOutlet weak var skiAreaType: UILabel!
    @IBOutlet weak var SkiAreaType: UIImageView!
    
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
        
        //Setting the constant data.
       // skiAreaName.text = skiArea.name
        
        skiAreaName.image = UIImage(named: skiArea.name)
        skiAreaTrails.text = String(skiArea.trailCount)
        print(skiArea.trailCount)
        skiAreaHours.text = skiArea.hours
        skiAreaAddress.text = skiArea.address
        skiAreaPrice.text = "$\(skiArea.price)"
        
        //Then retrieving infor from API and then setting these as well.
        let todoEndpoint: String = "https://api.darksky.net/forecast/5707632f3091ab596512817eb54bcff1/" + String(skiArea.N) + "," + String(skiArea.W) + "?exclude=minutely,,flags";
                        let url = URLRequest(url: URL(string: todoEndpoint)!)
                        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        guard let dataResponse = data,
                                  error == nil else {
                                  print("Error in retrieving JSON data.")
                                  return }
                            do {
                                //here dataResponse received from a network request
                                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [String: Any]
                                let currently = jsonResponse!["currently"]! as! Dictionary<String,Any>;
                                let currentTemp:String = String(describing: currently["temperature"]!)
                                let currentProb:String = String(describing: currently["precipProbability"]!)
                                let currentType:String;
                                if(currentProb == "0"){
                                    currentType = "None"
                                   // UIImage(named: "NONE")
                                }
                                else{
                                    currentType = String(describing: currently["precipType"]!);
                                }
                                DispatchQueue.main.async { // Correct
                                    self.SkiAreaType.image = UIImage(named: currentType);
                                    self.skiAreaTemp.text = currentTemp.trunc(length: 4);
                                    self.skiAreaProb.text = currentProb;
                                }
                             } catch let parsingError {
                                print("Error", parsingError)
                           }
                        }
                        task.resume()
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

