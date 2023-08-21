import 'package:flutter/material.dart';


class SocialButtonForm extends StatelessWidget {
  final String social;

  const SocialButtonForm(this.social, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 50,
                height: 50,
                child: InkWell(
                  radius: 100,
                  onTap: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(social),
                        duration: const Duration(milliseconds: 1500),
                      ),
                    );
                  },
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        'https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg'),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 50,
                height: 50,
                child: InkWell(
                  radius: 100,
                  onTap: () {
                    
                  },
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        'https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg'),
                  ),
                )),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: InkWell(
                            radius: 100,
                            onTap: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(social),
                                  duration: const Duration(milliseconds: 1500),
                                ),
                              );
                            },
                            child: Ink.image(
                              fit: BoxFit.cover,
                              image: const NetworkImage(
                                  'https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg'),
                            ),
                          )),
                    )
                  ]))
        ]));
  }
}