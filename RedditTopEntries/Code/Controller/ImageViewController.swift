//
//  ImageViewController.swift
//  RedditTopEntries
//
//  Created by Rodrigo De Santiago on 9/13/19.
//  Copyright © 2019 Rodrigo De Santiago. All rights reserved.
//

import UIKit
import WebKit

class ImageViewController: UIViewController {

    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var webview: WKWebView!
    
    var imageUrl:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.entryImage.isHidden = true
        self.webview.isHidden = false
        if let url = URL(string: imageUrl) {
            loadContent(url: url)
        }
    }
    
    
    func loadContent(url:URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async() {
                        self.webview.load(URLRequest.init(url: url))
                    }
                    return
            }
            DispatchQueue.main.async() {
                self.entryImage.isHidden = false
                self.webview.isHidden = true
                self.entryImage.image = image
            }
            }.resume()
        
    }
    
    
    @IBAction func saveImage(_ sender: Any) {
        if webview.isHidden {
            if let image = entryImage.image {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        } else {
            
            let layer = UIApplication.shared.keyWindow!.layer
            let scale = UIScreen.main.scale
            
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
            layer.render(in: UIGraphicsGetCurrentContext()!)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved", message: "This image is saved.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    

}
