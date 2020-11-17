//
//  ViewController.swift
//  Homework 36
//
//  Created by Nino Mekhashishvilii on 6/8/20.
//  Copyright © 2020 Nino Mekhashishvili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var LastnextButton: UIButton!

    
    var tempIndex:CGFloat?
    var x = 1
    
    
    let images = ["pic1", "pic2","pic3","pic4"]
    let topics = ["Online shopping","Add to cart","Payment Successful","Make Payment"]
    let details = [
        "Women Fashion Shopping Online - Shop from a huge range of latest women clothing, shoes, makeup Kits, Watches, footwear and more for women at best price",
        "Add to cart button works on product pages. The customizations in this section  compatible with dynamic checkout buttons",
        "Your payment has been successfully completed. You will receive a confirmation email within a few minutes. ",
        "An online payment gateway acts as a virtual terminal for online transactions."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        LastnextButton.layer.cornerRadius = 10
        LastnextButton.isHidden = true
    }

    @IBAction func onSkip(_ sender: Any) {
        let index = IndexPath(item: 3, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        buttonsStackView.isHidden = true
        LastnextButton.isHidden = false
        
    }
    @IBAction func onNext(_ sender: Any) {
        if x < 4 {
            let newx = IndexPath(item: x, section: 0)
            collectionView.scrollToItem(at: newx, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = Int(x)
            x += 1
        }
        if x == 4 {
            LastnextButton.isHidden = false
            buttonsStackView.isHidden = true
        }
      
    }
    
}

extension ViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath) as! PageCell
        cell.mainImageView.image = UIImage(named: images[indexPath.row])
        cell.topic.text = topics[indexPath.row]
        cell.detailInfo.text = details[indexPath.row]
        if indexPath.row == 3 {
            cell.greenBackground.isHidden = false
        } else {
            cell.greenBackground.isHidden = true
        }
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height - 70)
    }
}


extension ViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
          let offset = targetContentOffset.pointee
          let x = offset.x
          let pageIndex = x / collectionView.frame.width
          pageControl.currentPage = Int(pageIndex)
          self.tempIndex = pageIndex
          self.x = Int(pageIndex + 1)
          
        
          if pageIndex >= 3 {
            buttonsStackView.isHidden = true
            LastnextButton.isHidden = false
            
          } else {
            buttonsStackView.isHidden = false
            LastnextButton.isHidden = true
          }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

