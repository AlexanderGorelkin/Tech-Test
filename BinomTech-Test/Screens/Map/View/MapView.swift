//
//  MainView.swift
//  BinomTech-Test
//
//  Created by Александр Горелкин on 11.03.2024.
//

import UIKit
import MapKit
protocol MapViewProtocol: AnyObject {
    func setupAnnotation(with annotation: MKAnnotation)
    func setRegion(_ region: MKCoordinateRegion)
    func deselectAnnotation(_ annotation: MKAnnotation?)
}
final class MapView: UIViewController {
    var viewModel: MapViewModel?
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.delegate = self
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.showsUserLocation = true
        map.mapType = .standard
        return map
    }()
    private lazy var currentUserLocationButton = CustomButton(imageName: "location",
                                                              action: #selector(userLocationButtonDidTaped))
    private lazy var minusButton: UIButton = CustomButton(imageName: "minus",
                                                          action: #selector(minusButtonDidTapped))
    private lazy var plusButton: UIButton = CustomButton(imageName: "plus",
                                                         action: #selector(plusButtonDidTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel?.viewDidLoaded()
        setupMap()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidAppear()
    }
    private func setupMap() {
        view.addView(mapView)
        mapView.addView(currentUserLocationButton)
        mapView.addView(plusButton)
        mapView.addView(minusButton)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            currentUserLocationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentUserLocationButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            minusButton.bottomAnchor.constraint(equalTo: currentUserLocationButton.topAnchor, constant: -10),
            minusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            plusButton.bottomAnchor.constraint(equalTo: minusButton.topAnchor, constant: -10),
            plusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        ])
    }
}
// MARK:  MapViewProtocol
extension MapView: MapViewProtocol {
    func setupAnnotation(with annotation: MKAnnotation) { mapView.addAnnotation(annotation) }
    func setRegion(_ region: MKCoordinateRegion) { mapView.setRegion(region, animated: true) }
    func deselectAnnotation(_ annotation: MKAnnotation?) { mapView.deselectAnnotation(annotation, animated: true) }
}
// MARK:  Buttons actions
@objc extension MapView {
    func plusButtonDidTapped(_ sender: UIButton) { viewModel?.plusButtonDidTapped(region: mapView.region) }
    func minusButtonDidTapped(_ sender: UIButton) { viewModel?.minusButtonDidTapped(region: mapView.region) }
    func userLocationButtonDidTaped(_ sender: UIButton) { viewModel?.userLocationButtonDidTaped(with: mapView.userLocation) }
}
// MARK:  MKMapViewDelegate
extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) { viewModel?.didSelectAnnotationView(annotationView: view) }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? { viewModel?.createAnnotationView(viewFor: annotation) }
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) { viewModel?.didChangeVisibleRegion(mapView)  }
}
// MARK:  UIAdaptivePresentationControllerDelegate
extension MapView: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) { viewModel?.presentationControllerDidDismiss() }
}

