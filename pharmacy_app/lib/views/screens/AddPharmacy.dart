import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
//import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pharmacy_app/core/Models/CreatePharmacyDto.dart';
import '../../services/pharmacyServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


class AddPharmacyPage extends StatefulWidget {
  const AddPharmacyPage({super.key});
  @override
  State<AddPharmacyPage> createState() => _AddPharmacyPageState();
}

class _AddPharmacyPageState extends State<AddPharmacyPage> {
  
  List<Map<String,dynamic>> medicines = [];
  List<Map<String,dynamic>> selectedMedicines = [];
  List<Map<String,dynamic>> users = [];
  int? selectedUserId;
  bool loadingData = true;
  
  // Form key + controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  // Appearance colors (dark theme)
  final Color bgColor = const Color(0xFF0F1720); // main background
  final Color cardColor = const Color(0xFF192428); // panels
  final Color fieldColor = const Color(0xFF24323A); // input fill
  final Color accent = const Color(0xFF6EC2FF); // action color

  // Image
  File? _pickedImageFile;        // للموبايل
  Uint8List? _pickedImageBytes;  // للويب

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? xfile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (xfile != null) {
      if (kIsWeb) {
        // في حالة الويب نخزن bytes
        final bytes = await xfile.readAsBytes();
        setState(() {
          _pickedImageBytes = bytes;
        });
      } else {
        // في حالة الموبايل نخزن File
        setState(() {
          _pickedImageFile = File(xfile.path);
        });
      }
    }
  }

  // Add or update medicine in selected list
  void _addMedicine(Map<String, dynamic> med) {
    final int id = med['id'];
    final int stock = med['stock'] ?? 0;
    //final int stock = (med['stock'] is int) ? med['stock'] : int.tryParse('${med['stock']}') ?? 0;

    if (stock <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الكمية يجب أن تكون أكبر من الصفر')),
      );
      return;
    }

    final int idx = selectedMedicines.indexWhere((m) => m['id'] == id);
    if (idx >= 0) {
      // تحديث الكمية
      setState(() => selectedMedicines[idx]['stock'] = stock);
    } else {
      setState(() => selectedMedicines.add({'id': id, 'name': med['name'], 'stock': stock}));
    }
  }

  void _removeSelectedMedicine(int id) {
    setState(() => selectedMedicines.removeWhere((m) => m['id'] == id));
  }

  // Save form (هنا تجمع البيانات وتطبع JSON - يمكنك ارسالها لـ API)
  void _savePharmacy() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedMedicines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب اختيار دواء واحد على الأقل')),
      );
      return;
    }

    if (_pickedImageFile == null && _pickedImageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(
          "يرجى اختيار صورة"
        ))
      );
      return;
    }

    final medicinesJson = jsonEncode(selectedMedicines.map((m) => {
      "MedicineId": m['medicineId'],
      "Stock": m['stock'],
    }).toList());

    CreatepharmacyDto createPharmacyDto = new CreatepharmacyDto();
    createPharmacyDto.Name = _nameCtrl.text.trim();
    createPharmacyDto.Description =  _descCtrl.text.trim();
    createPharmacyDto.Location =  _locationCtrl.text.trim();
    createPharmacyDto.Phone =  _phoneCtrl.text.trim();
    createPharmacyDto.UserId =  selectedUserId!;
    createPharmacyDto.ImageFile =  kIsWeb ? null : _pickedImageFile; // للموبايل فقط
    //imageBytes: kIsWeb ? _pickedImageBytes : null, // للويب فقط
    createPharmacyDto.Medicines =  medicinesJson;

    bool success = await ApiService.addPharmacy(createPharmacyDto);
    
    if (success)
    {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إضافة الصيدلية بنجاح')),
      );

      _nameCtrl.clear();
      _descCtrl.clear();
      _locationCtrl.clear();
      _phoneCtrl.clear();
      setState(() {
        _pickedImageFile = null;
        _pickedImageBytes = null;
        selectedMedicines.clear();
      });  
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('فشل في إضافة الصيدلية')),
      );
    }

    // final Map<String, dynamic> payload = {
    //   'name': _nameCtrl.text.trim(),
    //   'description': _descCtrl.text.trim(),
    //   'location': _locationCtrl.text.trim(),
    //   'phone': _phoneCtrl.text.trim(),
    //   'owner': selectedOwner,
    //   'medicines': selectedMedicines.map((m) => {'medicineId': m['id'], 'stock': m['stock']}).toList(),
    //   // image: يمكنك ارسال الملف ثنائيًا (multipart) لاحقًا
    // };

    // // طباعة للـ debug - في التطبيق الحقيقي ترسل هذه البيانات عبر http
    // debugPrint('Pharmacy payload: ${jsonEncode(payload)}');

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('تم تحضير بيانات الصيدلية (انظر الـ debug console)')),
    // );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _locationCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final meds = await ApiService.getMedicine();
      final user = await ApiService.getUsers();
      setState(() {
        medicines = meds;
        users = user;
        loadingData = false;
      });
    } catch (e) {
      setState(() {
        loadingData = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في جلب البيانات : $e')),
      );
    }
  }
  // Input decoration helper (dark rounded style)
  InputDecoration _inputDecoration(String hint, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: fieldColor,
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // calculate selected container height to show up to 2 items and enable scroll if more
    const double itemHeight = 70.0;
    final int count = selectedMedicines.length;
    final double selectedContainerHeight = (count == 0) ? 60 : (count <= 2 ? count * itemHeight : 2 * itemHeight);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          centerTitle: true,
          title: Text('إنشاء صيدلية جديدة', style: GoogleFonts.cairo(fontSize: 20, color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.menu,color: Colors.white,),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: () {},
            ),
          ],
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- First row: name input + image picker on right (circle) ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        //           GestureDetector(
                        //   onTap: _pickImage,
                        //   child: CircleAvatar(
                        //     radius: 50,
                        //     backgroundColor: Colors.grey[800],
                        //     child: _pickedImageFile == null && _pickedImageBytes == null
                        //         ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
                        //         : ClipRRect(
                        //             borderRadius: BorderRadius.circular(50),
                        //             child: kIsWeb
                        //                 ? Image.memory(_pickedImageBytes!, width: 100, height: 100, fit: BoxFit.cover)
                        //                 : Image.file(_pickedImageFile!, width: 100, height: 100, fit: BoxFit.cover),
                        //           ),
                        //   ),
                        // ),
                      // Image picker circle (يمين)
                      GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: const Color(0xFF2E3B42),
                              child: _pickedImageFile == null && _pickedImageBytes == null
                                  ? Icon(Icons.photo_camera_outlined, color: Colors.grey[300], size: 30)
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(36),
                                      child: kIsWeb
                                            ? Image.memory(_pickedImageBytes!, width: 100, height: 100, fit: BoxFit.cover)
                                            : Image.file(_pickedImageFile!, width: 100, height: 100, fit: BoxFit.cover),
                                    ),
                            ),
                            // small camera badge
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: accent,
                                shape: BoxShape.circle,
                                border: Border.all(color: bgColor, width: 2),
                              ),
                              child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      // Expanded input (name)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text('الاسم التجاري', style: GoogleFonts.cairo(color: Colors.grey[300])),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _nameCtrl,
                              style: const TextStyle(color: Colors.white),
                              decoration: _inputDecoration('الاسم هنا'),
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'الاسم مطلوب' : null,
                            ),
                          ],
                        ),
                      ),
              
                      
              
                      
                    ],
                  ),
              
                  const SizedBox(height: 16),
              
                  // الوصف
                  //Text('الوصف', style: GoogleFonts.cairo(color: Colors.grey[300])),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descCtrl,
                    style: const TextStyle(color: Colors.white),
                    minLines: 1,
                    maxLines: 3,
                    decoration: _inputDecoration('وصف الصيدلية'),
                  ),
              
                  const SizedBox(height: 12),
              
                  // موقع + location icon inside field
                  //Text('عنوان النشاط التجاري', style: GoogleFonts.cairo(color: Colors.grey[300])),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _locationCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputDecoration(
                      'عنوان الالصيدلية',
                      suffix: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 8),
                        child: Icon(Icons.location_on_outlined, color: Colors.grey[350]),
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 12),
              
                  // Phone + optional extra button beside (we'll just have phone field)
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Text('رقم الهاتف', style: GoogleFonts.cairo(color: Colors.grey[300])),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _phoneCtrl,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.phone,
                              decoration: _inputDecoration('رقم الهاتف'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12,),
                      // small plus button (to add additional phones in future)
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFF233136),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
              
                  const SizedBox(height: 12),
              
                  // Owner dropdown
                  //Text('المالك', style: GoogleFonts.cairo(color: Colors.grey[300])),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: fieldColor),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButtonFormField<int>(
                      decoration: const InputDecoration(border: InputBorder.none),
                      hint: Text('اختر المالك', style: TextStyle(color: Colors.grey[10]),),
                      items: users.map((u) {
                        return DropdownMenuItem<int>(value: u['id'], child: Text(u['name']),);
                      }).toList(),
                      
                      //items: owners.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedUserId = value!;
                        });
                      },
                    ),
                  ),
              
                  const SizedBox(height: 18),
              
                  // Available medicines list with quantity & add button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('الأدوية المتاحة', style: GoogleFonts.cairo(fontSize: 18, color: Colors.grey[200])),
                      // optional: add new medicine button
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_box_outlined, color: Colors.grey),
                        label: Text('إضافة دواء', style: TextStyle(color: Colors.grey[400])),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
              
                  // medicines cards
                  Column(
                    children: medicines.map((med) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(med['name'], style: const TextStyle(color: Colors.white)),
                            ),
              
                            // quantity input
                            SizedBox(
                              width: 80,
                              child: TextFormField(
                                //initialValue: 0.toString(),
                                initialValue: (med['stock'] ?? 0).toString(),
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                  filled: true,
                                  fillColor: fieldColor,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                                ),
                                onChanged: (value) {
                                  final stock = int.tryParse(value) ?? 0;
                                  med['stock'] = stock;
                                  // final existing = selectedMedicines.indexWhere((item) => item['medicineId'] == med['id']);

                                  // if (existing >= 0) {
                                  //   selectedMedicines[existing]
                                  //   ['stock'] = stock;
                                  // } else {
                                  //   selectedMedicines.add({
                                  //     "medicineId": med['id'],
                                  //     "stock": stock,
                                  //   });
                                  // }
                                },
                                // onChanged: (val) {
                                //   setState(() => final stock = int.tryParse(val) ?? 0);
                                // },
                              ),
                            ),
              
                            const SizedBox(width: 10),
              
                            // add button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accent,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () => _addMedicine(med),
                              child: const Icon(Icons.add, color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
              
                  const SizedBox(height: 18),
              
                  // Selected medicines container — shows up to 2 items, scrolls if more
                  Text('الأدوية المختارة', style: GoogleFonts.cairo(fontSize: 18, color: Colors.grey[200])),
                  const SizedBox(height: 8),
              
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: selectedContainerHeight,
                      child: selectedMedicines.isEmpty
                          ? Center(child: Text('لا توجد أدوية مختارة', style: TextStyle(color: Colors.grey[400])))
                          : ListView.builder(
                              itemCount: selectedMedicines.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final med = selectedMedicines[index];
                                return Container(
                                  height: itemHeight - 8,
                                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF28333A),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(med['name'], style: const TextStyle(color: Colors.white))),
                                      Text('الكمية: ${med['stock']}', style: const TextStyle(color: Colors.grey)),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                        onPressed: () => _removeSelectedMedicine(med['id']),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
              
                  const SizedBox(height: 26),
              
                  // Save button
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _savePharmacy,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('إنشاء', style: GoogleFonts.cairo(fontSize: 18, color: Colors.black)),
                    ),
                  ),
              
                  const SizedBox(height: 60), // some space for bottom nav look
                ],
              ),
            ),
          ),
        ),

        
      ),
    );
  }
}


