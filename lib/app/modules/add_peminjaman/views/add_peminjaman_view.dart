import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_peminjaman_controller.dart';

class AddPeminjamanView extends GetView<AddPeminjamanController> {
  const AddPeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pinjam Buku ${Get.parameters['judul'].toString()}'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: controller.tanggalPinjamController,
                  decoration: InputDecoration(hintText: "Masukkan tanggal pinjam"),
                  validator: (value){
                    if (value!.length <5){
                      return "tanggal tidak boleh kosong";
                    }
                    return null;
                  }
              ),
              TextFormField(
                  controller: controller.tanggalKembaliController,
                  decoration: InputDecoration(hintText: "Masukkan tanggal kembali"),
                  validator: (value){
                    if (value!.length <5){
                      return "tanggal tidak boleh kosong";
                    }
                    return null;
                  }
              ),
              Obx(() => controller.loading.value?
              CircularProgressIndicator():
              ElevatedButton(onPressed: () {
                controller.post();
              }, child: Text("Pinjam"))
              )
            ],
          ),
        ),
      ),
    );
  }
}
