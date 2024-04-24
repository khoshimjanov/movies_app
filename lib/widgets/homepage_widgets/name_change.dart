import 'package:flutter/material.dart';
import 'package:movies_app/helpers/app_colors.dart';

import 'package:provider/provider.dart';

import '../../providers/user.dart';

class NameChange extends StatefulWidget {
  const NameChange({
    super.key,
  });

  @override
  State<NameChange> createState() => _NameChangeState();
}

class _NameChangeState extends State<NameChange> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.of(context).pop(),
              child: Ink(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.maindarkTextColor,
                  ),
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.maindarkTextColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: AppColors.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.white),
                      hintText: Provider.of<User>(context).person.name,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<User>(context, listen: false)
                        .changeUserName(_controller.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Add my name',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.borderColor,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
