import 'package:fluent_ui/fluent_ui.dart' as fi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';

import '../../../../../models/Role.dart';
import '../../../../../models/User.dart';

class ViewAndEditUser extends StatefulWidget {
  User user;
  Role currentRole;
  ViewAndEditUser({Key? key, required this.user, required this.currentRole})
      : super(key: key);

  @override
  State<ViewAndEditUser> createState() =>
      _ViewAndEditUserState(user, currentRole);
}

class _ViewAndEditUserState extends State<ViewAndEditUser> {
  User user;
  Role currentRole;
  _ViewAndEditUserState(this.user, this.currentRole);
  bool canEdit = false;
  @override
  Widget build(BuildContext context) {
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.sp,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        canEdit = true;
                      });
                    },
                    icon: Icon(
                      fi.FluentIcons.edit,
                      size: 16.sp,
                      color: primaryColor,
                    )),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      fi.FluentIcons.check_mark,
                      size: 20.sp,
                      color: primaryColor,
                    )),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 150.h,
                width: 150.w,
                child: CircleAvatar(
                  backgroundColor: textFieldFillColor,
                  child: Center(child: Icon(fi.FluentIcons.photo2_add)),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                user.gender ?? 'Unknown',
                style: const TextStyle(color: greyColor, fontFamily: 'Poppins'),
              ),
              SizedBox(
                width: 10.w,
              ),
              const Text('|',
                  style: TextStyle(color: primaryColor, fontFamily: 'Poppins')),
              SizedBox(
                width: 10.w,
              ),
              Text(user.age == null ? 'Unknown' : user.age.toString(),
                  style:
                      const TextStyle(color: greyColor, fontFamily: 'Poppins')),
              SizedBox(
                width: 10.w,
              ),
              const Text('|',
                  style: TextStyle(color: primaryColor, fontFamily: 'Poppins')),
              SizedBox(
                width: 10.w,
              ),
              DropdownButton<Role>(
                icon: null,
                iconSize: 0.0,
                alignment: Alignment.center,
                underline: Container(),
                borderRadius: fi.BorderRadius.circular(10),
                value: user.role,
                onChanged: (value) {
                  changeRole(value!);
                  print(user.role);
                },
                items:  [
                  DropdownMenuItem(
                    child: Text('SuperAdmin',
                        style: TextStyle(
                            color: greyColor,
                            fontFamily: 'Poppins',
                            fontSize: 14.sp)),
                    value: Role.SuperAdmin,
                  ),
                  DropdownMenuItem(
                      child: Text('Admin',
                          style: TextStyle(
                              color: greyColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: Role.Admin),
                  DropdownMenuItem(
                      child: Text('Teacher',
                          style: TextStyle(
                              color: greyColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: Role.Teacher)
                ],
              )
            ]),
             SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    enabled: canEdit,
                    value: user.name.trim().split(' ')[0],
                    hintText: user.name.trim().split(' ')[0],
                    padding: const EdgeInsets.all(5),
                    heading: 'First Name',
                  ),
                ),
                 SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: CustomTextField(
                    enabled: canEdit,
                    hintText: user.name.trim().split(' ')[1],
                    value: user.name.trim().split(' ')[1],
                    padding: const EdgeInsets.all(5),
                    heading: 'Last Name',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    enabled: canEdit,
                    hintText: user.email,
                    value: user.email,
                    padding: const EdgeInsets.all(5),
                    heading: 'Email',
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: CustomTextField(
                    enabled: canEdit,
                    hintText: user.phoneNumber,
                    value: user.phoneNumber,
                    padding: const EdgeInsets.all(5),
                    heading: 'Phone Number',
                  ),
                ),
              ],
            ),
            CustomTextField(
              enabled: canEdit,
              hintText: user.address ?? 'Unknown',
              value: user.address ?? 'Unknown',
              padding: const EdgeInsets.all(5),
              heading: 'Address',
            ),
            CustomTextField(
              enabled: canEdit,
              hintText: user.description ?? 'Unknown',
              value: user.description ?? 'Unknown',
              padding: const EdgeInsets.all(5),
              heading: 'Description',
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextButton(
                  onPressed: () async {
                    await managementCubit.deleteUser(email: user.email);
                    await managementCubit.getAllUsers(role: currentRole);
                    Navigator.pop(context, true);
                  },
                  text: 'Delete',
                  bgColor: redColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void changeRole(Role role) {
    print(role);
    setState(() {
      user = user.copyWith(role: role);
    });
  }
}
