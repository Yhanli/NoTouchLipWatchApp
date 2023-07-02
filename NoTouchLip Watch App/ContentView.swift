//
//  ContentView.swift
//  NoTouchLip Watch App
//
//  Created by yuhan li on 2/07/23.
//

import SwiftUI
import CoreMotion


struct ContentView: View {
    @State private var x = 111.111
    @State private var y = 222.111
    
    var manager = CMMotionManager()

    var motionQueue = OperationQueue()
//
//    init(manager: CMMotionManager = CMMotionManager(), motionQueue: OperationQueue = OperationQueue()) {
//        self.manager = manager
//        self.motionQueue = motionQueue
//
//
//        manager.startGyroUpdates(to: motionQueue){ (data:CMGyroData?,error:Error?) in
//            guard let data = data else{
//                print("Error: \(error)")
//                return
//            }
//
//            let motion:CMRotationRate = data.rotationRate
//            manager.gyroUpdateInterval = 2
//
//            DispatchQueue.main.async {
//
//
//                print(motion.x)
//                print(motion.y)
//                print(motion.z)
//
//            }
//
//        }
//
//    }
//

    var body: some View {
        
        VStack {
            Image(systemName: "house")
                .resizable()
                .imageScale(.large)
                .foregroundColor(.accentColor)
           
            Text("\(x)")
            Text("\(y)")
                .onAppear{
                    startGyroUpdates()
                }
//            Button{
//                update()
//
//            } label: {
//                Text("Click")
//            }
        }
        .padding()
    }
    
    private func startGyroUpdates() {
        manager.startGyroUpdates(to: motionQueue) { data, error in
            guard let data = data else {
                print("Error: \(error)")
                return
            }

            let motion: CMRotationRate = data.rotationRate
            manager.gyroUpdateInterval = 2

            DispatchQueue.main.async {
                x = motion.x
                y = motion.y

                print(motion.x)
                print(motion.y)
                print(motion.z)
            }
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



