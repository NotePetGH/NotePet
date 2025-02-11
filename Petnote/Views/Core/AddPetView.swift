//
//  AddPetView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI
import PhotosUI

@MainActor
final class PhotoPickerViewModel: ObservableObject {
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem?  = nil {
        didSet {
            setImage(from: imageSelection)        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    return
                }
            }
        }
    }
}
struct AddPetView: View {
    @StateObject private var photoViewModel = PhotoPickerViewModel()
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var name = ""
    @State var birthdate = Date()
    @State var animal: Int = 1
    @State var breed: Int = 1
    @State var gender: Int = 1
    
    func convertAnimal(_ number: Int) -> String {
        switch number {
        case 1:
            return "Gato"
        case 2:
            return "Cachorro"
        default:
            return "Animal não especificado."
        }
    }
    
    func convertGender(_ number: Int) -> String {
        switch number {
        case 1:
            return "Macho"
        case 2:
            return "Fêmea"
        default:
            return "Gênero não especificado"
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Text("Salvar")
                    .foregroundStyle(.white)
                Spacer()
                Text("Adicionar pet")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                
                Button {
                    if let selectedImage = photoViewModel.selectedImage {
                        let pet = Pet(name: name, age: Int(birthdate.timeIntervalSinceNow / -31536000), imageURL: selectedImage, animal: convertAnimal(animal), gender: convertGender(gender), vacinas: [], consultas: [], remedios: [])
                        withAnimation(.snappy) {
                            modelContext.insert(pet)
                            dismiss()
                        }
                    }
                    
                    
                } label: {
                    Text("Salvar")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black)
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.top, 18)
            
            // Photo Picker, campos de texto e pickers
            VStack(spacing: 10) {
                // Camera Image
                PhotosPicker(selection: $photoViewModel.imageSelection) {
                    if let selectedImage = photoViewModel.selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        ZStack {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            Image(systemName: "circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .fontWeight(.thin)
                        }
                        .foregroundStyle(Color(red: 1, green: 0.72, blue: 0.29))
                    }
                    
                }
                // Nome, data e pickers
                VStack(spacing: 25) {
                    // Name Text Field
                    TextFieldComponent(title: "Nome", textFieldTitle: "", spacing: 8, textInput: $name)
                    
                    // Date Picker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Data de nascimento")
                            .fontWeight(.medium)
                            .padding(.horizontal)
                        
                        HStack {
                            DatePicker("\(birthdate.formatted(date: .long, time: .omitted))", selection: $birthdate, in: ...Date(), displayedComponents: .date)
                                .labelsHidden()
                                .padding()
                            
                            Spacer()
                            
                            Image(systemName: "calendar")
                                .padding(.horizontal)
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(Color(red: 1, green: 0.91, blue: 0.49), lineWidth: 1.5)
                        }
                        
                    }
                    HStack {
                        Text("Animal")
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                        Picker("Animal", selection: $animal) {
                            Text("Gato").tag(1)
                            Text("Cachorro").tag(2)
                        }
                        .pickerStyle(.menu)
                    }
                    .padding()
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    HStack {
                        Text("Raça")
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                        Picker("Raça", selection: $breed) {
                            if animal == 1 {
                                Text("Sem Raça Definida").tag(1)
                                Text("Persa").tag(2)
                            } else if animal == 2 {
                                Text("Vira-lata").tag(1)
                                Text("Labrador").tag(2)
                            }
                            
                        }
                        .pickerStyle(.menu)
                    }
                    .padding()
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    HStack {
                        Text("Sexo")
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                        Picker("Sexo", selection: $gender) {
                            Text("Macho").tag(1)
                            Text("Fêmea").tag(2)
                        }
                        .pickerStyle(.menu)
                    }
                    .padding()
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                }
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    AddPetView()
        .modelContainer(for: Pet.self)
}

