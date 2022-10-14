//
//  SendView.swift
//  OneHourWallet
//
//  Created by Daniel Nordh on 14/10/2022.
//

import SwiftUI
import BDKManager
import WalletUI

struct SendView: View {
    @EnvironmentObject var bdkManager: BDKManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var address: String = ""
    @State private var submitted: Bool?
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("Enter address", text: $address).padding(32)
                Spacer()
                if submitted == false {
                    Text("Error submitting transaction")
                } else if submitted == true {
                    Text("Transaction submitted")
                }
                Spacer()
                Button("Send bitcoin") {
                    submitted = bdkManager.sendBitcoin(recipient: address, amount: 21000, feeRate: 1000)
                }.buttonStyle(BitcoinFilled()).padding()
            }.navigationTitle("Send bitcoin")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
        }
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
