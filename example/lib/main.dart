import 'package:flutter/material.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  bool _focused = false;

  @override
  void initState() {
    _controller.text = text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - 320;
    final minHeight = _focused ? 320.0 + 45 + 6 : 320.0;
    var maxHeight = _focused ? height + 45 + 6 : height;
    if (maxHeight < minHeight) {
      maxHeight = minHeight;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            color: Colors.blue,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TextField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Switch(
                        value: _focused,
                        inactiveTrackColor: Colors.blue,
                        activeTrackColor: Colors.green,
                        activeColor: Colors.white,
                        trackOutlineColor: MaterialStateProperty.all(_focused ? Colors.green : Colors.blue),
                        trackOutlineWidth: MaterialStateProperty.all(10),
                        thumbIcon: MaterialStateProperty.all(Icon(
                          _focused ? Icons.edit : Icons.visibility,
                          color: _focused ? Colors.green : Colors.blue,
                        )),
                        onChanged: (value) => setState(() => _focused = value),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: minHeight,
                      maxHeight: maxHeight,
                    ),
                    child: MarkdownAutoPreview(
                      expands: true,
                      controller: _controller,
                      enableToolBar: _focused,
                      focused: _focused,
                      toolbarGap: 6,
                      showPreviewButton: false,
                      showClearButton: false,
                      showResetButton: false,
                      showSelectSingleLine: false,
                      showEmojiSelection: false,
                      showLinkInput: false,
                      showImageInput: false,
                      enableOnTapFocus: false,
                      onFocusChanged: (value) => setState(() => _focused = value),
                      previewPadding: const EdgeInsets.all(12),
                      previewDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey),
                      ),
                      toolbarDecoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      decoration: const InputDecoration(
                        isDense: false,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const text = """
### Terms and Conditions of Use
Welcome to MobileAP, a mobile application-based platform to access your electricity bills, payments, and consumption charts (the "App Service"). Visayan Electric, Davao Light, Cotabato Light, Subic EnerZone, and Lima EnerZone (each, a DU") provide this App Service to you subject to the following terms and conditions ("Terms and Conditions") below. By accepting the Terms and Conditions, you are deemed to have understood, agreed, and accepted these Terms and Conditions to be the legal and effective equivalent of a signed written contract, between you and your DU. For this reason, please read and understand the Terms and Conditions carefully.

### Basis of the Service
The App Service is offered in line with your existing service agreement with your DU. By using this App Service, you hereby represent and acknowledge that you are the registered customer of the account linked to this App Service.
Furthermore, by electing to use the App Service, electricity bills and/or other communications from the DU to you shall be conveyed and accessed by you through the App Service. These other communications include but are not limited to advisories, announcements, statements of account, requests, and notices and other information such as payment history, consumption charts and payment options, among others. As such, you agree that your use of the App Service and the bills you receive from the App Service shall be in lieu of paper bills.
The App Service shall be supplied on an as-is basis without any express or implied warranties except for those as may be provided by Philippine law. You agree to hold your DU and its directors, officers, employees, and agents free and harmless from any and all claims, actions, or liabilities arising out of or in connection with the performance and use of the App Service and which may be brought against the DU by you or anyone on your behalf, your directors, officers or other representatives, as may be applicable.

### Customer Obligations
It is your responsibility to:
* regularly check and monitor all notifications and communications sent through the App Service;
* ensure connectivity and capability to allow receipt of all notifications and communications;
* keep log-in and security credentials strictly confidential and prevent their unauthorized access or use;
* provide complete and accurate information as may be required by the DU to update contact details, whenever necessary. If your contact details are not updated, the DU shall not be liable for the non-payment of bills due to non-receipt of bills under the App Service;
* pay the amount due on or before the due date. Non-receipt of the bill due to non-compliance with your obligations shall not suspend the running of the prescribed period for payment; and
* cancel your registration and use of the App Service if you are no longer authorized to receive the bills or other communications under the App Service or if you cease to be the actual user of the electric service.
The DU reserves the right to make changes to the App Service without prior notice and to terminate your registration and use of the App Service in case you violate these Terms and Conditions.

### Rule on Receipt
Your current bill will be available monthly after your scheduled bill reading schedule. You shall be presumed to have received the electronic bill and/or other forms of communication that are conveyed through or under the App Service, unless you notify your DU of such non-receipt within five (5) days from the scheduled delivery of such bill and/or communication. Upon receipt of such notice, your DU shall immediately resend your bill to you.

### Data Privacy
Please review our Data Privacy Policy through this [_DU-specific data privacy link_], which shall also govern your visit to and use of the App Service. In addition to the Data Privacy Policy, you hereby agree to maintain and keep confidential any information required for the use of the App Service, including your Customer Account Identification. You shall not use or permit the use of your Customer Account Identification, username, and password, and the App Service in whole or in part for any purpose, whether legal or illegal, other than those expressly allowed under these Terms and Conditions. If you become aware of any unauthorized or unlawful use of such information, it is your responsibility to notify the DU immediately.
In all cases, your DU shall not be responsible for any damage or breach of information arising from the unauthorized or unlawful use of the App Service, or the improper use of, or access to, the App Service or your Customer Account Identification.

### Service Access
At certain times, the App Service may not be available due to system maintenance or Force Majeure (as hereinafter defined). Your DU will not be liable for any loss or damages arising from the whole or partial unavailability of the App Service due to these causes. Force Majeure shall mean a cause beyond the reasonable control of the DU or that is not foreseeable, is unavoidable, and is not due to negligence or lack of care on the part of the DU;and Force Majeure includes acts of God, public enemy, wars or revolutions, riots, freight embargoes, fires, explosions, sabotages, floods, epidemics, quarantine restrictions, accidents, typhoons, labor disputes, strikes or lockouts, orders, restraints or prohibitions by any government authorities and other causes analogous or similar to the foregoing.

### Interpretation
These Terms and Conditions shall supplement but not replace your existing electric service agreement between you and your DU. All the terms and conditions of such electric service agreement shall remain effective and only modified to the extent these are inconsistent with these Terms and Conditions. If there is any conflict or inconsistency between these Terms and Conditions and the electric service agreement, the provisions of the latter shall prevail.

### Modifications or Changes
Your DU reserves the right to make changes to the MobileAP, the application itself, and the App Service, and the right to vary these Terms and Conditions at any time and for any reason, and your continued use of the App Service following any variation or modifications will be deemed to constitute an acceptance thereof.

### Property Rights
The App Service and its overall design are the exclusive property of the DUs and Aboitiz Power Corporation. Except as otherwise provided under these Terms and Conditions, you do not have any intellectual property rights in MobileAP and the App Service.

### Severability
If any one or more of the provisions of these Terms and Conditions is held to be invalid, illegal or unenforceable, the validity, legality or enforceability of the remaining provisions of these Terms and Conditions will not be affected. To the extent permitted by applicable law, you waive any provision of law that renders any provision of these Terms and Conditions invalid, illegal or unenforceable in any respect.

### Existing Obligations
The obligations contained in these Terms and Conditions are in addition to, and do not in any way limit, any of your existing obligations to your DU under any other existing contract or otherwise.

### Miscellaneous
You shall not assign or transfer any of your rights and obligations under these Terms and Conditions without the prior written consent of your DU. By accepting the Terms and Conditions of the App Service and/or continuing to use the App Service, you agree that the laws of the Republic of the Philippines shall govern these Terms and Conditions and any dispute of any sort between you and your DU.
Any dispute in any way related to the App Service or the interpretation of the Terms and Conditions shall be exclusively settled and/or litigated in the proper courts of the City of Taguig, to the exclusion of all other courts elsewhere situated.
""";
