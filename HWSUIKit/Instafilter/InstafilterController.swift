//
//  InstafilterController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-13.
//

import CoreImage
import UIKit

class InstafilterController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var sliderButton: UIButton!
    var currentSliderValue: String?
    var currentImage: UIImage!
    
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "Instafilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
        setupSliderButton()
    }
    
    @objc
    private func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        present(ac, animated: true)
    }
    
    private func setFilter(action: UIAlertAction) {
        guard currentImage != nil else {
            let ac = UIAlertController(title: "Select an image", message: "Please select an image to which you want to apply a filter", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        guard let actionTitle = action.title else { return }
        
        currentFilter = CIFilter(name: actionTitle)
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        filterButton.setTitle(action.title, for: .normal)
        
        
        setupSliderButton()
        applyProcessing()
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else {
            let ac = UIAlertController(title: "Select an image", message: "There is no image to save", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @IBAction func intensityChange(_ sender: Any) {
        applyProcessing()
    }
    
    private func applyProcessing() {
        let inputKey = currentSliderValue
        
        if inputKey == kCIInputIntensityKey {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        
        if inputKey == kCIInputRadiusKey {
            currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKey == kCIInputScaleKey {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKey == kCIInputCenterKey {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }
    
    @objc
    private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    private func setupSliderButton() {
        // Set initial slider value when changing filter (and when entering screen).
        let inputKey = currentFilter!.inputKeys.first(where: { $0 != kCIInputImageKey && $0 != kCIInputCenterKey && $0 != kCIInputAngleKey })
        currentSliderValue = inputKey
        
        // Set CenterKey to middle of image if applicable.
        if currentFilter!.inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }
        
        // Set initial slider button title to match initial slider value.
        let sliderButtonTitle = inputKey?.description
        sliderButton.setTitle(sliderButtonTitle, for: .normal)
        
        // Setup menu items for changing slider value. Filter out keys for values not working with slider.
        var menuItems = [UIAction]()
        for key in currentFilter!.inputKeys where key != kCIInputImageKey && key != kCIInputCenterKey && key != kCIInputAngleKey {
            let keyText = key.description
            let labelText = keyText.dropFirst(5).description // Drops the 'input' prefix of the inputKey's name
            menuItems.append(UIAction(title: labelText, image: nil, handler: { [weak self] _ in
                self?.sliderButton.setTitle(labelText, for: .normal)
                self?.currentSliderValue = key
            }))
        }
        sliderButton.menu = UIMenu(title: "Filters", image: nil, identifier: nil, options: [], children: menuItems)
    }
}
