





// pools
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chillx/pool/poolPage.dart';

Widget buildPools()=> Container(
        height: 100,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Pools').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Text('');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.size,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return InkWell(
                    onTap: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: pool(id: ds["docId"], msg: ds["msg"], bgcolour: ds["color"])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ds['imageUrl'] == ""
                          ? Column(
                              children: [
                                Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.shade300,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 3,
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      ds['title'][0],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      ds['title'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: ds['imageUrl'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 55.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 3,
                                          blurRadius: 6,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue.shade300,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 3,
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'images/profile_picture.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      ds['title'],
                                      style: GoogleFonts.lato(textStyle: const TextStyle(
                                          fontWeight:FontWeight.w500),),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3.0,
                                ),
                              ],
                            ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
