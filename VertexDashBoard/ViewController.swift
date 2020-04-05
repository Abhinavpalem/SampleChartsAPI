//
//  ViewController.swift
//  VertexDashBoard
//
//  Created by Abhinav reddy Palem on 3/31/20.
//  Copyright © 2020 Abhinav reddy Palem. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet var pieChartStepper: UIStepper!
    
    @IBOutlet var barChartView: BarChartView!
    @IBOutlet var barChartSlider: UISlider!
    
    // MARK: - Variables
    let viewModel = ViewModel()
    let defaultUserImage = UIImage(named: "defaultUserImage")
    var imagePicker: VTXImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pieChartView.delegate = self
        barChartView.delegate = self
        
        self.imageView.image = defaultUserImage
        self.imagePicker = VTXImagePicker(presentationController: self, delegate: self)
        
        self.viewModel.reloadData = { [weak self] in
            self?.barChartView.data = self?.viewModel.barChartData
            self?.pieChartView.data = self?.viewModel.pieChartData
            self?.pieChartView.highlightValues(nil)
        }
        pieChartStepper.value = 3
        sliderValueChanged(nil)
        pieStepperValueChanged(nil)
    }
    
    // MARK: - Actions
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func cancelImage(_ sender: UIButton) {
        self.imageView.image = defaultUserImage
    }
    
    @IBAction func sliderValueChanged(_ slider: Any?) {
        self.viewModel.setBarDataCount(Int(barChartSlider.value + 1))
    }
    
    @IBAction func pieStepperValueChanged(_ stepper: UIStepper?) {
        self.viewModel.setPieDataCount(Int(pieChartStepper.value))
    }
}

// MARK: - Extensions
extension ViewController: VTXImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.imageView.image = image ?? defaultUserImage
    }
}

extension ViewController: ChartViewDelegate {
}



