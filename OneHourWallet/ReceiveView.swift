//
//  ReceiveView.swift
//  OneHourWallet
//
//  Created by Daniel Nordh on 14/10/2022.
//

import SwiftUI
import BDKManager
import CoreImage.CIFilterBuiltins
import WalletUI

struct ReceiveView: View {
    @EnvironmentObject var bdkManager: BDKManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var receiveAddress: String?
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                QRView(paymentRequest: receiveAddress ?? "No address")
                Spacer()
                Button("Copy address") {
                    UIPasteboard.general.string = receiveAddress ?? "No address"
                }.buttonStyle(BitcoinFilled()).padding()
            }
            .navigationTitle("Receive bitcoin")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }.task {
            do {
                let addressInfo = try bdkManager.wallet!.getAddress(addressIndex: AddressIndex.new)
                receiveAddress = addressInfo.address
            } catch (let error){
                print(error)
            }
        }
    }
}

struct ReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveView()
    }
}

struct QRView: View {
    var paymentRequest: String
    var width = 250.0
    var height = 250.0
    
    var body: some View {
        Image(uiImage: generateQRCode(from: "bitcoin:\(paymentRequest)"))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
    }
}

func generateQRCode(from string: String) -> UIImage {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")

    if let outputImage = filter.outputImage {
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
        }
    }
    return UIImage(systemName: "xmark.circle") ?? UIImage()
}
