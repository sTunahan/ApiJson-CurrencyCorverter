import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1) Request & Session  : go to url, send a request to this url
        // 2) Response & Data  : get data, answer
        
        // 3) Parsing & Json Serialization : parsing to process received data
        // -------------------------------------------------------------------------
        
        
       
    }
    
    
    @IBAction func getRatesClicked(_ sender: Any) {
        // MARK: step 1
        
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=4a990ae1cc0ef5a920e4c7e9eeb1123c")
        
      
        let session = URLSession.shared
        
        //Clouser
        let task = session.dataTask(with: url!) { data, response, error in
            
            
            if error != nil { // if error is received
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction ( title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                
                // MARK: step 2
                // if data is not empty
                if data != nil {
                    
                    do{
                        // the incoming data is in the dictionary string: any type
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        
                       //MARK: Thread
                        
                        DispatchQueue.main.async {
                            print(jsonResponse) // VERİLERİ ALIP ALMADIGIMIZI GÖRMEK ICIN BERİLER BİZE DİCT turunde geldi.
                            
                            //MARK: step 3
                            print(jsonResponse["rates"]!)
                            
                            
                            // because currencies come in a dictionary
                            
                            if let rates = jsonResponse["rates"] as? [String:Any] {
                                print(rates["USD"]!)
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                    
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                    
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                    
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                    
                                }
                                if let turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turkish)"
                                    
                                }
                            }
                        }
                        
                    }catch{
                        
                        print("error")
                    }
                    
                   
                }
            }
        }
        
        task.resume() 
       
        
    }
    
}

