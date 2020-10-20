//
//  ProfileViewController.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageIndicator: UIActivityIndicatorView! {
        didSet {
            profileImageIndicator.isHidden = true
            profileImageIndicator.hidesWhenStopped = true
        }
    }
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        username.delegate = self
        
        username.text = UserDefaults.standard.string(forKey: "username")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(FavoriteJobsViewController(), animated: true)
        default:
            return
        }
    }
    @IBAction func changeProfileImage(_ sender: Any) {
        switchUserPhoto()
        profileImage.alpha = 0.5
        profileImageIndicator.isHidden = false
        profileImageIndicator.startAnimating()
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        UserDefaults.standard.set(textField.text, forKey: "username")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func switchUserPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.profileImage.image = image
//        self.roundIcon.image = image
    
//        if let currentUser = userDao.fetchAll().first {
//            currentUser.profileImage = image.pngData()
//            userDao.save()
//        }
        profileImageIndicator.stopAnimating()
        profileImage.alpha = 1
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        profileImageIndicator.stopAnimating()
        profileImage.alpha = 1
        dismiss(animated: true)
    }
}
