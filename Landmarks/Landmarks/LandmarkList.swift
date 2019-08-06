//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Calvin on 2019/8/6.
//  Copyright © 2019 Calvin. All rights reserved.
//

import SwiftUI

struct LandmarkList : View {
    var body: some View {
        NavigationView {
            List(landmarkData) { landmark in
                LandmarkRow(landmark: landmark)
            }
            .navigationBarTitle(Text("Landmarks"))
        }
    }
}

#if DEBUG
struct LandmarkList_Previews : PreviewProvider {
    static var previews: some View {
        LandmarkList()
    }
}
#endif
