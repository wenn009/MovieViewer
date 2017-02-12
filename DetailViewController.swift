//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Wenn Huang on 2/6/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var inforView: UIView!
    
    
    @IBOutlet weak var overview: UILabel!
    
    var movie : NSDictionary!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: inforView.frame.origin.y + inforView.frame.size.height)
        
        let title = movie["title"] as! String
        titleLabel.text = title
        titleLabel.sizeToFit()
        let ov = movie["overview"] as! String
        overview.text = ov
        overview.sizeToFit()
        
        if let posterPath = movie["poster_path"] as? String{
            /*let baseUrl = "https://image.tmdb.org/t/p/w500"
            let imageUrl = NSURL(string: baseUrl + posterPath)
        
            posterImageView.setImageWith(imageUrl! as URL)*/
            let smallImageUrl = NSURL(string: "https://image.tmdb.org/t/p/w45"+posterPath)
            let largeImageUrl = NSURL(string:"https://image.tmdb.org/t/p/original"+posterPath)
            
            let smallImageRequest = NSURLRequest(url:smallImageUrl as! URL)
            let largeImageRequest = NSURLRequest(url:largeImageUrl as! URL)
            
            //let imageUrl = NSURL(string: baseUrl + posterPath)
            
            //posterImageView.setImageWith(imageUrl! as URL)
            
        posterImageView.setImageWith(smallImageRequest as URLRequest, placeholderImage: nil, success: {(smallImageRequest, smallImageResponse, smallImage) -> Void in
            
            
            self.posterImageView.alpha = 0.0
            self.posterImageView.image = smallImage
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
                self.posterImageView.alpha = 1.0
            
            }, completion: { (sucess) -> Void in
                
                self.posterImageView.setImageWith(largeImageRequest as URLRequest,
                    placeholderImage: smallImage,
                    success: {
                        (largeImageRequest, LargeImageResponse, largeImage) ->Void in
                        self.posterImageView.image = largeImage;
                
                },failure: {(request, response, error) -> Void in
                })
            })
        },
    failure: { (request, response, error) -> Void in
        
        })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    
        
        
        
        
        
        
     
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/


}
