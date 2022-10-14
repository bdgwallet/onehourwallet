//
//  HomeView.swift
//  OneHourWallet
//
//  Created by Daniel Nordh on 14/10/2022.
//

import SwiftUI
import WalletUI
import BDKManager

struct HomeView: View {
    @EnvironmentObject var bdkManager: BDKManager
    
    @State private var showReceiveSheet = false
    @State private var showSendSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Balance")
            switch bdkManager.syncState {
            case .synced:
                Text(bdkManager.balance.total.description + " sats")
            case .syncing:
                Text("Syncing")
            default:
                Text("Not synced")
            }
            Spacer()
            HStack {
                Button("Send") {
                    showSendSheet.toggle()
                }.buttonStyle(BitcoinFilled(width: 150))
                    .sheet(isPresented: $showSendSheet) {
                        SendView().environmentObject(bdkManager)
                    }
                Button("Receive") {
                    showReceiveSheet.toggle()
                }.buttonStyle(BitcoinFilled(width: 150))
                    .sheet(isPresented: $showReceiveSheet) {
                        ReceiveView().environmentObject(bdkManager)
                    }
            }.padding(32)
        }.task {
            bdkManager.startSyncRegularly(interval: 30)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
