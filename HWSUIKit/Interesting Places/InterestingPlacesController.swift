//
//  InterestingPlacesController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-11.
//

import UIKit

class InterestingPlacesController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    var places = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        places = defaults.object(forKey: "places") as? [Place] ?? [Place]()

        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePicture)), self.editButtonItem]
        
        tableView.register(PlaceCell.self, forCellReuseIdentifier: "Place")
        
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
            longPressGesture.minimumPressDuration = 1.0 // 1 second press
            longPressGesture.delegate = self
            self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {

        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {

            let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let place = places[indexPath.row]
                let ac = UIAlertController(title: "Rename place", message: nil, preferredStyle: .alert)
                ac.addTextField()
                
                let renameAction = UIAlertAction(title: "Rename", style: .default) { [weak self, weak ac] _ in
                    guard let newName = ac?.textFields?[0].text else { return }
                    place.name = newName
                    self?.tableView.reloadData()
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                
                ac.addAction(renameAction)
                ac.addAction(cancelAction)
                present(ac, animated: true)
            }
        }
    }
    
    @objc
    func takePicture() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
        } else {
            let ac = UIAlertController(title: "No camera available",
                                       message: "You can not take a picture because this device has no camera available.",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = InterestingPlacesController.getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let place = Place(name: "Unknown", picture: imageName)
        places.append(place)
        save()
        tableView.reloadData()
        
        dismiss(animated: true )
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(places) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "places")
        } else {
            print("Could not save places")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Place", for: indexPath) as? PlaceCell else {
            fatalError()
        }
        
        let place = places[indexPath.row]
        cell.place = place
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let path = InterestingPlacesController.getDocumentsDirectory().appendingPathComponent(place.picture)
        imageView.image = UIImage(contentsOfFile: path.path)
        let pictureVC = PictureViewController(imageView: imageView)
        navigationController?.pushViewController(pictureVC, animated: true)
    }
}
