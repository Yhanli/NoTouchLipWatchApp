//
//  ContentView.swift
//  NoTouchLip Watch App
//
//  Created by yuhan li on 2/07/23.
//

import SwiftUI
import CoreMotion


class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    
    @Published var x = 0.0
    @Published var y = 0.0
    
    init(){
        motionManager.deviceMotionUpdateInterval = 1/5
        motionManager.startDeviceMotionUpdates(to:.main){[weak self] data, error in
            guard let motion = data?.attitude else {return}
            self?.x = motion.roll
            self?.y = motion.pitch
            
        }
    }
}

struct ContentView: View {
    @StateObject private var motion = MotionManager()
    var body: some View {
        
        VStack{
            Text("\(motion.x) : \(motion.y)")
            
            Image(systemName: "arrow.down.message.fill")
                .foregroundStyle(
                    .blue.gradient.shadow(
                        .inner(color: .black,radius: 2,x: motion.x * -10 , y: motion.y * -10)
                    )
//                    .shadow(
//                        .drop(color: .black.opacity(0.2), radius: 1, x: motion.x * 10, y: motion.y * 10)
//                    )
                )
                .font(.system(size: 100).bold())
                .rotation3DEffect(.degrees(motion.x * 5), axis: (x: 0, y: 0, z: 0))
                .rotation3DEffect(.degrees(motion.y * 5), axis: (x: -1, y: 0, z: 0))
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ContentView()
        }
    }
}



