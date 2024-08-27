import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LandingPageWidget extends StatefulWidget {
  const LandingPageWidget({super.key});

  @override
  State<LandingPageWidget> createState() => _LandingPageWidgetState();
}

class _LandingPageWidgetState extends State<LandingPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Fetch data da API
  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://gateway.simeal-dev.maggioli.cloud/api/utilizzo-istanze/property-portale/dev'));

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Errore durante la chiamata API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: 100.0,
                height: double.infinity,
                alignment: const AlignmentDirectional(0.0, -1.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          70.0,
                          0.0,
                          32.0,
                        ),
                        child: Container(
                          width: 200.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'SiMeal',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(
                            maxWidth: 570.0,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Inizia',
                                        textAlign: TextAlign.center,
                                      ),
                                      const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          12.0,
                                          0.0,
                                          24.0,
                                        ),
                                        child: Text(
                                          'Per accedere seleziona il comune di appartenenza',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      FutureBuilder<Map<String, dynamic>>(
                                        future: fetchData(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'),
                                            );
                                          } else if (!snapshot.hasData) {
                                            return const Center(
                                              child: Text('No data available'),
                                            );
                                          } else {
                                            final jsonData = snapshot.data!;

                                            final bool abilitaSPID =
                                                jsonData['abilitaSPID'] == 'SI';
                                            final bool abilitaCIEID =
                                                jsonData['abilitaCIEID'] ==
                                                    'SI';
                                            final bool abilitaCNS =
                                                jsonData['abilitaCNS'] == 'SI';

                                            print(
                                                "abilitaSPID${abilitaSPID},${jsonData['abilitaSPID']}");
                                            print(
                                                "abilitaCIEID${abilitaCIEID},${jsonData['abilitaCIEID']}");
                                            print(
                                                "abilitaCNS${abilitaCNS},${jsonData['abilitaCNS']}");

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (abilitaSPID) Container(),
                                                // wrapWithModel(
                                                //   model: _model.spidModel,
                                                //   updateCallback: () => setState(() {}),
                                                //   child: const SpidWidget(),
                                                // ),
                                                if (abilitaCIEID) Container(),
                                                // wrapWithModel(
                                                //   model: _model.cieidModel,
                                                //   updateCallback: () => setState(() {}),
                                                //   child: const CieidWidget(),
                                                // ),
                                                if (abilitaCNS) Container(),
                                                // wrapWithModel(
                                                //   model: _model.cnsModel,
                                                //   updateCallback: () => setState(() {}),
                                                //   child: const CnsWidget(),
                                                // ),
                                                // wrapWithModel(
                                                //   model: _model.credenzialiModel,
                                                //   updateCallback: () => setState(() {}),
                                                //   child: const CredenzialiWidget(),
                                                // ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
