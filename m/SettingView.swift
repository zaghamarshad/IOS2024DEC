import SwiftUI

struct SettingView: View {
    @State private var email = "zaghamarshad@yahoo.com"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                // Email Section
                Text(email)
                    .font(.title3)
                    .padding(.horizontal)
                
                // Preparing For Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("I'm preparing for")
                        .font(.title3)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        // Exam Card
                        VStack(alignment: .leading, spacing: 8) {
                            Text("EC-Council® CEH™")
                                .font(.title2)
                                .bold()
                            
                            Text("Certified Ethical Hacker™")
                                .font(.title3)
                                .foregroundColor(.gray)
                            
                            Text("Free Study Progress • 0 / 30 Questions")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(12, corners: [.topLeft, .topRight])
                        
                        // Exam Settings Button
                        Button(action: {
                            // Handle exam settings
                        }) {
                            HStack {
                                Text("Exam Settings")
                                    .foregroundColor(Color(UIColor.systemYellow))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(UIColor.systemGray6))
                        }
                        
                        // Switch Exam Button
                        Button(action: {
                            // Handle switch exam
                        }) {
                            Text("Switch Exam")
                                .foregroundColor(Color(UIColor.systemYellow))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color(UIColor.systemGray6))
                        }
                        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                    }
                }
                .padding(.horizontal)
                
                // Study Plan Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Study Plan")
                        .font(.title3)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        // Free Pocket Prep Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Free Pocket Prep")
                                .font(.title2)
                                .bold()
                            
                            VStack(alignment: .leading, spacing: 12) {
                                BulletPoint(text: "Question of the Day")
                                BulletPoint(text: "30 Questions (of 1500 Question Bank)")
                                BulletPoint(text: "3 of 6 Quiz Modes")
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(12, corners: [.topLeft, .topRight])
                        
                        // Upgrade Button
                        Button(action: {
                            // Handle upgrade
                        }) {
                            Text("Upgrade to Premium")
                                .foregroundColor(Color(UIColor.systemYellow))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color(UIColor.systemGray6))
                        }
                        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Offline Status
                Text("You are offline")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Search")
                        .foregroundColor(.gray)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text("11:02 AM")
                        Text("62%")
                        Image(systemName: "battery.50")
                    }
                    .foregroundColor(.gray)
                }
            }
        }
    }
}

// Helper Views
struct BulletPoint: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .foregroundColor(.gray)
            Text(text)
                .foregroundColor(.gray)
        }
    }
}

// Helper extension for rounded corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
