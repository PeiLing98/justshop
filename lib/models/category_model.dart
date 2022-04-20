List foodCategoryList = [
  'Malay Cuisine',
  'Chinese Cuisine',
  'Indian Cuisine',
  'Western Cuisine',
  'Korean Cuisine',
  'Japanese Cuisine',
  'Thai Cuisine',
  'Beverage',
  'Bread & Cake & Dessert',
];
List productCategoryList = [
  'Food',
  'Health & Beauty',
  'Hair',
  'Fashion',
  'Daily Life',
  'Home & Living',
  'Electronic',
  'Sport & Outdoor',
  'Automotive',
  'Handmade',
];
List serviceCategoryList = [
  'Home Cleaning',
  'Photography & Videography',
  'Art & Design',
  'Mover & Logistics',
  'Repair & Maintenance & Furnishing',
  'Party & Event',
  'Construction',
  'Education',
  'Beauty',
  'Confinement',
  'Health',
];

List<String> foodCategoryImage = [
  'assets/images/malay_food.jpg',
  'assets/images/chinese_food.jpg',
  'assets/images/indian_food.jpg',
  'assets/images/western_food.jpg',
  'assets/images/korean_food.jpg',
  'assets/images/japanese_food.jpg',
  'assets/images/thai_food.jpg',
  'assets/images/beverage.jpg',
  'assets/images/bread_cake_dessert.jpg',
];

List<String> productCategoryImage = [
  'assets/images/food_product.jpg',
  'assets/images/health_beauty.jpg',
  'assets/images/hair.jpg',
  'assets/images/fashion.jpg',
  'assets/images/daily_life.jpg',
  'assets/images/home_living.jpg',
  'assets/images/electronics.jpg',
  'assets/images/sports.jpg',
  'assets/images/automotive.jpg',
  'assets/images/handmade.jpg'
];

List<String> serviceCategoryImage = [
  'assets/images/home_cleaning.jpg',
  'assets/images/photo_videography.jpg',
  'assets/images/art_design.jpg',
  'assets/images/mover.jpg',
  'assets/images/home_repair.jpg',
  'assets/images/party_event.jpg',
  'assets/images/construction.jpg',
  'assets/images/education.jpg',
  'assets/images/beauty.jpg',
  'assets/images/confinement.jpg',
  'assets/images/health.jpg'
];

class Category {
  final List category = ['Food', 'Product', 'Service'];
  final List subCategory = [
    foodCategoryList,
    productCategoryList,
    serviceCategoryList
  ];
  final List categoryImage = [
    foodCategoryImage,
    productCategoryImage,
    serviceCategoryImage
  ];
}
