//
//  TESTViewController.swift
//  WeatherMapAPI
//
//  Created by Simon M. Nielsen on 12/7/17.
//  Copyright © 2017 Simon Nielsen. All rights reserved.
//

import UIKit

class TESTViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    
    var weather = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weather.storeToKeyChain()
        
        DispatchQueue.global(qos: .default).async(){
            self.weather.downloadData {
                
                self.updateUI()
                
            }
        }
            
        
    }
    override func viewWillAppear(_ animated: Bool) {
        }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.dateLabel.text = self.weather.date
            self.tempLabel.text = "\(self.weather.temp)"
            self.self.locationLabel.text = self.weather.location
            self.weatherLabel.text = self.weather.weather
            self.weatherImage.image = UIImage(named: self.weather.weather)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
