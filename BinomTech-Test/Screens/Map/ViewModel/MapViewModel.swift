//
//  MapViewModel.swift
//  BinomTech-Test
//
//  Created by Александр Горелкин on 11.03.2024.
//
import CoreLocation
import MapKit

protocol ButtonsActionProtocol {
    func userLocationButtonDidTaped(with userLocation: MKUserLocation)
    func plusButtonDidTapped(region: MKCoordinateRegion)
    func minusButtonDidTapped(region: MKCoordinateRegion)
}
protocol MapActionsProtocol {
    func didChangeVisibleRegion(_ mapView: MKMapView)
    func createAnnotationView(viewFor annotation: MKAnnotation) -> MKAnnotationView?
    func didSelectAnnotationView(annotationView: MKAnnotationView)
    func setupAnnotations(with persons: [Location])
    func presentationControllerDidDismiss()
}
protocol MapViewModelProtocol: ButtonsActionProtocol, MapActionsProtocol {
    var view: MapView? { get }
    var locations: [Location] { get set }
    func viewDidLoaded()
}
// MARK:  MapViewModelProtocol
final class MapViewModel: MapViewModelProtocol {
    weak var view: MapView?
    var locations: [Location] = []
    private var selectedAnnotation: MKAnnotation?
    init(view: MapView? = nil) {
        self.view = view
    }
    func viewDidLoaded() {
        locations = LocationsDataService.locations
        setupAnnotations(with: locations)
    }
    func viewDidAppear() {
        view?.setRegion(MKCoordinateRegion(center: .init(latitude: 55.751749, longitude: 37.620602), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
    }
    
}
// MARK:  ButtonsActionProtocol
extension MapViewModel  {
    func userLocationButtonDidTaped(with userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        view?.setRegion(region)
    }
    func plusButtonDidTapped(region: MKCoordinateRegion) {
        var newRegion = region
        newRegion.span.latitudeDelta /= 2.0
        newRegion.span.longitudeDelta /= 2.0
        view?.setRegion(newRegion)
    }
    func minusButtonDidTapped(region: MKCoordinateRegion) {
        var newRegion = region
        newRegion.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
        newRegion.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
        view?.setRegion(newRegion)
    }
}
// MARK:  MapActionsProtocol
extension MapViewModel {
    func didChangeVisibleRegion(_ mapView: MKMapView) {
        mapView.annotations.forEach {
            guard let annotationView = mapView.view(for: $0) else { return }
            let scale = -1 * sqrt(1 - pow(mapView.zoomLevel / 19, 2.0)) + 1.4
            annotationView.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
        }
    }
    func createAnnotationView(viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let mkView = CustomAnnotationView(annotation: annotation, reuseIdentifier: "mkView")
        return mkView;
    }
    func didSelectAnnotationView(annotationView: MKAnnotationView) {
        self.selectedAnnotation = annotationView.annotation
        let detailView = DetailView()
        let detailViewModel = DetailViewModel(view: detailView, location: locations.first(where: { $0.id == annotationView.annotation?.title }))
        detailView.viewModel = detailViewModel
        if let sheet = detailView.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        view?.present(detailView, animated: true, completion: nil)
    }
    func setupAnnotations(with persons: [Location]) {
        persons.forEach { person in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: person.coordinates.latitude, longitude: person.coordinates.longitude)
            annotation.title = person.id
            self.view?.setupAnnotation(with: annotation)
        }
    }
    func presentationControllerDidDismiss() {
        view?.deselectAnnotation(selectedAnnotation)
        selectedAnnotation = nil
    }
}
