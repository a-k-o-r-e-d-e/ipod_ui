import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final Color color;
  final int idx;
  final double currentPage;

  AlbumCard({this.color, this.idx, this.currentPage});

  final List images = [
    'https://tooxclusive.com/wp-content/uploads/2017/10/Falz-27.jpg',
    'https://tooxclusive.com/wp-content/uploads/2020/08/Twice-As-Tall-artwork-768x768.jpeg',
    'https://tooxclusive.com/wp-content/uploads/2019/08/Blaqbonez-Best-Rapper-in-Africa-mp3-image.jpg',
    'https://tooxclusive.com/wp-content/uploads/2020/07/Adekunle-Gold-AG-BABY-artwork.jpg',
    'https://tooxclusive.com/wp-content/uploads/2019/11/Davido-A-Good-Time-Album-Art.jpeg',
    'https://tooxclusive.com/wp-content/uploads/2019/12/Vector-VibesBeforeTeslim-600x600.jpg',
    'https://thebrag.com/wp-content/uploads/2015/10/artvsscienceofftheedgeoftheearthandintoforeverforever1015.jpg',
    'https://tooxclusive.com/wp-content/uploads/2019/11/Fireboy-DML-Scatter-mp3-image.jpg',
    'https://jaguda.com/wp-content/uploads/2020/10/Olamide-Carpe-Diem-artwork-696x696.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    double relativePosition = idx - currentPage;

    return Container(
      width: 250,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.003)
          ..scale((1 - relativePosition.abs()).clamp(0.2, 0.6) + 0.4)
          ..rotateY(relativePosition),
        // ..rotateZ(relativePosition),
        alignment: relativePosition >= 0
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(images[idx]),
              )),
        ),
      ),
    );
  }
}
