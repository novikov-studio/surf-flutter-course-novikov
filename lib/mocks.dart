import 'package:places/domain/sight.dart';

final mocks = [
  Sight(
    name: 'Гостиница "Ковчег"',
    lat: 47.5136577,
    lon: 42.1835938,
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
    lat: 47.5113611,
    lon: 42.2034055,
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
    lat: 47.5116059,
    lon: 42.2049714,
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
    lat: 47.5177595,
    lon: 42.1948818,
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
    lat: 47.5147167,
    lon: 42.1954797,
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
    lat: 47.5132317,
    lon: 42.2007234,
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
    lat: 42.149869,
    lon: 47.519356,
    url: 'https://visitdon.ru/Fu.ashx?id=3379',
    info: 'открыто до 18:00',
    details: '''
Являясь самым крупным государственным музеем на востоке области, музей ежегодно принимает не менее 126 тысяч посетителей – жителей города Волгодонска и 14 районов Ростовской области.
''',
    type: 'Музей',
  ),
  const Sight(
    name: 'Мирный атом',
    lat: 47.5197851,
    lon: 42.202343,
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
    lat: 42.057971,
    lon: 47.5719,
    url:
        'https://visitdon.ru/upload/Showplace/827_%D0%A0%D0%BE%D1%81%D1%82%D0%BE%D0%B2%D1%81%D0%BA%D0%B0%D1%8F_%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C_%D0%92%D0%BE%D0%BB%D0%B3%D0%BE%D0%B4%D0%BE%D0%BD%D1%81%D0%BA_%D0%90%D0%BA%D0%B2%D0%B0%D0%BF%D0%B0%D1%80%D0%BA4.jpg',
    info: 'открыто до 21:00',
    details: '''
Дух захватывает от спуска по скоростным водяным горкам. Чистейшая бирюзовая вода в бассейнах способна охладить в любую жару, белоснежные лежаки и шезлонги порадуют тех, кто любит позагорать, а веселые аниматоры устроят настоящее представление для малышей в детской аквазоне — с бассейном и горкой для малышей и подростков.      
''',
    type: 'Развлечения',
  ),
  const Sight(
    name: 'Дендрарий',
    lat: 47.5102933,
    lon: 42.1489521,
    url:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/%D0%94%D0%B5%D0%BD%D0%B4%D1%80%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BF%D0%B0%D1%80%D0%BA3_%D0%92%D0%BE%D0%BB%D0%B3%D0%BE%D0%B4%D0%BE%D0%BD%D1%81%D0%BA.JPG/1280px-%D0%94%D0%B5%D0%BD%D0%B4%D1%80%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BF%D0%B0%D1%80%D0%BA3_%D0%92%D0%BE%D0%BB%D0%B3%D0%BE%D0%B4%D0%BE%D0%BD%D1%81%D0%BA.JPG',
    info: 'круглосуточно',
    details: '''
Дендропарк на западе Волгодонска, единственный степной дендрарий на Дону. На площади 11 га произрастают 240 видов и форм представителей средиземноморской, европейско-сибирской, китайско-японской и северо-американской флоры.      
''',
    type: 'Парк',
  ),
];
