//
//  ExportView.swift
//  SimpleBudget
//
//  Created by Mason Li on 5/23/25.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

// File exporting logic modified from the following tutorial
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-export-files-using-fileexporter

struct ExportView: View {
    @State private var showingExporter = false
    @Query var expenses: [Expense]

    private var exportText: String {
        var csv = "Date,Amount,Category\n"
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        for expense in expenses {
            let dateString = formatter.string(from: expense.date)
            let amountString = String(format: "%.2f", expense.amount)
            csv += "\(dateString),\(amountString),\(expense.category)\n"
        }
        return csv
    }
    
    var body: some View {
        VStack {
            Text("Export Data")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Text("Save your expense data as a CSV file.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)

            Button("Export to File", systemImage: "square.and.arrow.up") {
                showingExporter = true
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
        }
        .padding(20)
        .fileExporter(isPresented: $showingExporter,
                      document: TextFile(initialText: exportText),
                      contentType: UTType.commaSeparatedText,
                      defaultFilename: "expenses.csv") { result in
            switch result {
            case .success(let url):
                print("Saved to \(url)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct TextFile: FileDocument {
    // tell the system we support only CSV text
    static var readableContentTypes = [UTType.commaSeparatedText]

    // by default our document is empty
    var text = ""

    // a simple initializer that creates new, empty documents
    init(initialText: String = "") {
        text = initialText
    }

    // this initializer loads data that has been saved previously
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }

    // this will be called when the system wants to write our data to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}

#Preview {
    ExportView()
}
