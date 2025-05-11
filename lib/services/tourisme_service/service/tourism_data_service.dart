// // lib/services/tourisme_service/service/tourism_data_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';

// class TourismDataService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Seed initial data if collections are empty
//   Future<void> seedInitialDataIfNeeded() async {
//     await _seedCitiesIfEmpty();
//     await _seedTouristSpotsIfEmpty();
//     await _seedToursIfEmpty();
//   }

//   // Check if cities collection is empty and seed if needed
//   Future<void> _seedCitiesIfEmpty() async {
//     final snapshot = await _firestore.collection('cities').limit(1).get();

//     if (snapshot.docs.isEmpty) {
//       // Collection is empty, add initial data
//       final batch = _firestore.batch();

//       final cities = [
//         {
//           'name': 'Rabat',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1553244588-9e92a1revisedwith.jpg?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'description': 'The capital city of Morocco',
//           'interests': ['History', 'Culture', 'Architecture'],
//         },
//         {
//           'name': 'Marrakech',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1565689126083-a675a6cc7c92?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'description': 'The Red City',
//           'interests': ['Culture', 'Shopping', 'Food'],
//         },
//         {
//           'name': 'Casablanca',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1570003179230-788cf0d43388?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'description': 'The largest city in Morocco',
//           'interests': ['Business', 'Architecture', 'Shopping'],
//         },
//         {
//           'name': 'Fes',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1548018560-c7196548c349?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'description': 'The cultural capital of Morocco',
//           'interests': ['Culture', 'History', 'Shopping'],
//         },
//         {
//           'name': 'Tangier',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1564594139297-2033aa2bde22?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'description': 'The gateway to Europe',
//           'interests': ['History', 'Culture', 'Nature'],
//         },
//       ];

//       for (var city in cities) {
//         final docRef = _firestore.collection('cities').doc();
//         batch.set(docRef, city);
//       }

//       await batch.commit();
//       print('Cities collection seeded successfully');
//     }
//   }

//   // Check if tourist_spots collection is empty and seed if needed
//   Future<void> _seedTouristSpotsIfEmpty() async {
//     final snapshot =
//         await _firestore.collection('tourist_spots').limit(1).get();

//     if (snapshot.docs.isEmpty) {
//       // Collection is empty, add initial data
//       final batch = _firestore.batch();

//       final spots = [
//         {
//           'name': 'Kasbah des Oudayas',
//           'city': 'Rabat',
//           'description':
//               'An iconic fortified neighborhood overlooking the Atlantic Ocean. It\'s famous for its picturesque, blue-and-white painted alleyways, beautiful Andalusian gardens, and historic architecture dating back to the 12th century.',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1564599894728-38417b5006fe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'rating': '4.6',
//           'ratingCount': '445',
//           'entryFee': 'Free Entry',
//           'interestType': 'History',
//           'openingHours': '8:00 AM–6:00 PM',
//           'history':
//               'The Kasbah des Oudayas was originally built in the 12th century during the reign of the Almohad Caliphate. It served as a fortress to protect the city from invasions. Over the centuries, it underwent various renovations and expansions, particularly during the Andalusian period when many refugees from Spain settled here. The distinctive blue and white color scheme of the buildings was added in the 20th century, inspired by the city of Chefchaouen. Today, it stands as one of the most beautiful historical sites in Rabat, combining military architecture with residential charm.',
//           'latitude': 34.0267,
//           'longitude': -6.8367,
//         },
//         {
//           'name': 'Hassan Tower',
//           'city': 'Rabat',
//           'description':
//               'A symbolic 12th-century minaret of an unfinished mosque, standing as Rabat\'s most recognizable monument. Surrounded by ancient stone pillars, it showcases impressive Almohad-era architecture.',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1547653872-052e3539dedf?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'rating': '4.6',
//           'ratingCount': '9.9k',
//           'entryFee': 'Free Entry',
//           'interestType': 'History',
//           'openingHours': '6:30 AM–10:45 PM',
//           'history':
//               'Hassan Tower is a historical landmark in Rabat, Morocco, and one of the city\'s most iconic sites. It was commissioned by Sultan Yacoub al-Mansour in the 12th century as part of an ambitious project to build the largest mosque in the world. However, construction stopped after his death, leaving behind the striking 44-meter-tall red sandstone minaret and a vast esplanade filled with stone columns—silent reminders of what could have been. Despite its unfinished state, Hassan Tower remains a symbol of Morocco\'s rich history and architectural heritage. The structure features intricate geometric designs and horseshoe arches, characteristic of Almohad architecture. Nearby, the Mausoleum of Mohammed V adds to the site\'s grandeur, with its beautifully decorated white marble walls and green-tiled roof.',
//           'latitude': 34.0252,
//           'longitude': -6.8248,
//         },
//         {
//           'name': 'Mausoleum of Mohammed V',
//           'city': 'Rabat',
//           'description':
//               'An elegant tomb of King Mohammed V and King Hassan II. Renowned for its detailed Moroccan architecture, intricate mosaics, marble craftsmanship, and ceremonial Royal Guards at its entrances.',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1585235159962-d796c5e1066a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'rating': '4.6',
//           'ratingCount': '3.4k',
//           'entryFee': 'Paid Entry',
//           'interestType': 'History',
//           'openingHours': '9:00 AM–6:00 PM',
//           'history':
//               'The Mausoleum of Mohammed V is a masterpiece of modern Alaouite dynasty architecture, built between 1961 and 1971. It contains the tombs of King Mohammed V, who was instrumental in achieving Morocco\'s independence, and his two sons, King Hassan II and Prince Abdallah. The building showcases the finest Moroccan craftsmanship, with intricate zellige tilework, carved cedar wood ceilings, and magnificent marble decorations. The mausoleum stands on the same site as the incomplete Hassan Mosque, creating a powerful connection between Morocco\'s historical past and its modern monarchy. Royal guards in traditional costume stand at attention at the entrances, adding to the ceremonial atmosphere of this important national monument.',
//           'latitude': 34.0251,
//           'longitude': -6.8245,
//         },
//         {
//           'name': 'Chellah Necropolis',
//           'city': 'Rabat',
//           'description':
//               'An enchanting historical site combining ancient Roman ruins and medieval Islamic structures. Known for its tranquil atmosphere, lush gardens, and nesting storks atop ancient walls.',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1589476993526-f738ef198fcd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'rating': '4.6',
//           'ratingCount': '3.4k',
//           'entryFee': 'Paid Entry',
//           'interestType': 'History',
//           'openingHours': '8:30 AM–5:30 PM',
//           'history':
//               'Chellah (or Sala Colonia) has a rich history spanning over 2,000 years. Originally a Phoenician and then Roman colony called Sala Colonia in the 1st century CE, it flourished as an important port city of the Roman Empire. After the Romans abandoned the site in the 5th century, it lay in ruins until the 14th century when the Marinid Sultan Abu al-Hasan Ali ibn Othman built a necropolis and religious complex over the Roman ruins. The site was severely damaged by the 1755 Lisbon earthquake but has been partially restored. Today, Chellah is known for its unique blend of Roman and Islamic architecture, lush gardens, and the storks that nest on its walls, which are considered symbols of good luck in Moroccan folklore.',
//           'latitude': 34.0044,
//           'longitude': -6.8221,
//         },
//         {
//           'name': 'Jemaa el-Fnaa',
//           'city': 'Marrakech',
//           'description':
//               'The main square of Marrakech and a UNESCO World Heritage site. It\'s famous for its vibrant atmosphere, street performers, food stalls, and traditional markets.',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1554204298-4eabdfe45c14?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'rating': '4.8',
//           'ratingCount': '15.2k',
//           'entryFee': 'Free Entry',
//           'interestType': 'Culture',
//           'openingHours': 'Open 24 hours',
//           'history':
//               'Jemaa el-Fnaa is the heart of Marrakech and has served as the city\'s main square since the founding of Marrakech in the 11th century. Its name has several interpretations, including "assembly of the dead," which may refer to its history as a place of public executions. Over the centuries, it has served as a marketplace, performance space, and social hub. In 2001, UNESCO declared it a Masterpiece of the Oral and Intangible Heritage of Humanity for its preservation of traditional cultural expressions. The square transforms throughout the day: quiet in the morning, filled with snake charmers and juice vendors in the afternoon, and in the evening, it becomes a massive open-air dining area with storytellers, musicians, and performers creating a carnival-like atmosphere that has remained largely unchanged for centuries.',
//           'latitude': 31.6260,
//           'longitude': -7.9891,
//         },
//         {
//           'name': 'Hassan II Mosque',
//           'city': 'Casablanca',
//           'description':
//               'A magnificent mosque with the tallest minaret in the world. Built partly on land and partly over the Atlantic Ocean, it showcases stunning Moroccan craftsmanship.',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1504285519797-3b0349c4c170?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'rating': '4.9',
//           'ratingCount': '12.3k',
//           'entryFee': 'Paid Entry',
//           'interestType': 'Architecture',
//           'openingHours': '9:00 AM–3:00 PM (Closed for prayers)',
//           'history':
//               'The Hassan II Mosque is a magnificent architectural marvel that was completed in 1993 after seven years of construction. Commissioned by King Hassan II to commemorate his 60th birthday, the mosque was designed by French architect Michel Pinseau and built by Moroccan artisans using materials from all over Morocco. The mosque stands partially on land and partially over the Atlantic Ocean, inspired by the Quranic verse stating that "the throne of Allah was built on water." With its 210-meter minaret (the tallest in the world), hand-crafted marble walls, intricate zellige tilework, and cedar wood ceilings carved by over 6,000 traditional Moroccan artisans, it represents the pinnacle of Moroccan craftsmanship. The mosque can accommodate 25,000 worshippers inside and another 80,000 in the courtyard, making it one of the largest mosques in the world. Unlike most mosques in Morocco, the Hassan II Mosque is one of the few religious sites open to non-Muslim visitors through guided tours.',
//           'latitude': 33.6086,
//           'longitude': -7.6326,
//         },
//       ];

//       for (var spot in spots) {
//         final docRef = _firestore.collection('tourist_spots').doc();
//         batch.set(docRef, spot);
//       }

//       await batch.commit();
//       print('Tourist spots collection seeded successfully');
//     }
//   }

//   // Check if tours collection is empty and seed if needed
//   Future<void> _seedToursIfEmpty() async {
//     final snapshot = await _firestore.collection('tours').limit(1).get();

//     if (snapshot.docs.isEmpty) {
//       // Collection is empty, add initial data
//       final batch = _firestore.batch();

//       final tours = [
//         {
//           'name': 'Tour from Marrakech to Fes and Merzouga Desert',
//           'startingCity': 'Marrakech',
//           'description':
//               'A 4-day tour from Marrakech to Fes offers stunning mountain views, ancient kasbahs, camel trekking in golden dunes, breathtaking gorges, lush valleys, starry desert nights, and scenic forest landscapes.',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1566726662220-75120fba3c96?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'duration': '4 days',
//           'price': '2000 MAD',
//           'rating': '4.6',
//           'ratingCount': '3.4k',
//           'cities': ['Marrakech', 'Merzouga', 'Fes'],
//         },
//         {
//           'name': 'Tour from Ouarzazate to Zagora desert',
//           'startingCity': 'Ouarzazate',
//           'description':
//               'Embark on a thrilling tour from Ouarzazate to Merzouga Desert and Zagora, crossing the Draa Valley, exploring ancient kasbahs, and enjoying camel treks, desert camps, and breathtaking Sahara sunsets.',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1562871475-7ded99ac3e7c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'duration': '3 days',
//           'price': '2500 MAD',
//           'rating': '4.6',
//           'ratingCount': '3.4k',
//           'cities': ['Ouarzazate', 'Zagora'],
//         },
//         {
//           'name': 'Tour from Casablanca to Chefchaouen',
//           'startingCity': 'Casablanca',
//           'description':
//               'Tour from Casablanca to Chefchaouen, exploring Rabat\'s landmarks, wandering through the blue-washed streets of Chefchaouen, and enjoying breathtaking Rif Mountain views in a peaceful setting.',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1604843279422-4e30dc24a2d6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'duration': '3 days',
//           'price': '1500 MAD',
//           'rating': '4.6',
//           'ratingCount': '3.4k',
//           'cities': ['Casablanca', 'Rabat', 'Chefchaouen'],
//         },
//         {
//           'name': 'Tour from Tangier to Marrakech',
//           'startingCity': 'Tangier',
//           'description':
//               'Journey from Tangier to Marrakech, exploring Chefchaouen\'s blue streets, Fes\' rich history, the Sahara\'s golden dunes, and Berber villages before crossing the Atlas Mountains to reach vibrant Marrakech.',
//           'imageUrl':
//               'https://images.unsplash.com/photo-1578894340905-d69da486feb8?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
//           'duration': '6 days',
//           'price': '3900 MAD',
//           'rating': '4.5',
//           'ratingCount': '3.4k',
//           'cities': ['Tangier', 'Chefchaouen', 'Fes', 'Marrakech'],
//         },
//       ];

//       for (var tour in tours) {
//         final docRef = _firestore.collection('tours').doc();
//         batch.set(docRef, tour);
//       }

//       await batch.commit();
//       print('Tours collection seeded successfully');
//     }
//   }
// }
