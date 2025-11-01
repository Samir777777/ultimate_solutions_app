import 'package:flutter/material.dart';

class ChooseLanguageDialog extends StatefulWidget {
  @override
  _ChooseLanguageDialogState createState() => _ChooseLanguageDialogState();
}

class _ChooseLanguageDialogState extends State<ChooseLanguageDialog> {
  String _selectedLang = 'en';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.all(28),
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose Language',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[900]
                ),
              ),
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() { _selectedLang = 'ar'; }),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedLang == 'ar' ? Color(0xffECFDF3) : Colors.white,
                        border: Border.all(
                          color: _selectedLang == 'ar' ? Colors.green : Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/saudi.png', width: 22, height: 22),
                              SizedBox(width: 6),
                              Text('العربية', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text('Arabic', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() { _selectedLang = 'en'; }),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedLang == 'en' ? Color(0xffECFDF3) : Colors.white,
                        border: Border.all(
                          color: _selectedLang == 'en' ? Colors.green : Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/uk.png', width: 22, height: 22),
                              SizedBox(width: 6),
                              Text('English', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text('English', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_selectedLang);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color(0xff13505B),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text('Apply', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
