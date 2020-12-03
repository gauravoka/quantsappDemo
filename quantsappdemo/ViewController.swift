//
//  ViewController.swift
//  quantsappdemo
//
//  Created by Gaurav Oka on 03/12/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    
    var feedModelArrayObj = [FeedModel]()
    
    @IBOutlet weak var feedTblView: UITableView!
    
    
    var urlStr = String()
    var imgStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        Spinner.start()
        callApi()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK:- API CALL

  //API call to get information from URL.
    
    func callApi(){
        let url = "https://api.androidhive.info/feed/feed.json"
        
        WebAPI.httpJSONRequest(viewController: self, method: .get, url: url, params: nil, header: [:], encoding: JSONEncoding.default) { (response) in
            let dict = response.dictionary!
            Spinner.stop()
            guard let feedArray = dict["feed"] else{
                return
            }
            
            let feed_arr = feedArray.arrayValue
            
            for feedElement in feed_arr {
                guard let status = feedElement["status"].string else {
                    return
                }
                
                guard let profilePic = feedElement["profilePic"].string else {
                    return
                }
                
                guard let timeStamp = feedElement["timeStamp"].string else {
                    return
                }
                
                guard let id = feedElement["id"].int else {
                    return
                }
                
                guard let name = feedElement["name"].string else {
                    return
                }
                
                
                if let img = feedElement["image"].string {
                    self.imgStr = img
                }else {
                    self.imgStr = "Not Applicable"
                }
                
                
                if let url = feedElement["url"].string {
                    self.urlStr = url
                }else {
                    self.urlStr = "Not Applicable"
                }
                
                let feedModelDict = ["status":status,
                                     "profilePic":profilePic,
                                     "timeStamp":timeStamp,
                                     "id":id,
                                     "name":name,
                                     "image":self.imgStr,
                                     "url":self.urlStr] as [String : Any]
                
                let feedmodelObj = FeedModel.returnFeedModel(dict: feedModelDict)
                
                self.feedModelArrayObj.append(feedmodelObj)
                
            }
            
            print(self.feedModelArrayObj)
            self.feedTblView.reloadData()
            print(response)
        } Errorhandler: { (Error) in
            Spinner.stop()
            let alert = UIAlertController(title: "Error", message: Error.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            print(Error)
        }
        
    }
    
}

//MARK:- Extensions for TableView Delegates and DataSource methods

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedModelArrayObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = feedTblView.dequeueReusableCell(withIdentifier: "FeedTblViewCell") as! FeedTblViewCell
        
        cell.titleLabel.text = feedModelArrayObj[indexPath.row].name
        cell.timeStampLabel.text = feedModelArrayObj[indexPath.row].timeStamp
        cell.descLabel.text = feedModelArrayObj[indexPath.row].Status
        cell.logoImgView.downloadedFrom(link: feedModelArrayObj[indexPath.row].profilePic)
        cell.descImgView.downloadedFrom(link: feedModelArrayObj[indexPath.row].image)
        
        let epocTime = TimeInterval(Int(feedModelArrayObj[indexPath.row].timeStamp)!)
        //timestamp function is working fine please try with 1606894202 in below fuction
        let myDate = NSDate(timeIntervalSince1970: epocTime)
        
        let elpased_time = getElapsedInterval(date: myDate as Date)
        
        cell.timeStampLabel.text = elpased_time
        
        
        setupUI.setUpElevation(view: cell.outerCellView)
        cell.outerCellView.layer.cornerRadius = 10
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
}




extension ViewController {
    
    func getElapsedInterval(date: Date) -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day], from: date, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"
            
        }
        
    }
}
//MARK:- Extensions for IMAGEVIEW

extension UIImageView {
    
    func downloadedFrom(url: URL)
    {
        // contentMode = mode
        URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
            else
            {
                DispatchQueue.main.async { //code
                    self.image = UIImage.init(named: "placeholder.png")
                }
                return
            }
            
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
    
    func downloadedFrom(link: String)//, contentMode mode: UIViewContentMode = .scaleAspectFit)
    {
        //print(link)
        guard let url = URL(string: link)
        else
        {
            DispatchQueue.main.async { //code
                self.image = UIImage.init(named: "placeholder.png")
            }
            return
        }
        downloadedFrom(url: url)//, contentMode: mode)
    }
}

