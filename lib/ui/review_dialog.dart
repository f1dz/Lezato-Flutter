import 'package:flutter/material.dart';
import 'package:lezato/data/model/review.dart';
import 'package:lezato/provider/app_provider.dart';

class ReviewDialog extends StatelessWidget {
  ReviewDialog({@required this.provider, @required this.id});
  final AppProvider provider;
  final String id;

  @override
  Widget build(BuildContext context) {
    var _nameTextController = TextEditingController();
    var _reviewTextController = TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      title: Text("Add Review"),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _nameTextController,
                decoration: InputDecoration(
                    hintText: "Name",
                    suffixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, top: 15)),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                controller: _reviewTextController,
                decoration: InputDecoration(
                    hintText: "Review",
                    suffixIcon: Icon(Icons.rate_review),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, top: 15)),
              ),
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              Review review = Review(
                id: id,
                name: _nameTextController.text,
                review: _reviewTextController.text,
              );
              provider.postReview(review).then((value) => Navigator.pop(context));
            },
            child: Text("Save"))
      ],
    );
  }
}
