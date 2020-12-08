//
//  MyPhotoWidget.swift
//  MyPhotoWidget
//
//  Created by Bùi Xuân Huy on 07/12/2020.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    typealias Entry = MyPetEntry
    var repository: Repository = Repository()
        
    func placeholder(in context: Context) -> MyPetEntry {
        return MyPetEntry(date: Date(), myPet: MyPet(name: "Xu", photo: #imageLiteral(resourceName: "IMG_7892")))
    }
        
    func getTimeline(in context: Context,
            completion: @escaping (Timeline<Entry>) -> Void) {

        var entries = [MyPetEntry]()
        var nextUpdateDate = Date()
        for (_, movie) in repository.fakeData().enumerated() {
            nextUpdateDate = Calendar.current.date(byAdding: .second,
                                                   value: 30, to: Date())!
            let entry = MyPetEntry(date: nextUpdateDate, myPet: movie)
            entries.append(entry)
        }

        let timeline = Timeline(
            entries: entries,
            policy: .atEnd
        )

        completion(timeline)
    }
       
     func getSnapshot(in context: Context,
          completion: @escaping (Entry) -> Void) {
                
        let entry = MyPetEntry(date: Date(), myPet: MyPet(name: "Xu", photo: #imageLiteral(resourceName: "IMG_7892")))
        completion(entry)
    }
}




struct MyPetEntry: TimelineEntry {
    let date: Date
    let myPet: MyPet
}

struct MyPhotoWidgetEntryView : View {
    var entry: Provider.Entry

    var gradient: Gradient {
        Gradient(stops:
                    [Gradient.Stop(color: .clear, location: 0),
                     Gradient.Stop(color: Color.black.opacity(0.95),
                                   location: 0.6)])
    }
    
    var body: some View {
        ZStack {
            Image(uiImage: entry.myPet.photo)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .mask(
                    RoundedRectangle(cornerRadius: 10)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(minHeight: 0, maxHeight: .infinity)
                )
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(minHeight: 0, maxHeight: .infinity)
            
            VStack {
                Spacer()
                LinearGradient(gradient: gradient,
                               startPoint: .top,
                               endPoint: .bottom)
                    .frame(height: 100)
            }
            VStack(alignment: .leading) {
                Spacer()
                Text(entry.myPet.name)
                    .padding(.all, 10)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}

@main
struct MyPhotoWidget: Widget {
    let kind: String = "MyPhotoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                                    provider: Provider()) { entry in
                    MyPhotoWidgetEntryView(entry: entry)
                }
                .configurationDisplayName("My Widget")
                .description("This is an example widget.")
    }
}

struct MyPhotoWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyPhotoWidgetEntryView(entry: MyPetEntry(date: Date(), myPet: MyPet(name: "Xu", photo: #imageLiteral(resourceName: "IMG_7891"))))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


