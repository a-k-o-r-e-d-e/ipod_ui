import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final Color color;
  final int idx;
  final double currentPage;

  AlbumCard({this.color, this.idx, this.currentPage});

  final List images = [
    'https://i.pinimg.com/originals/8c/d0/d7/8cd0d722e65ccd87fffb844980977b3c.jpg',
    'http://4.bp.blogspot.com/_3GTOQGJNP5k/SbCbBCQB3vI/AAAAAAAABIg/PcBhcRjLuVk/s320/halloates.jpg',
    'https://tooxclusive.com/wp-content/uploads/2019/08/Blaqbonez-Best-Rapper-in-Africa-mp3-image.jpg',
    'https://tooxclusive.com/wp-content/uploads/2020/07/Adekunle-Gold-AG-BABY-artwork.jpg',
    'https://isteam.wsimg.com/ip/88fde5f6-6e1c-11e4-b790-14feb5d39fb2/ols/580_original/:/rs=w:600,h:600',
    'https://www.covercentury.com/covers/audio/b/baby_justin-bieber_218-vbr_1462296.jpg',
    'https://thebrag.com/wp-content/uploads/2015/10/artvsscienceofftheedgeoftheearthandintoforeverforever1015.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS95jA18s6vnmWIk4z6jTuaINYm4jBoWWRC5yp7cXvwKikEASRR&s',
    'https://list.lisimg.com/image/2239608/500full.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/513D1NEWPXL.jpg'
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
