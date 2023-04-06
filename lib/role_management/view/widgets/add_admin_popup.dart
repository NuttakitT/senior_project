import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class AddAdminPopup extends StatefulWidget {
  String user = "";
  AddAdminPopup({super.key, required this.user});

  @override
  State<AddAdminPopup> createState() => _AddAdminPopupState();
}

class _AddAdminPopupState extends State<AddAdminPopup> {
  bool isUserEmpty = false;

  Color setColorOfTextField(bool emptyFlag) {
    if (!emptyFlag) {
      return ColorConstant.whiteBlack40;
    }
    return ColorConstant.red40;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userLabel = widget.user.isEmpty ? Consts.search : widget.user;

    return AlertDialog(
      backgroundColor: ColorConstant.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: SizedBox(
        width: 420,
        height: 188,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DefaultTextStyle(
                      style: AppFontStyle.orange70Md28,
                      child: Text(Consts.addUserTitle)),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              DefaultTextStyle(
                  style: AppFontStyle.wb60L18,
                  child: Text(Consts.addUserDetail)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: OutlinedButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: FindUsersDelegate(
                                  onUserSelected: (selectedUser) {
                                setState(() {
                                  widget.user = selectedUser;
                                });
                              }));
                          // open all user list view
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(ColorConstant.white),
                            side: MaterialStateProperty.all(const BorderSide(
                                color: ColorConstant.whiteBlack40, width: 1.0)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.search,
                                color: ColorConstant.whiteBlack40),
                            const SizedBox(width: 8),
                            Text(
                              userLabel,
                              style: AppFontStyle.wb40R14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 90,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        // Chack if user OK?
                        // Make the user -> Admin, then
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorConstant.orange40),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.group_add, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            Consts.add,
                            style: AppFontStyle.whiteSemiB16,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FindUsersDelegate extends SearchDelegate {
  final Function(String) onUserSelected;

  FindUsersDelegate({required this.onUserSelected});

  // TODO: make this to all users
  List<String> allSuggestions = ['1', '2', '3'];

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = allSuggestions.where((element) {
      final result = element.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              onUserSelected(suggestion);
              query = suggestion;
              close(context, null);
            },
          );
        });
  }
}

class Consts {
  static String addUserTitle = "Add User";
  static String addUserDetail = "Select a user to be a admin";
  static String search = "search";
  static String add = "Add";
}
