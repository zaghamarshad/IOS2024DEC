//
//  ContentView.swift
//  m
//
//  Created by Zagham Arshad on 2024-12-04.
//


import SwiftUI

struct CalendarDate: Identifiable {
    let id = UUID()
    let date: Date
    var isStudied: Bool = false
}

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Study View
            StudyView()
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Study")
                }
                .tag(0)
            
            // Stats View
            Text("Stats View")
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Stats")
                }
                .tag(1)
            
            // Review View
            Text("Review View")
                .tabItem {
                    Image(systemName: "book")
                    Text("Review")
                }
                .tag(2)
            
            // Settings View
            SettingView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Settings")
                }
                .tag(3)
        }
    }
}

// Move all the study-related content to a separate view
struct StudyView: View {
    // State variables for tracking
    @State private var selectedTab = "All Studying"
    @State private var dayStreak = 0
    @State private var calendarDates: [CalendarDate] = []
    @State private var currentWeek: Date = Date()
    
    // Calendar data
    let weekDays = ["S", "M", "T", "W", "T", "F", "S"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("EC-Council®")
                        .font(.headline)
                    Text("CEH™")
                        .font(.title2)
                        .bold()
                    
                    Text("Good Morning")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    Text("Fact: the earth is round. Also fact: you've got this.")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                // Study Tracking Section
                VStack(spacing: 16) {
                    // Tab buttons
                    HStack {
                        Button("All Studying") {
                            selectedTab = "All Studying"
                        }
                        .foregroundColor(selectedTab == "All Studying" ? .primary : .secondary)
                        
                        Button("QotD") {
                            selectedTab = "QotD"
                        }
                        .foregroundColor(selectedTab == "QotD" ? .primary : .secondary)
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "bolt.fill")
                            Text("\(dayStreak) Day Streak")
                        }
                        .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // Calendar Navigation
                    HStack {
                        Button(action: previousWeek) {
                            Image(systemName: "chevron.left")
                        }
                        Spacer()
                        Button(action: nextWeek) {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .padding(.horizontal)
                    
                    // Calendar grid
                    VStack(spacing: 12) {
                        // Week days
                        HStack {
                            ForEach(weekDays, id: \.self) { day in
                                Text(day)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                        }
                        
                        // Dates grid
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                            ForEach(calendarDates) { calendarDate in
                                let calendar = Calendar.current
                                let day = calendar.component(.day, from: calendarDate.date)
                                let isToday = calendar.isDate(calendarDate.date, inSameDayAs: Date())
                                
                                Text("\(day)")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(isToday ? Color.blue.opacity(0.2) : nil)
                                    .overlay(
                                        Circle()
                                            .fill(calendarDate.isStudied ? Color.white : Color.clear)
                                            .frame(width: 8, height: 8)
                                            .offset(y: 12)
                                    )
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(isToday ? Color.blue : Color.clear, lineWidth: 1)
                                    )
                                    .onTapGesture {
                                        if let index = calendarDates.firstIndex(where: { $0.id == calendarDate.id }) {
                                            calendarDates[index].isStudied.toggle()
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .onAppear {
                    generateCalendarDates()
                }
                
                // Key
                HStack {
                    Image(systemName: "line.3.horizontal")
                    Text("Key:")
                    Circle()
                        .fill(Color.white)
                        .frame(width: 12, height: 12)
                    Text("Studied")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                
                // Subscribe Button
                Button(action: {
                    // Subscription action
                }) {
                    Text("Subscribe for all 6 quiz modes")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Quiz Modes Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Quiz Modes")
                        .font(.title3)
                        .bold()
                    
                    NavigationLink(destination: QuestionView()) {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.green)
                            Text("Question of the Day")
                            Spacer()
                            Text("Dec 17")
                                .foregroundColor(.yellow)
                            Circle()
                                .fill(Color.white)
                                .frame(width: 8, height: 8)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
    
    // Keep the existing helper functions
    private func generateCalendarDates() {
        let calendar = Calendar.current
        
        // Get the start of the current week
        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentWeek))!
        
        var dates: [CalendarDate] = []
        
        // Generate dates for two weeks (14 days)
        for dayOffset in 0..<14 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: weekStart) {
                dates.append(CalendarDate(date: date))
            }
        }
        
        calendarDates = dates
    }
    
    private func previousWeek() {
        if let newDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentWeek) {
            currentWeek = newDate
            generateCalendarDates()
        }
    }
    
    private func nextWeek() {
        if let newDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentWeek) {
            currentWeek = newDate
            generateCalendarDates()
        }
    }
}

struct TabBarButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.gray)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


