import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/custom_widgets.dart';

/// Model untuk Address
class ShippingAddress {
  final int? id;
  final String label;
  final String recipientName;
  final String phone;
  final String address;
  final String? city;
  final String? postalCode;
  final bool isDefault;

  ShippingAddress({
    this.id,
    required this.label,
    required this.recipientName,
    required this.phone,
    required this.address,
    this.city,
    this.postalCode,
    this.isDefault = false,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      label: json['label']?.toString() ?? 'Alamat',
      recipientName: json['recipient_name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      city: json['city']?.toString(),
      postalCode: json['postal_code']?.toString(),
      isDefault: json['is_default'] == true || json['is_default'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'label': label,
      'recipient_name': recipientName,
      'phone': phone,
      'address': address,
      'city': city,
      'postal_code': postalCode,
      'is_default': isDefault,
    };
  }
}

/// Screen Kelola Alamat Pengiriman
class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final ApiService _apiService = ApiService();
  List<ShippingAddress> _addresses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    setState(() => _isLoading = true);
    
    // For now, use local placeholder data
    // In production, fetch from API
    await Future.delayed(const Duration(milliseconds: 500));
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;
    
    // Create default address from user profile if available
    if (user != null && user.address != null && user.address!.isNotEmpty) {
      _addresses = [
        ShippingAddress(
          id: 1,
          label: 'Rumah',
          recipientName: user.name,
          phone: user.phone ?? '',
          address: user.address!,
          isDefault: true,
        ),
      ];
    } else {
      _addresses = [];
    }
    
    setState(() => _isLoading = false);
  }

  void _showAddEditDialog({ShippingAddress? address}) {
    final isEditing = address != null;
    final labelController = TextEditingController(text: address?.label ?? '');
    final nameController = TextEditingController(text: address?.recipientName ?? '');
    final phoneController = TextEditingController(text: address?.phone ?? '');
    final addressController = TextEditingController(text: address?.address ?? '');
    final cityController = TextEditingController(text: address?.city ?? '');
    final postalCodeController = TextEditingController(text: address?.postalCode ?? '');
    bool isDefault = address?.isDefault ?? false;
    
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEditing ? 'Edit Alamat' : 'Tambah Alamat Baru',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Form
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Label
                        const Text(
                          'Label Alamat',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildLabelChip('Rumah', labelController, setModalState),
                            const SizedBox(width: 8),
                            _buildLabelChip('Kantor', labelController, setModalState),
                            const SizedBox(width: 8),
                            _buildLabelChip('Kos', labelController, setModalState),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        CustomTextField(
                          controller: labelController,
                          label: 'Atau ketik label lain',
                          hint: 'Contoh: Apartemen',
                          prefixIcon: Icons.label_outline,
                        ),
                        const SizedBox(height: 16),
                        
                        CustomTextField(
                          controller: nameController,
                          label: 'Nama Penerima',
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama penerima wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        CustomTextField(
                          controller: phoneController,
                          label: 'Nomor Telepon',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nomor telepon wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        CustomTextField(
                          controller: addressController,
                          label: 'Alamat Lengkap',
                          hint: 'Nama jalan, nomor rumah, RT/RW, dll',
                          prefixIcon: Icons.location_on_outlined,
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Alamat lengkap wajib diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: cityController,
                                label: 'Kota/Kabupaten',
                                prefixIcon: Icons.location_city_outlined,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomTextField(
                                controller: postalCodeController,
                                label: 'Kode Pos',
                                prefixIcon: Icons.markunread_mailbox_outlined,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // Default checkbox
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDefault ? AppColors.primary : Colors.grey.shade300,
                            ),
                          ),
                          child: CheckboxListTile(
                            value: isDefault,
                            onChanged: (value) {
                              setModalState(() {
                                isDefault = value ?? false;
                              });
                            },
                            title: const Text('Jadikan alamat utama'),
                            subtitle: const Text('Alamat ini akan digunakan secara default'),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Save button
                        CustomButton(
                          text: isEditing ? 'Simpan Perubahan' : 'Tambah Alamat',
                          icon: Icons.save,
                          width: double.infinity,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final newAddress = ShippingAddress(
                                id: address?.id,
                                label: labelController.text.isNotEmpty 
                                    ? labelController.text 
                                    : 'Alamat',
                                recipientName: nameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                city: cityController.text,
                                postalCode: postalCodeController.text,
                                isDefault: isDefault,
                              );
                              
                              Navigator.pop(context);
                              _saveAddress(newAddress, isEditing);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelChip(String label, TextEditingController controller, StateSetter setModalState) {
    final isSelected = controller.text == label;
    return GestureDetector(
      onTap: () {
        setModalState(() {
          controller.text = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Future<void> _saveAddress(ShippingAddress address, bool isEditing) async {
    // TODO: Implement API call to save address
    // For now, just update local state
    setState(() {
      if (isEditing) {
        final index = _addresses.indexWhere((a) => a.id == address.id);
        if (index >= 0) {
          _addresses[index] = address;
        }
      } else {
        // If this is set as default, unset others
        if (address.isDefault) {
          _addresses = _addresses.map((a) => ShippingAddress(
            id: a.id,
            label: a.label,
            recipientName: a.recipientName,
            phone: a.phone,
            address: a.address,
            city: a.city,
            postalCode: a.postalCode,
            isDefault: false,
          )).toList();
        }
        _addresses.add(ShippingAddress(
          id: DateTime.now().millisecondsSinceEpoch,
          label: address.label,
          recipientName: address.recipientName,
          phone: address.phone,
          address: address.address,
          city: address.city,
          postalCode: address.postalCode,
          isDefault: address.isDefault,
        ));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(isEditing ? 'Alamat berhasil diperbarui' : 'Alamat baru ditambahkan'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _deleteAddress(ShippingAddress address) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Alamat?'),
        content: Text('Apakah Anda yakin ingin menghapus alamat "${address.label}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // TODO: Implement API call to delete address
      setState(() {
        _addresses.removeWhere((a) => a.id == address.id);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Alamat berhasil dihapus'),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  void _setAsDefault(ShippingAddress address) {
    setState(() {
      _addresses = _addresses.map((a) => ShippingAddress(
        id: a.id,
        label: a.label,
        recipientName: a.recipientName,
        phone: a.phone,
        address: a.address,
        city: a.city,
        postalCode: a.postalCode,
        isDefault: a.id == address.id,
      )).toList();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Alamat utama berhasil diubah'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: const Text('Alamat Pengiriman'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _addresses.isEmpty
              ? _buildEmptyState()
              : _buildAddressList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEditDialog(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Tambah Alamat', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_off_outlined,
                size: 64,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Belum Ada Alamat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tambahkan alamat pengiriman untuk mempermudah proses checkout',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Tambah Alamat Pertama',
              icon: Icons.add_location_alt,
              onPressed: () => _showAddEditDialog(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _addresses.length,
      itemBuilder: (context, index) {
        final address = _addresses[index];
        return _buildAddressCard(address);
      },
    );
  }

  Widget _buildAddressCard(ShippingAddress address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: address.isDefault
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: address.isDefault
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            address.label.toLowerCase() == 'rumah'
                                ? Icons.home
                                : address.label.toLowerCase() == 'kantor'
                                    ? Icons.business
                                    : Icons.location_on,
                            size: 14,
                            color: address.isDefault ? Colors.white : AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            address.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: address.isDefault ? Colors.white : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (address.isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Utama',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            _showAddEditDialog(address: address);
                            break;
                          case 'default':
                            _setAsDefault(address);
                            break;
                          case 'delete':
                            _deleteAddress(address);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 20),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        if (!address.isDefault)
                          const PopupMenuItem(
                            value: 'default',
                            child: Row(
                              children: [
                                Icon(Icons.star_outline, size: 20),
                                SizedBox(width: 8),
                                Text('Jadikan Utama'),
                              ],
                            ),
                          ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline, size: 20, color: AppColors.error),
                              SizedBox(width: 8),
                              Text('Hapus', style: TextStyle(color: AppColors.error)),
                            ],
                          ),
                        ),
                      ],
                      icon: Icon(Icons.more_vert, color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Recipient info
                Text(
                  address.recipientName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address.phone,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Address
                Text(
                  address.address,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
                if (address.city != null && address.city!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${address.city}${address.postalCode != null ? ' ${address.postalCode}' : ''}',
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
