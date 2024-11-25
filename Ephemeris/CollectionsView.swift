//
//  CollectionsView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI

struct Collection: Identifiable {
    let id = UUID()
    var title: String
    var bookCount: Int
}

struct CollectionsView: View {
    // Mock de dados
    @State private var collections = [
        Collection(title: "Ficção Científica", bookCount: 12),
        Collection(title: "Romance", bookCount: 8),
        Collection(title: "História", bookCount: 5)
    ]

    @State private var showingAddCollectionModal = false
    @State private var showingEditCollectionModal = false
    @State private var selectedCollection: Collection? = nil

    var body: some View {
        NavigationView {
            VStack {
                if collections.isEmpty {
                    Text("Nenhuma coleção criada.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                            ForEach(collections) { collection in
                                CollectionCardView(
                                    collection: collection,
                                    onEdit: { editCollection(collection) },
                                    onDelete: { deleteCollection(collection) }
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Coleções")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddCollectionModal = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddCollectionModal) {
                AddCollectionView { newCollection in
                    collections.append(newCollection)
                }
            }
            .sheet(item: $selectedCollection) { collection in
                EditCollectionView(collection: collection) { updatedCollection in
                    if let index = collections.firstIndex(where: { $0.id == updatedCollection.id }) {
                        collections[index] = updatedCollection
                    }
                }
            }
        }
    }

    private func editCollection(_ collection: Collection) {
        selectedCollection = collection
    }

    private func deleteCollection(_ collection: Collection) {
        withAnimation {
            collections.removeAll { $0.id == collection.id }
        }
    }
}

struct CollectionCardView: View {
    let collection: Collection
    var onEdit: () -> Void
    var onDelete: () -> Void

    var body: some View {
        VStack {
            Text(collection.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            Text("\(collection.bookCount) livro(s)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()

            HStack {
                Button(action: onEdit) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                }
                .buttonStyle(BorderlessButtonStyle())

                Spacer()

                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
        .padding()
        .frame(height: 150)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct AddCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var collectionName = ""

    var onAdd: (Collection) -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Nome da coleção", text: $collectionName)
            }
            .navigationTitle("Nova Coleção")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Adicionar") {
                        let newCollection = Collection(title: collectionName, bookCount: 0)
                        onAdd(newCollection)
                        dismiss()
                    }
                    .disabled(collectionName.isEmpty)
                }
            }
        }
    }
}

struct EditCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @State var collection: Collection
    var onEdit: (Collection) -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Nome da coleção", text: $collection.title)
            }
            .navigationTitle("Editar Coleção")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        onEdit(collection)
                        dismiss()
                    }
                    .disabled(collection.title.isEmpty)
                }
            }
        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
