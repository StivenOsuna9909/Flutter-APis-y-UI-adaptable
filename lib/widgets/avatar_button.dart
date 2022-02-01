import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize;
  const AvatarButton({Key? key, this.imageSize = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black26,
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              'https://png.pngtree.com/png-vector/20200614/ourlarge/pngtree-businessman-user-avatar-character-vector-illustration-png-image_2242909.jpg',
              width: this.imageSize,
              height: this.imageSize,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.pink,
                  shape: BoxShape.circle),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
