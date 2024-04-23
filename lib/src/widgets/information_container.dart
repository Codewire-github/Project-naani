import 'package:flutter/material.dart';

class InformationContainer extends StatefulWidget {
  final String result;
  final int noOfObjectsFound;

  final String description;
  final Color primaryColor;
  final List<String> imageUrls;

  const InformationContainer(
      {super.key,
      required this.result,
      required this.noOfObjectsFound,
      required this.description,
      required this.primaryColor,
      required this.imageUrls});

  @override
  State<InformationContainer> createState() => _InformationContainerState();
}

class _InformationContainerState extends State<InformationContainer> {
  bool isSeeMore = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.7,
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
            ),
            const SizedBox(height: 15),
            if (widget.noOfObjectsFound == 0) ...{
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/img/error.png',
                width: 300,
                height: 300,
              ),
              const Text(
                'No Objects Found',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 10),
            },
            if (widget.noOfObjectsFound != 0) ...{
              Container(
                height: 230,
                child: ListView.builder(
                    itemCount: widget.imageUrls.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            widget.imageUrls[index],
                            height: 220,
                            width: 280,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
            },
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Adjusted alignment
              children: [
                Expanded(
                  child: Text(
                    widget.result,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ],
            ),
            if (isSeeMore) ...{
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                child: Text(
                  widget.description,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      color: Colors.grey[700]),
                ),
              ),
            } else ...{
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                child: Text(
                  widget.description,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      color: Colors.grey[700]),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            },
            TextButton(
                onPressed: () {
                  setState(() {
                    isSeeMore = !isSeeMore;
                  });
                },
                child: Text(
                  isSeeMore ? "See less" : "See more",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 62, 59, 255),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      fontFamily: "Poppins"),
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
