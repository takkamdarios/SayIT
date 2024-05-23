import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateSit extends StatefulWidget {
  const CreateSit({super.key});

  @override
  State<CreateSit> createState() => _CreateSitState();
}

class _CreateSitState extends State<CreateSit> {
  final TextEditingController _sitContentController = TextEditingController();
  bool _isCreatingSit = false;
  bool _isSitContentExceeded = false;

  void _createSit() {
    if (_sitContentController.text.isNotEmpty && !_isSitContentExceeded) {
      setState(() {
        _isCreatingSit = true;
      });

      final sitData = {
        "content": _sitContentController.text,
        "createdAt": DateTime.now(),
        "userID": FirebaseAuth.instance.currentUser!.uid
      };

      FirebaseFirestore.instance.collection('sits').add(sitData).then((sitRef) {
        setState(() {
          _isCreatingSit = false;
        });

        _sitContentController.clear();

        Navigator.pop(context);
      }).catchError((error) {
        setState(() {
          _isCreatingSit = false;
        });

        //print('Failed to create sit: $error');
      });
    }
  }

  void _checkSitContentLength() {
    setState(() {
      _isSitContentExceeded = _sitContentController.text.length > 140;
    });
  }

  @override
  void initState() {
    super.initState();
    _sitContentController.addListener(_checkSitContentLength);
  }

  @override
  void dispose() {
    _sitContentController.removeListener(_checkSitContentLength);
    _sitContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          "Create a sit",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        padding: const EdgeInsets.all(16.0),
        width: 500,
        height: 150,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _sitContentController,
                maxLength: 140,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Sit Content',
                  hintText: 'Enter your sit content',
                ),
              ),
              if (_isSitContentExceeded)
                const Text(
                  'Sit content cannot exceed 140 characters',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16.0),
              OutlinedButton(
                onPressed:
                    _isCreatingSit || _isSitContentExceeded ? null : _createSit,
                child: _isCreatingSit
                    ? const CircularProgressIndicator()
                    : const Text('Create Sit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
