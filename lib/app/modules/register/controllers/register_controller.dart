import 'package:ahnap_peminjam/app/data/constant/endpoint.dart';
import 'package:ahnap_peminjam/app/data/provider/api_provider.dart';
import 'package:ahnap_peminjam/app/modules/book/controllers/book_controller.dart';
import 'package:ahnap_peminjam/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final loading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //final BookController bookController = Get.put(BookController());
  //TODO: Implement RegisterController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  register() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.register,
            data: {
              "nama":namaController.text.toString(),
              "username": usernameController.text.toString(),
              "telp": int.parse(telpController.text.toString()),
              "alamat": alamatController.text.toString(),
              "password": passwordController.text.toString()

            }
        );
        if (response.statusCode == 201) {
          Get.snackbar("selamat", "Anda Berhasil Register");
          Get.offAllNamed(Routes.LOGIN);
        } else {
          Get.snackbar("Soory", "Login Gagal", backgroundColor: Colors.orange);
        }
        loading(false);
      }
    }on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data !=null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Eror", e.toString(), backgroundColor: Colors.red);
    }
  }
}
