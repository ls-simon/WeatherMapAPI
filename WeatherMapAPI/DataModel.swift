import UIKit
import Alamofire
import KeychainAccess
class DataModel {
    
    private var _date: Double?
    private var _temp: String?
    private var _location: String?
    private var _weather: String?
    typealias JSONStandard = Dictionary<String, AnyObject>
 
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Monterey&appid=b34d1fd087a7995a7c22ff82d0c90e2d")!
    
    func storeToKeyChain(){
        let keychain = Keychain(service: "https://api.openweathermap.org/data/2.5/weather?q=Monterey&appid=")
        keychain[string: "appid"] = "0b34d1fd087a7995a7c22ff82d0c90e2d"
    
    }
    
    
    var date: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let date = Date(timeIntervalSince1970: _date!)
            return (_date != nil) ? "Today, \(dateFormatter.string(from: date))" : "Date Invalid"
        
       
    }
    
    var temp: String {
        return _temp ?? "0 °C"
    }
    
    var location: String {
        return _location ?? "Location Invalid"
    }
    
    var weather: String {
        return _weather ?? "Weather Invalid"
    }
    

    func downloadData(completed: @escaping ()-> ()) {
        DispatchQueue.global(qos: .default).async {
            Alamofire.request(self.url).responseJSON(completionHandler: {
                response in
                let result = response.result
                
                if let dict = result.value as? JSONStandard, let main = dict["main"] as? JSONStandard, let temp = main["temp"] as? Double, let weatherArray = dict["weather"] as? [JSONStandard], let weather = weatherArray[0]["main"] as? String, let name = dict["name"] as? String, let sys = dict["sys"] as? JSONStandard, let country = sys["country"] as? String, let dt = dict["dt"] as? Double {
                    
                        self._temp = String(format: "%.0f °C", temp - 273.15)
                        self._weather = weather
                        self._location = "\(name), \(country)"
                        self._date = dt
                    
                   
                }
                
                completed()
            })
        }
     
    }
    enum BackendError: Error {
        case urlError(reason: String)
        case objectSerialization(reason: String)
    }
    
   }
