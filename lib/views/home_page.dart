// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, deprecated_member_use, sized_box_for_whitespace, avoid_print, unused_element, unnecessary_cast, unused_import, unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_service/services/via_cep_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  String? _result;
  String? status = 'Favor, informar o cep';
  String? cep = '';
  String? logradouro = '';
  String? complemento = '';
  String? bairro = '';
  String? localidade = '';
  String? uf = '';
  String? ibge = '';
  String? gia = '';
  String? ddd = '';
  String? siafi = '';
  final formKey = GlobalKey<FormState>();

  get child => null;

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUSCADOR DE ENDEREÇO - CEP'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSearchCepTextField(),
            _buildSearchCepButton(),
            _buildResultForm()
          ],
        ),
      ),
    );
  }

  // ************ WIDGETS DO PROJETO ******************************

  Widget _buildSearchCepTextField() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(labelText: 'Informe o Cep'),
      controller: _searchCepController,
      enabled: _enableField,
    );
  }

  Widget _buildSearchCepButton() {
    print('passo 02');
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: RaisedButton(
        onPressed: _searchCep,
        child: _loading
            ? _circularLoading()
            : Text(
                'Consultar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildResultForm() {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Icon(
                Icons.gps_fixed_rounded,
                color: Colors.purple,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    '$status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '               ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$logradouro',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    '$complemento',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    '$bairro',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    '$localidade',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    '$uf',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    '$ddd',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    '$ibge',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Spacer(),
              //Icon(
              //  Icons.arrow_forward_ios_outlined,
              //  size: 15,
              //  color: Colors.green,
              //),
            ],
          ),
        ),
      ),
    );
  }

  Future _searchCep() async {
    // cep recebe o conteudo digitado
    var cep = _searchCepController.text;
    print(cep.length);

    // valida cep
    if (cep.isEmpty || cep == '' || cep.length > 8 || cep.length < 8) {
      print('CEP ESTÁ INCORRETO');

      if (cep.length > 8 || cep.length < 8) {
        status = 'QTD INCORRETO';
      }

      if (cep.isEmpty || cep == '') {
        status = 'favor, informar o cep';
      }

      cep = '';
      logradouro = '';
      complemento = '';
      bairro = '';
      localidade = '';
      uf = '';
      ibge = '';
      gia = '';
      ddd = '';
      siafi = '';
    } else {
      // Validou ok
      _searching(true);
      final resultCep = await ViaCepService.fetchCep(cep: cep);

      setState(() {
        print('JSON DIFERENTE DE NULL');

        _result = resultCep.toJson() as String?;
        status = 'Resultado da busca';
        cep = resultCep.cep;
        logradouro = resultCep.logradouro;
        complemento = resultCep.complemento;
        bairro = resultCep.bairro;
        localidade = resultCep.localidade;
        uf = resultCep.uf;
        ibge = resultCep.ibge;
        gia = resultCep.gia;
        ddd = resultCep.ddd;
        siafi = resultCep.siafi;
      });
    }

    _searching(false);
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }
}
