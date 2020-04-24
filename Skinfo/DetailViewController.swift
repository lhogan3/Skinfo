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
        skiAreaName.image = UIImage(named: skiArea.name)
        skiAreaTrails.text = String(skiArea.trailCount)
        skiAreaHours.text = skiArea.hours
        skiAreaAddress.text = skiArea.address
        skiAreaPrice.text = "$\(skiArea.price)"
        
        //Then retrieving info from API and then setting these as well...
        //Make the endpoint the correct URL string with the coordinates from the DB for the given Ski Resort. Then make this URL String a URL object.
        let todoEndpoint: String = "https://api.darksky.net/forecast/5707632f3091ab596512817eb54bcff1/" + String(skiArea.N) + "," + String(skiArea.W) + "?exclude=minutely,,flags";
        let url = URLRequest(url: URL(string: todoEndpoint)!);
        
        //This is what starts the GET Request.
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //Handle if there is a nil return from the request.
            guard let dataResponse = data,
                  error == nil else {
                  print("Error in retrieving JSON data.")
                  return }
            
            //Otherwise, assuming that there is a return.
            do {
                //Need to start formatting the response. Start with making it a dictionary of String : Any.
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [String: Any]
                
                //Then make it just the currently data, since this is the information that we are concerned with.
                let currently = jsonResponse!["currently"]! as! Dictionary<String,Any>;
                
                //Set the information for the temperature and precipitation probability.
                let currentTemp:String = String(describing: currently["temperature"]!)
                let currentProb:String = String(describing: currently["precipProbability"]!)
                
                //Set the image for the precipication type based on whether the precipitation prob = 0 or not.
                let currentType:String;
                if(currentProb == "0"){
                    
                    //If 0 prob, then no precip, so set it to be the none image.
                    currentType = "None"
                }
                
                //Otherwise, there is precip. So set this to be the correct image from assets.
                else{
                    currentType = String(describing: currently["precipType"]!);
                }
                
                //Create the async task and then set the fields with the information retrieved.
                DispatchQueue.main.async { // Correct
                    self.SkiAreaType.image = UIImage(named: currentType);
                    self.skiAreaTemp.text = currentTemp.trunc(length: 4); //truncating the temperature to 4 characters. (i.e. 21.4 degrees)
                    self.skiAreaProb.text = currentProb;
                }
             }
            //catch an error in the parsing of the JSON.
            catch let parsingError {
                print("Error", parsingError)
           }
        }
        //Stop parsing and resume the original task.
        task.resume()
        
        //Configure the rest of the view. 
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

