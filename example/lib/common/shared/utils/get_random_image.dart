String getRandomImage() {
  final images = List.generate(6, (index) => "assets/images/image-$index.jpg");
  images.shuffle();
  return images.last;
}
