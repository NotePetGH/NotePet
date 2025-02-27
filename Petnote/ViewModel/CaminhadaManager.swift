//
//  CaminhadaManager.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 26/02/25.
//

import SwiftUI
import CoreLocation
import MapKit
import SwiftData
import HealthKit

class CaminhadaManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private var lastLocation: CLLocation?
    private var healthStore = HKHealthStore()
    
    @Published var distance: Double = 0.0
    @Published var elapsedTime: TimeInterval = 0
    @Published var isTracking = false
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var mapPosition: MapCameraPosition = .automatic
    @Published var routeCoordinates: [CLLocationCoordinate2D] = [] // Rota da caminhada
    
    private var timer: Timer?
    private var startTime: Date?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if HKHealthStore.isHealthDataAvailable() {
            requestHealthKitPermission()
        }
    }
    
    func requestHealthKitPermission() {
        let typesToShare: Set = [
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        let typesToRead: Set = [
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            if success {
                print("Permissão concedida para o HealthKit.")
            } else {
                print("Falha ao solicitar permissão: \(String(describing: error))")
            }
        }
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startTracking() {
        let status = locationManager.authorizationStatus
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            print("Permissão negada!")
            return
        }
        
        distance = 0.0
        elapsedTime = 0
        lastLocation = nil
        routeCoordinates = []  // Reseta a rota ao iniciar
        startTime = Date()
        isTracking = true
        locationManager.startUpdatingLocation()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let start = self.startTime {
                self.elapsedTime = Date().timeIntervalSince(start)
            }
        }
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
        timer?.invalidate()
        isTracking = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        userLocation = newLocation.coordinate
        mapPosition = .region(
            MKCoordinateRegion(
                center: newLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
        
        if let last = lastLocation, isTracking {
            let distanceDelta = newLocation.distance(from: last) // Distância em metros
            distance += distanceDelta
        }
        
        if isTracking {
            routeCoordinates.append(newLocation.coordinate) // Adiciona ponto à rota
        }
        
        lastLocation = newLocation
    }
    func finalizarCaminhada(para pets: [Pet], modelContext: ModelContext) {
        guard isTracking else { return }
        
        let novaCaminhada = Caminhada(
            title: "Caminhada",
            distance: distance,
            time: elapsedTime,
            date: Date(),
            route: routeCoordinates
        )
        for pet in pets {
            pet.caminhadas.append(novaCaminhada)
            novaCaminhada.pets.append(pet)
        }
        
        modelContext.insert(novaCaminhada) // Salva no banco
        salvarCaminhadaNoHealthKit(distance: distance, duration: elapsedTime)
        stopTracking() // Para o rastreamento
    }
    func salvarCaminhadaNoHealthKit(distance: Double, duration: TimeInterval) {
        guard let walkingRunningType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            print("Tipo de dado não encontrado")
            return
        }
        
        // Defina a quantidade de distância
        let distanceQuantity = HKQuantity(unit: .meter(), doubleValue: distance) // Distância em metros
        
        // Registre a caminhada
        let now = Date()
        let startDate = now.addingTimeInterval(-duration)
        let endDate = now
        
        let workout = HKWorkout(activityType: .walking, start: startDate, end: endDate, workoutEvents: [], totalEnergyBurned: nil, totalDistance: distanceQuantity, metadata: nil)
        
        // Salvar o workout no HealthKit
        healthStore.save(workout) { success, error in
            if success {
                print("Caminhada salva com sucesso no HealthKit!")
            } else {
                print("Falha ao salvar no HealthKit: \(String(describing: error))")
            }
        }
    }
}
