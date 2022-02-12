import 'package:places/domain/sight.dart';
import 'package:places/service/location.dart';

const mockCurrentLocation = Location(latitude: 47.516898, longitude: 42.146062);

final mocks = [
  Sight(
    name: 'Гостиница "Ковчег"',
    location: const Location(latitude: 47.513733, longitude: 42.185774),
    url: 'https://kovchegdon.ru/uploads/photo/promo/promo-01.jpg',
    info: 'заезд в 14:00',
    isLiked: true,
    plannedDate: DateTime.now().add(const Duration(days: 3)),
    details: '''
Уютная гостиница в самом центре Волгодонска.
8 комфортабельных номеров, дизайн каждого из них выполнен в определенном этническом стиле разных уголков мира с национальными особенностями оформления интерьера и элементов декора.      
''',
    type: 'Гостиница',
  ),
  const Sight(
    name: 'Пиццерия "Камин"',
    location: Location(latitude: 47.511431, longitude: 42.205328),
    url:
        'https://pizza-kamin.ru/assets/template/img/photogallery/holidays/ND4_1840.jpg',
    info: 'открыто до 20:00',
    isLiked: true,
    details: '''
Райский уголок европейской, японской и русской кухни, где традиционные блюда готовят по домашним рецептам.       
''',
    type: 'Пиццерия',
  ),
  Sight(
    name: 'Батутный парк №1',
    location: const Location(latitude: 47.51111, longitude: 42.21621),
    url:
        'https://static.tildacdn.com/tild6539-3565-4432-b461-633166666535/_-min.jpg',
    info: 'открыто до 22:00',
    isLiked: true,
    plannedDate: DateTime.now().add(const Duration(days: 2)),
    details: '''
Порадуйте ваших детей их любимым занятием - отведите их на батуты и присоединяйтесь сами!
Разные переходы, горки, песочницы с воздушными шарами – все это так интересно, увлекательно! А главное – это всё можно потрогать, везде можно полазить. Просто беззаботное времяпрепровождение, которое радует как детей, так и взрослых!
''',
    type: 'Развлечения',
  ),
  const Sight(
    name: 'Чайный бутик',
    location: Location(latitude: 47.519225, longitude: 42.19468),
    url:
        'https://lh5.googleusercontent.com/p/AF1QipMErV_AR_tL8idGKTzWibDg91ULxcKhfk0QL047=s677-k-no',
    info: 'открыто до 18:00',
    details: '''
Приятная атмосфера, французские булочки, ароматный чай и наивкуснейшие десерты.       
''',
    type: 'Кафе',
  ),
  Sight(
    name: 'КРК "Комсомолец"',
    location: const Location(latitude: 47.51665, longitude: 42.197011),
    url:
        'https://im0-tub-ru.yandex.net/i?id=482a1528addddaec5db33fe1b948e50b-l&ref=rim&n=13&w=1080&h=642',
    info: 'открыто до 18:00',
    isLiked: true,
    plannedDate: DateTime.now().subtract(const Duration(days: 1)),
    visitedDate: DateTime.now().subtract(const Duration(days: 1)),
    details: '''
Лучшие премьеры фильмов. Самый большой экран. Цифровое качество 3D. 2 зала /660 мест.        
''',
    type: 'Кинотеатр',
  ),
  const Sight(
    name: 'Сквер "Дружба"',
    location: Location(latitude: 47.513275, longitude: 42.200729),
    url: 'https://v-pravda.ru/wp-content/uploads/2020/08/IMG_1551-1024x683.jpg',
    info: 'круглосуточно',
    details: '''
Название сквера тесно связано с приездом в город иностранных делегаций в 1977 году. В посадке деревьев на аллее Дружбы принимали участие многие известные лидеры СССР и зарубежных стран. 
Сквер поделен на несколько зон – зона отдыха, игровая, спортивная, общественная зона и зона сезонной торговли.        
''',
    type: 'Парк',
  ),
  const Sight(
    name: 'Волгодонский эколого-исторический музей',
    location: Location(latitude: 47.519083, longitude: 42.150124),
    url: 'https://b1.culture.ru/c/342632.884x442.webp',
    info: 'открыто до 18:00',
    details: '''
Являясь самым крупным государственным музеем на востоке области, музей ежегодно принимает не менее 126 тысяч посетителей – жителей города Волгодонска и 14 районов Ростовской области.
''',
    type: 'Музей',
  ),
  const Sight(
    name: 'Мирный атом',
    location: Location(latitude: 47.519884, longitude: 42.204517),
    url:
        'https://www.atomic-energy.ru/files/styles/center/public/images/2019/10/09263f5cc302e4d103b7065857fb5901.jpg',
    info: 'круглосуточно',
    details: '''
Монумент, воздвигнутый в Волгодонске, символизирующий развитие атомного машиностроения и энергетики в городе. Является одним из главных символов Волгодонска.      
''',
    type: 'Памятник',
  ),
  const Sight(
    name: 'Аквапарк "Аква-сити"',
    location: Location(latitude: 47.571418, longitude: 42.057845),
    url: 'https://donskayavolna.com/wp-content/uploads/2020/05/openpool.jpg',
    info: 'открыто до 21:00',
    details: '''
Дух захватывает от спуска по скоростным водяным горкам. Чистейшая бирюзовая вода в бассейнах способна охладить в любую жару, белоснежные лежаки и шезлонги порадуют тех, кто любит позагорать, а веселые аниматоры устроят настоящее представление для малышей в детской аквазоне — с бассейном и горкой для малышей и подростков.      
''',
    type: 'Развлечения',
  ),
  const Sight(
    name: 'Дендрарий',
    location: Location(latitude: 47.514525, longitude: 42.134428),
    url:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/%D0%94%D0%B5%D0%BD%D0%B4%D1%80%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BF%D0%B0%D1%80%D0%BA3_%D0%92%D0%BE%D0%BB%D0%B3%D0%BE%D0%B4%D0%BE%D0%BD%D1%81%D0%BA.JPG/1280px-%D0%94%D0%B5%D0%BD%D0%B4%D1%80%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BF%D0%B0%D1%80%D0%BA3_%D0%92%D0%BE%D0%BB%D0%B3%D0%BE%D0%B4%D0%BE%D0%BD%D1%81%D0%BA.JPG',
    info: 'круглосуточно',
    details: '''
Дендропарк на западе Волгодонска, единственный степной дендрарий на Дону. На площади 11 га произрастают 240 видов и форм представителей средиземноморской, европейско-сибирской, китайско-японской и северо-американской флоры.      
''',
    type: 'Парк',
  ),
];
