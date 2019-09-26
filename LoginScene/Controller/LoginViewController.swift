//
//  ViewController.swift
//  LoginScene
//
//  Created by Vikhyath on 02/08/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
    let loginviewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginCollectionview.delegate = self
        loginCollectionview.dataSource = self
        NotificationCenter.default.addObserver(forName: UIWindow.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] (notification) in
            guard let userInfo = notification.userInfo, let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue,let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
            
            UIView.animate(withDuration: animationDuration.doubleValue, animations: {
                self?.collectionViewBottomConstraint.constant = keyboardFrame.size.height
                self?.view.layoutIfNeeded()
            })
        }
        
        NotificationCenter.default.addObserver(forName: UIWindow.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] (notification) in
            guard let userInfo = notification.userInfo, let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
            
            UIView.animate(withDuration: animationDuration.doubleValue, animations: {
                self?.collectionViewBottomConstraint.constant = 0
                self?.view.layoutIfNeeded()
            })
            
        }
        
        loginCollectionview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        if let layout = loginCollectionview.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        
    }
    
    @objc func handleTap() {
       
        (UIApplication.shared.delegate as? AppDelegate)?.window?.endEditing(true)
        //loginCollectionview.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginCollectionview.endEditing(true)
    }
    
    @IBOutlet weak var loginCollectionview: UICollectionView!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return loginviewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return loginviewModel.sections[section].rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = loginviewModel.reuseIdentifier(for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: loginviewModel.row(for: indexPath))
        }
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = loginviewModel.heightOfRow(at: indexPath, viewHeight: view.frame)
        
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        // For iphone SE and 4s.
        if view.frame.height <= 568.0 {
            let height = (section == 2) ? 20 : (section == 1) ? 10 : view.frame.height * 0.22
            return CGSize(width: collectionView.frame.width, height: height)
        }
        
        let headersize = loginviewModel.referencesizeforHeader(in: section)
        
        return headersize
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
                return UICollectionReusableView()
            }
            header.frbLogo.isHidden = (indexPath.section != 0)
            return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return view.frame.height <= 568.0 ? 5 : 0.0246 * view.frame.height

    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let top: CGFloat = (section == 0) ? 20 : 0
        return UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.y)
    }
    
    @objc func handleSignIn() {
        
    }
}

