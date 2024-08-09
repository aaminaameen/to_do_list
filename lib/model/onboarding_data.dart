class PageContent {
  const PageContent({
    required this.image,
    required this.pageNo,
  });
  const PageContent.first()
      : this(image: 'assets/images/onboarding3.png', pageNo: 1);
  const PageContent.second()
      : this(image: 'assets/images/onboarding1.png', pageNo: 2);
  const PageContent.third()
      : this(image: 'assets/images/onboarding2.png', pageNo: 3);
  const PageContent.fourth()
      : this(image: 'assets/images/onboarding.png', pageNo: 4);

  final String image;
  final int pageNo;
  List<Object> get props => [image, pageNo];
}
