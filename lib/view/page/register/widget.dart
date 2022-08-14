import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/page/register.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nickname',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: RegisterPresenter.nickNameCont,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nickname',
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1.0),
              const Padding(
                padding:
                EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  'Sex',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Column(
                children: Sex.values.map((method) {
                  return ListTile(
                    title: Text(method.kr),
                    leading: Radio<Sex>(
                      value: method,
                      groupValue: controller.sex,
                      onChanged: controller.setSex,
                    ),
                  );
                }).toList(),
              ),
              const Divider(thickness: 1.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Height',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: RegisterPresenter.heightCont,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'height',
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weight',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: RegisterPresenter.weightCont,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'weight',
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1.0),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Birthday',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: RegisterPresenter.birthdayCont,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ex) 19990828',
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: OutlinedButton(
                  onPressed: controller.submitted,
                  child: const Text('추가하기'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
