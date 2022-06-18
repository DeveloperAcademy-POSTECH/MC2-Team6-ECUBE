import SwiftUI

extension View {
    func navigationToBack( _ dismissAction: DismissAction) -> some View {
        navigationBarBackButtonHidden(true)
            .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismissAction()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    func navigationXmark( _ dismissAction: DismissAction) -> some View {
        navigationBarBackButtonHidden(true)
            .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismissAction()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                }
            }
        }
    }
}
