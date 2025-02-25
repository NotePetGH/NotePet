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
        VStack(spacing: 30) {
            
            HStack {
                Text("Salvar")
                    .font(.system(size: 17, weight: .bold))
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
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.accent)
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.top, 25)
            
            // Photo Picker, campos de texto e pickers
            ScrollView {
                VStack(spacing: 20) {
                    // Camera Image
                    PhotosPicker(selection: $photoViewModel.imageSelection) {
                        if let selectedImage = photoViewModel.selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        } else {
                            VStack {
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
                                .foregroundStyle(.accent)
                                
                                Text("Selecione uma foto")
                                    .font(.subheadline)
                            }
                        }
                        
                    }
                    // Nome, data e pickers
                    VStack(spacing: 15) {
                        // Name Text Field
                        TextFieldComponent(title: "Nome", textFieldTitle: "Digite o nome do pet", spacing: 5, textInput: $name)
                    
                        
                        // Date Picker
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Data de nascimento")
                                .fontWeight(.medium)
                                .padding(.horizontal)
                            
                            HStack {
                                Text("Selecione a data")
                                    .foregroundStyle(Color(.systemGray2))
                                    .padding(.leading)
                                
                                Spacer()
                                
                                DatePicker("\(birthdate.formatted(date: .long, time: .omitted))", selection: $birthdate, in: ...Date(), displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .foregroundStyle(.accent)
                                    .padding()
                            }
                            .padding(.vertical, -4)
                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Animal")
                                .fontWeight(.medium)
                                .padding(.horizontal)
                            HStack {
                                Text("Selecione o animal")
                                    .foregroundStyle(Color(.systemGray2))
                                Spacer()
                                Picker("Animal", selection: $animal) {
                                    Text("Gato").tag(1)
                                    Text("Cachorro").tag(2)
                                }
                                .pickerStyle(.menu)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Raça")
                                .fontWeight(.medium)
                                .padding(.horizontal)
                            HStack {
                                Text("Selecione a raça")
                                    .foregroundStyle(Color(.systemGray2))
                                Spacer()
                                Picker("Raça", selection: $breed) {
                                    if animal == 1 {
                                        Text("SRD").tag(1)
                                        Text("Persa").tag(2)
                                    } else if animal == 2 {
                                        Text("Vira-lata").tag(1)
                                        Text("Labrador").tag(2)
                                    }
                                    
                                }
                                .pickerStyle(.menu)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Sexo")
                                .fontWeight(.medium)
                                .padding(.horizontal)
                            HStack {
                                Text("Selecione o sexo")
                                    .foregroundStyle(Color(.systemGray2))
                                Spacer()
                                Picker("Sexo", selection: $gender) {
                                    Text("Macho").tag(1)
                                    Text("Fêmea").tag(2)
                                }
                                .pickerStyle(.menu)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

#Preview {
    AddPetView()
        .modelContainer(for: Pet.self)
}

